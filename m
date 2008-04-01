Return-Path: <12o3l@tiscali.nl>
Received: from smtp-out2.tiscali.nl (smtp-out2.tiscali.nl [195.241.79.177])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 6B72EDE05B
	for <linuxppc-dev@ozlabs.org>; Wed,  2 Apr 2008 04:31:19 +1100 (EST)
Message-ID: <47F27155.1000103@tiscali.nl>
Date: Tue, 01 Apr 2008 19:31:01 +0200
From: Roel Kluin <12o3l@tiscali.nl>
MIME-Version: 1.0
To: paulus@samba.org
Subject: [PATCH 2/8] powerpc: replace `__attribute' by `__attribute__'
References: <47F26FF6.8070300@tiscali.nl>
In-Reply-To: <47F26FF6.8070300@tiscali.nl>
Content-Type: text/plain; charset=ISO-8859-1
Cc: linuxppc-dev@ozlabs.org, trivial@kernel.org,
	lkml <linux-kernel@vger.kernel.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

replace `__attribute' by `__attribute__'

Signed-off-by: Roel Kluin <12o3l@tiscali.nl>
---
diff --git a/arch/powerpc/platforms/iseries/main_store.h b/arch/powerpc/platforms/iseries/main_store.h
index 1a7a3f5..976b23e 100644
--- a/arch/powerpc/platforms/iseries/main_store.h
+++ b/arch/powerpc/platforms/iseries/main_store.h
@@ -61,7 +61,7 @@ struct IoHriMainStoreSegment4 {
 };
 
 /* Main Store VPD for Power4 */
-struct __attribute((packed)) IoHriMainStoreChipInfo1 {
+struct __attribute__((packed)) IoHriMainStoreChipInfo1 {
 	u32	chipMfgID;
 	char	chipECLevel[4];
 };
@@ -73,14 +73,14 @@ struct IoHriMainStoreVpdIdData {
 	char	serialNumber[12];
 };
 
-struct	__attribute((packed)) IoHriMainStoreVpdFruData {
+struct	__attribute__((packed)) IoHriMainStoreVpdFruData {
 	char	fruLabel[8];
 	u8	numberOfSlots;
 	u8	pluggingType;
 	u16	slotMapIndex;
 };
 
-struct  __attribute((packed)) IoHriMainStoreAdrRangeBlock {
+struct  __attribute__((packed)) IoHriMainStoreAdrRangeBlock {
 	void	*blockStart;
 	void	*blockEnd;
 	u32	blockProcChipId;
@@ -88,7 +88,7 @@ struct  __attribute((packed)) IoHriMainStoreAdrRangeBlock {
 
 #define MaxAreaAdrRangeBlocks 4
 
-struct __attribute((packed)) IoHriMainStoreArea4 {
+struct __attribute__((packed)) IoHriMainStoreArea4 {
 	u32	msVpdFormat;
 	u8	containedVpdType;
 	u8	reserved1;
