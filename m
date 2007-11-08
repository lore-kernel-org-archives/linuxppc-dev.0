Return-Path: <mgreer@mvista.com>
Date: Wed, 7 Nov 2007 18:58:22 -0700
From: "Mark A. Greer" <mgreer@mvista.com>
To: linuxppc-dev <Linuxppc-dev@ozlabs.org>
Subject: [PATCH 3/3] powerpc: mv64x60 - Aesthetic fixups for bootwrapper code
Message-ID: <20071108015822.GB15174@mag.az.mvista.com>
References: <20071108015415.GA14900@mag.az.mvista.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20071108015415.GA14900@mag.az.mvista.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

From: Mark A. Greer <mgreer@mvista.com>

Specify locations when initializing arrays.  This has already been done
for one array so may as well do it for them all.

Signed-off-by: Mark A. Greer <mgreer@mvista.com>

---
I don't know if this one is worth the bother (it is a little anal)
but it keeps things consistent.  I'm happy with or without it.

 arch/powerpc/boot/mv64x60.c |   72 +++++++++++++++++-----------------
 1 file changed, 36 insertions(+), 36 deletions(-)

diff --git a/arch/powerpc/boot/mv64x60.c b/arch/powerpc/boot/mv64x60.c
index ddddc3f..d207a0b 100644
--- a/arch/powerpc/boot/mv64x60.c
+++ b/arch/powerpc/boot/mv64x60.c
@@ -174,11 +174,11 @@ struct {
 	u32 addr;
 	u32 data;
 } static mv64x60_pci_cfgio[2] = {
-	{ /* hose 0 */
+	[0] = { /* hose 0 */
 		.addr	= 0xcf8,
 		.data	= 0xcfc,
 	},
-	{ /* hose 1 */
+	[1] = { /* hose 1 */
 		.addr	= 0xc78,
 		.data	= 0xc7c,
 	}
@@ -201,76 +201,76 @@ void mv64x60_cfg_write(u8 *bridge_base, u8 hose, u8 bus, u8 devfn, u8 offset,
 
 /* I/O ctlr -> system memory setup */
 static struct mv64x60_mem_win mv64x60_cpu2mem[MV64x60_CPU2MEM_WINDOWS] = {
-	{
+	[0] = {
 		.lo	= MV64x60_CPU2MEM_0_BASE,
 		.size	= MV64x60_CPU2MEM_0_SIZE,
 	},
-	{
+	[1] = {
 		.lo	= MV64x60_CPU2MEM_1_BASE,
 		.size	= MV64x60_CPU2MEM_1_SIZE,
 	},
-	{
+	[2] = {
 		.lo	= MV64x60_CPU2MEM_2_BASE,
 		.size	= MV64x60_CPU2MEM_2_SIZE,
 	},
-	{
+	[3] = {
 		.lo	= MV64x60_CPU2MEM_3_BASE,
 		.size	= MV64x60_CPU2MEM_3_SIZE,
 	},
 };
 
 static struct mv64x60_mem_win mv64x60_enet2mem[MV64x60_CPU2MEM_WINDOWS] = {
-	{
+	[0] = {
 		.lo	= MV64x60_ENET2MEM_0_BASE,
 		.size	= MV64x60_ENET2MEM_0_SIZE,
 	},
-	{
+	[1] = {
 		.lo	= MV64x60_ENET2MEM_1_BASE,
 		.size	= MV64x60_ENET2MEM_1_SIZE,
 	},
-	{
+	[2] = {
 		.lo	= MV64x60_ENET2MEM_2_BASE,
 		.size	= MV64x60_ENET2MEM_2_SIZE,
 	},
-	{
+	[3] = {
 		.lo	= MV64x60_ENET2MEM_3_BASE,
 		.size	= MV64x60_ENET2MEM_3_SIZE,
 	},
 };
 
 static struct mv64x60_mem_win mv64x60_mpsc2mem[MV64x60_CPU2MEM_WINDOWS] = {
-	{
+	[0] = {
 		.lo	= MV64x60_MPSC2MEM_0_BASE,
 		.size	= MV64x60_MPSC2MEM_0_SIZE,
 	},
-	{
+	[1] = {
 		.lo	= MV64x60_MPSC2MEM_1_BASE,
 		.size	= MV64x60_MPSC2MEM_1_SIZE,
 	},
-	{
+	[2] = {
 		.lo	= MV64x60_MPSC2MEM_2_BASE,
 		.size	= MV64x60_MPSC2MEM_2_SIZE,
 	},
-	{
+	[3] = {
 		.lo	= MV64x60_MPSC2MEM_3_BASE,
 		.size	= MV64x60_MPSC2MEM_3_SIZE,
 	},
 };
 
 static struct mv64x60_mem_win mv64x60_idma2mem[MV64x60_CPU2MEM_WINDOWS] = {
-	{
+	[0] = {
 		.lo	= MV64x60_IDMA2MEM_0_BASE,
 		.size	= MV64x60_IDMA2MEM_0_SIZE,
 	},
-	{
+	[1] = {
 		.lo	= MV64x60_IDMA2MEM_1_BASE,
 		.size	= MV64x60_IDMA2MEM_1_SIZE,
 	},
-	{
+	[2] = {
 		.lo	= MV64x60_IDMA2MEM_2_BASE,
 		.size	= MV64x60_IDMA2MEM_2_SIZE,
 	},
-	{
+	[3] = {
 		.lo	= MV64x60_IDMA2MEM_3_BASE,
 		.size	= MV64x60_IDMA2MEM_3_SIZE,
 	},
@@ -338,7 +338,7 @@ void mv64x60_config_ctlr_windows(u8 *bridge_base, u8 *bridge_pbase,
 
 /* PCI MEM -> system memory, et. al. setup */
 static struct mv64x60_pci_win mv64x60_pci2mem[2][MV64x60_CPU2MEM_WINDOWS] = {
-	{ /* hose 0 */
+	[0] = { /* hose 0 */
 		[0] = {
 			.fcn	= 0,
 			.hi	= 0x14,
@@ -364,7 +364,7 @@ static struct mv64x60_pci_win mv64x60_pci2mem[2][MV64x60_CPU2MEM_WINDOWS] = {
 			.size	= MV64x60_PCI02MEM_3_SIZE,
 		},
 	},
-	{ /* hose 1 */
+	[1] = { /* hose 1 */
 		[0] = {
 			.fcn	= 0,
 			.hi	= 0x94,
@@ -394,45 +394,45 @@ static struct mv64x60_pci_win mv64x60_pci2mem[2][MV64x60_CPU2MEM_WINDOWS] = {
 
 static struct
 mv64x60_mem_win mv64x60_pci_acc[2][MV64x60_PCI_ACC_CNTL_WINDOWS] = {
-	{ /* hose 0 */
-		{
+	[0] = { /* hose 0 */
+		[0] = {
 			.hi	= MV64x60_PCI0_ACC_CNTL_0_BASE_HI,
 			.lo	= MV64x60_PCI0_ACC_CNTL_0_BASE_LO,
 			.size	= MV64x60_PCI0_ACC_CNTL_0_SIZE,
 		},
-		{
+		[1] = {
 			.hi	= MV64x60_PCI0_ACC_CNTL_1_BASE_HI,
 			.lo	= MV64x60_PCI0_ACC_CNTL_1_BASE_LO,
 			.size	= MV64x60_PCI0_ACC_CNTL_1_SIZE,
 		},
-		{
+		[2] = {
 			.hi	= MV64x60_PCI0_ACC_CNTL_2_BASE_HI,
 			.lo	= MV64x60_PCI0_ACC_CNTL_2_BASE_LO,
 			.size	= MV64x60_PCI0_ACC_CNTL_2_SIZE,
 		},
-		{
+		[3] = {
 			.hi	= MV64x60_PCI0_ACC_CNTL_3_BASE_HI,
 			.lo	= MV64x60_PCI0_ACC_CNTL_3_BASE_LO,
 			.size	= MV64x60_PCI0_ACC_CNTL_3_SIZE,
 		},
 	},
-	{ /* hose 1 */
-		{
+	[1] = { /* hose 1 */
+		[0] = {
 			.hi	= MV64x60_PCI1_ACC_CNTL_0_BASE_HI,
 			.lo	= MV64x60_PCI1_ACC_CNTL_0_BASE_LO,
 			.size	= MV64x60_PCI1_ACC_CNTL_0_SIZE,
 		},
-		{
+		[1] = {
 			.hi	= MV64x60_PCI1_ACC_CNTL_1_BASE_HI,
 			.lo	= MV64x60_PCI1_ACC_CNTL_1_BASE_LO,
 			.size	= MV64x60_PCI1_ACC_CNTL_1_SIZE,
 		},
-		{
+		[2] = {
 			.hi	= MV64x60_PCI1_ACC_CNTL_2_BASE_HI,
 			.lo	= MV64x60_PCI1_ACC_CNTL_2_BASE_LO,
 			.size	= MV64x60_PCI1_ACC_CNTL_2_SIZE,
 		},
-		{
+		[3] = {
 			.hi	= MV64x60_PCI1_ACC_CNTL_3_BASE_HI,
 			.lo	= MV64x60_PCI1_ACC_CNTL_3_BASE_LO,
 			.size	= MV64x60_PCI1_ACC_CNTL_3_SIZE,
@@ -441,13 +441,13 @@ mv64x60_mem_win mv64x60_pci_acc[2][MV64x60_PCI_ACC_CNTL_WINDOWS] = {
 };
 
 static struct mv64x60_pci_win mv64x60_pci2reg[2] = {
-	{ /* hose 0 */
+	[0] = { /* hose 0 */
 		.fcn	= 0,
 		.hi	= 0x24,
 		.lo	= 0x20,
 		.size	= 0,
 	},
-	{ /* hose 1 */
+	[1] = { /* hose 1 */
 		.fcn	= 0,
 		.hi	= 0xa4,
 		.lo	= 0xa0,
@@ -519,13 +519,13 @@ void mv64x60_config_pci_windows(u8 *bridge_base, u8 *bridge_pbase, u8 hose,
 
 /* CPU -> PCI I/O & MEM setup */
 struct mv64x60_cpu2pci_win mv64x60_cpu2pci_io[2] = {
-	{ /* hose 0 */
+	[0] = { /* hose 0 */
 		.lo		= MV64x60_CPU2PCI0_IO_BASE,
 		.size		= MV64x60_CPU2PCI0_IO_SIZE,
 		.remap_hi	= 0,
 		.remap_lo	= MV64x60_CPU2PCI0_IO_REMAP,
 	},
-	{ /* hose 1 */
+	[1] = { /* hose 1 */
 		.lo		= MV64x60_CPU2PCI1_IO_BASE,
 		.size		= MV64x60_CPU2PCI1_IO_SIZE,
 		.remap_hi	= 0,
@@ -534,13 +534,13 @@ struct mv64x60_cpu2pci_win mv64x60_cpu2pci_io[2] = {
 };
 
 struct mv64x60_cpu2pci_win mv64x60_cpu2pci_mem[2] = {
-	{ /* hose 0 */
+	[0] = { /* hose 0 */
 		.lo		= MV64x60_CPU2PCI0_MEM_0_BASE,
 		.size		= MV64x60_CPU2PCI0_MEM_0_SIZE,
 		.remap_hi	= MV64x60_CPU2PCI0_MEM_0_REMAP_HI,
 		.remap_lo	= MV64x60_CPU2PCI0_MEM_0_REMAP_LO,
 	},
-	{ /* hose 1 */
+	[1] = { /* hose 1 */
 		.lo		= MV64x60_CPU2PCI1_MEM_0_BASE,
 		.size		= MV64x60_CPU2PCI1_MEM_0_SIZE,
 		.remap_hi	= MV64x60_CPU2PCI1_MEM_0_REMAP_HI,
