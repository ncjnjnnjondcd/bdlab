/*
  Warnings:

  - You are about to drop the column `phone` on the `suppliers` table. All the data in the column will be lost.

*/
-- AlterTable
ALTER TABLE "suppliers" DROP COLUMN "phone",
ADD COLUMN     "number" VARCHAR(50);
