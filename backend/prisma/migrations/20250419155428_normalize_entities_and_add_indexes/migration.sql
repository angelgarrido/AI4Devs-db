/*
  Warnings:

  - You are about to drop the column `status` on the `Application` table. All the data in the column will be lost.
  - You are about to drop the column `address` on the `Candidate` table. All the data in the column will be lost.
  - You are about to drop the column `companyDescription` on the `Position` table. All the data in the column will be lost.
  - You are about to drop the column `contactInfo` on the `Position` table. All the data in the column will be lost.
  - You are about to drop the column `employmentType` on the `Position` table. All the data in the column will be lost.
  - You are about to drop the column `location` on the `Position` table. All the data in the column will be lost.
  - You are about to drop the column `status` on the `Position` table. All the data in the column will be lost.
  - Added the required column `statusId` to the `Application` table without a default value. This is not possible if the table is not empty.
  - Added the required column `addressId` to the `Position` table without a default value. This is not possible if the table is not empty.
  - Added the required column `employmentTypeId` to the `Position` table without a default value. This is not possible if the table is not empty.
  - Added the required column `statusId` to the `Position` table without a default value. This is not possible if the table is not empty.

*/
-- AlterTable
ALTER TABLE "Application" DROP COLUMN "status",
ADD COLUMN     "statusId" INTEGER NOT NULL;

-- AlterTable
ALTER TABLE "Candidate" DROP COLUMN "address",
ADD COLUMN     "addressId" INTEGER;

-- AlterTable
ALTER TABLE "Company" ADD COLUMN     "description" TEXT;

-- AlterTable
ALTER TABLE "Position" DROP COLUMN "companyDescription",
DROP COLUMN "contactInfo",
DROP COLUMN "employmentType",
DROP COLUMN "location",
DROP COLUMN "status",
ADD COLUMN     "addressId" INTEGER NOT NULL,
ADD COLUMN     "employmentTypeId" INTEGER NOT NULL,
ADD COLUMN     "statusId" INTEGER NOT NULL;

-- CreateTable
CREATE TABLE "StatusType" (
    "id" SERIAL NOT NULL,
    "name" VARCHAR(50) NOT NULL,
    "category" VARCHAR(50) NOT NULL,

    CONSTRAINT "StatusType_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "Address" (
    "id" SERIAL NOT NULL,
    "street" VARCHAR(100) NOT NULL,
    "city" VARCHAR(100) NOT NULL,
    "state" VARCHAR(100),
    "country" VARCHAR(100) NOT NULL,
    "postalCode" VARCHAR(20),

    CONSTRAINT "Address_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "EmploymentType" (
    "id" SERIAL NOT NULL,
    "name" VARCHAR(50) NOT NULL,

    CONSTRAINT "EmploymentType_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "ContactInfo" (
    "id" SERIAL NOT NULL,
    "email" VARCHAR(255),
    "phone" VARCHAR(20),
    "positionId" INTEGER NOT NULL,

    CONSTRAINT "ContactInfo_pkey" PRIMARY KEY ("id")
);

-- CreateIndex
CREATE UNIQUE INDEX "ContactInfo_positionId_key" ON "ContactInfo"("positionId");

-- CreateIndex
CREATE INDEX "Application_positionId_idx" ON "Application"("positionId");

-- CreateIndex
CREATE INDEX "Application_candidateId_idx" ON "Application"("candidateId");

-- CreateIndex
CREATE INDEX "Application_statusId_idx" ON "Application"("statusId");

-- CreateIndex
CREATE INDEX "Application_applicationDate_idx" ON "Application"("applicationDate");

-- CreateIndex
CREATE INDEX "Candidate_email_idx" ON "Candidate"("email");

-- CreateIndex
CREATE INDEX "Candidate_addressId_idx" ON "Candidate"("addressId");

-- CreateIndex
CREATE INDEX "Education_candidateId_idx" ON "Education"("candidateId");

-- CreateIndex
CREATE INDEX "Employee_companyId_idx" ON "Employee"("companyId");

-- CreateIndex
CREATE INDEX "Employee_email_idx" ON "Employee"("email");

-- CreateIndex
CREATE INDEX "Interview_applicationId_idx" ON "Interview"("applicationId");

-- CreateIndex
CREATE INDEX "Interview_interviewStepId_idx" ON "Interview"("interviewStepId");

-- CreateIndex
CREATE INDEX "Interview_employeeId_idx" ON "Interview"("employeeId");

-- CreateIndex
CREATE INDEX "Interview_interviewDate_idx" ON "Interview"("interviewDate");

-- CreateIndex
CREATE INDEX "InterviewStep_interviewFlowId_idx" ON "InterviewStep"("interviewFlowId");

-- CreateIndex
CREATE INDEX "InterviewStep_orderIndex_idx" ON "InterviewStep"("orderIndex");

-- CreateIndex
CREATE INDEX "Position_companyId_statusId_idx" ON "Position"("companyId", "statusId");

-- CreateIndex
CREATE INDEX "Position_addressId_idx" ON "Position"("addressId");

-- CreateIndex
CREATE INDEX "Position_employmentTypeId_idx" ON "Position"("employmentTypeId");

-- CreateIndex
CREATE INDEX "Position_applicationDeadline_idx" ON "Position"("applicationDeadline");

-- CreateIndex
CREATE INDEX "Position_isVisible_idx" ON "Position"("isVisible");

-- CreateIndex
CREATE INDEX "Resume_candidateId_idx" ON "Resume"("candidateId");

-- CreateIndex
CREATE INDEX "WorkExperience_candidateId_idx" ON "WorkExperience"("candidateId");

-- AddForeignKey
ALTER TABLE "ContactInfo" ADD CONSTRAINT "ContactInfo_positionId_fkey" FOREIGN KEY ("positionId") REFERENCES "Position"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "Candidate" ADD CONSTRAINT "Candidate_addressId_fkey" FOREIGN KEY ("addressId") REFERENCES "Address"("id") ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "Position" ADD CONSTRAINT "Position_addressId_fkey" FOREIGN KEY ("addressId") REFERENCES "Address"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "Position" ADD CONSTRAINT "Position_employmentTypeId_fkey" FOREIGN KEY ("employmentTypeId") REFERENCES "EmploymentType"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "Position" ADD CONSTRAINT "Position_statusId_fkey" FOREIGN KEY ("statusId") REFERENCES "StatusType"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "Application" ADD CONSTRAINT "Application_statusId_fkey" FOREIGN KEY ("statusId") REFERENCES "StatusType"("id") ON DELETE RESTRICT ON UPDATE CASCADE;
