Return-Path: <sfr@canb.auug.org.au>
Received: from smtps.tip.net.au (chilli.pcug.org.au [203.10.76.44])
	by ozlabs.org (Postfix) with ESMTP id 1F90467B5E
	for <linuxppc-dev@ozlabs.org>; Wed, 16 Aug 2006 15:20:41 +1000 (EST)
Date: Wed, 16 Aug 2006 15:20:32 +1000
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: paulus@samba.org
Subject: [POWERPC] iseries: remove some gcc 4.1 warnings
Message-Id: <20060816152032.2407a832.sfr@canb.auug.org.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: ppc-dev <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

gcc 4.1 produces some warnings that it is ignoring the packed attribute
on some structure elements, so just remove them.

Signed-off-by: Stephen Rothwell <sfr@canb.auug.org.au>
---
 arch/powerpc/platforms/iseries/main_store.h |   46 ++++++++++++++-------------
 1 files changed, 23 insertions(+), 23 deletions(-)

-- 
Cheers,
Stephen Rothwell                    sfr@canb.auug.org.au
http://www.canb.auug.org.au/~sfr/

diff --git a/arch/powerpc/platforms/iseries/main_store.h b/arch/powerpc/platforms/iseries/main_store.h
index 74f6889..4b31658 100644
--- a/arch/powerpc/platforms/iseries/main_store.h
+++ b/arch/powerpc/platforms/iseries/main_store.h
@@ -63,7 +63,7 @@ struct IoHriMainStoreSegment4 {
 /* Main Store VPD for Power4 */
 struct IoHriMainStoreChipInfo1 {
 	u32	chipMfgID	__attribute((packed));
-	char	chipECLevel[4]	__attribute((packed));
+	char	chipECLevel[4];
 };
 
 struct IoHriMainStoreVpdIdData {
@@ -74,9 +74,9 @@ struct IoHriMainStoreVpdIdData {
 };
 
 struct IoHriMainStoreVpdFruData {
-	char	fruLabel[8]	__attribute((packed));
-	u8	numberOfSlots	__attribute((packed));
-	u8	pluggingType	__attribute((packed));
+	char	fruLabel[8];
+	u8	numberOfSlots;
+	u8	pluggingType;
 	u16	slotMapIndex	__attribute((packed));
 };
 
@@ -90,8 +90,8 @@ #define MaxAreaAdrRangeBlocks 4
 
 struct IoHriMainStoreArea4 {
 	u32	msVpdFormat			__attribute((packed));
-	u8	containedVpdType		__attribute((packed));
-	u8	reserved1			__attribute((packed));
+	u8	containedVpdType;
+	u8	reserved1;
 	u16	reserved2			__attribute((packed));
 
 	u64	msExists			__attribute((packed));
@@ -101,16 +101,16 @@ struct IoHriMainStoreArea4 {
 	u32	procNodeId			__attribute((packed));
 
 	u32	numAdrRangeBlocks		__attribute((packed));
-	struct IoHriMainStoreAdrRangeBlock xAdrRangeBlock[MaxAreaAdrRangeBlocks]	__attribute((packed));
+	struct IoHriMainStoreAdrRangeBlock xAdrRangeBlock[MaxAreaAdrRangeBlocks];
 
-	struct IoHriMainStoreChipInfo1	chipInfo0	__attribute((packed));
-	struct IoHriMainStoreChipInfo1	chipInfo1	__attribute((packed));
-	struct IoHriMainStoreChipInfo1	chipInfo2	__attribute((packed));
-	struct IoHriMainStoreChipInfo1	chipInfo3	__attribute((packed));
-	struct IoHriMainStoreChipInfo1	chipInfo4	__attribute((packed));
-	struct IoHriMainStoreChipInfo1	chipInfo5	__attribute((packed));
-	struct IoHriMainStoreChipInfo1	chipInfo6	__attribute((packed));
-	struct IoHriMainStoreChipInfo1	chipInfo7	__attribute((packed));
+	struct IoHriMainStoreChipInfo1	chipInfo0;
+	struct IoHriMainStoreChipInfo1	chipInfo1;
+	struct IoHriMainStoreChipInfo1	chipInfo2;
+	struct IoHriMainStoreChipInfo1	chipInfo3;
+	struct IoHriMainStoreChipInfo1	chipInfo4;
+	struct IoHriMainStoreChipInfo1	chipInfo5;
+	struct IoHriMainStoreChipInfo1	chipInfo6;
+	struct IoHriMainStoreChipInfo1	chipInfo7;
 
 	void	*msRamAreaArray			__attribute((packed));
 	u32	msRamAreaArrayNumEntries	__attribute((packed));
@@ -122,22 +122,22 @@ struct IoHriMainStoreArea4 {
 	u32	numaDimmArrayNumEntries		__attribute((packed));
 	u32	numaDimmArrayEntrySize		__attribute((packed));
 
-	struct IoHriMainStoreVpdIdData idData	__attribute((packed));
+	struct IoHriMainStoreVpdIdData idData;
 
 	u64	powerData			__attribute((packed));
 	u64	cardAssemblyPartNum		__attribute((packed));
 	u64	chipSerialNum			__attribute((packed));
 
 	u64	reserved3			__attribute((packed));
-	char	reserved4[16]			__attribute((packed));
+	char	reserved4[16];
 
-	struct IoHriMainStoreVpdFruData fruData	__attribute((packed));
+	struct IoHriMainStoreVpdFruData fruData;
 
-	u8	vpdPortNum			__attribute((packed));
-	u8	reserved5			__attribute((packed));
-	u8	frameId				__attribute((packed));
-	u8	rackUnit			__attribute((packed));
-	char	asciiKeywordVpd[256]		__attribute((packed));
+	u8	vpdPortNum;
+	u8	reserved5;
+	u8	frameId;
+	u8	rackUnit;
+	char	asciiKeywordVpd[256];
 	u32	reserved6			__attribute((packed));
 };
 
-- 
1.4.1.1
