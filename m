Return-Path: <mathieu.malaterre@gmail.com>
Received: from mail-wr0-x241.google.com (mail-wr0-x241.google.com
 [IPv6:2a00:1450:400c:c0c::241])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 402jH44pp0zF0Qs
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 16 Mar 2018 22:02:56 +1100 (AEDT)
Received: by mail-wr0-x241.google.com with SMTP id s18so11222398wrg.9
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 16 Mar 2018 04:02:56 -0700 (PDT)
Sender: Mathieu Malaterre <mathieu.malaterre@gmail.com>
From: Mathieu Malaterre <malat@debian.org>
To: Michael Ellerman <mpe@ellerman.id.au>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, linuxppc-dev@lists.ozlabs.org,
 Mathieu Malaterre <malat@debian.org>
Subject: [PATCH 08/19] ppc64: change %x into %lx
Date: Fri, 16 Mar 2018 12:02:13 +0100
Message-Id: <20180316110224.12260-9-malat@debian.org>
In-Reply-To: <20180316110224.12260-1-malat@debian.org>
References: <20180316110224.12260-1-malat@debian.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

  CC      arch/powerpc/xmon/xmon.o
../arch/powerpc/xmon/xmon.c: In function ‘cpu_cmd’:
../arch/powerpc/xmon/xmon.c:1168:18: error: format ‘%x’ expects argument of type ‘unsigned int’, but argument 2 has type ‘long unsigned int’ [-Werror=format=]
   printf("cpu 0x%x isn't in xmon\n", cpu);
                  ^
../arch/powerpc/xmon/xmon.c:1182:19: error: format ‘%x’ expects argument of type ‘unsigned int’, but argument 2 has type ‘long unsigned int’ [-Werror=format=]
    printf("cpu 0x%x didn't take control\n", cpu);
                   ^
../arch/powerpc/xmon/xmon.c: In function ‘dump_206_sprs’:
../arch/powerpc/xmon/xmon.c:1778:54: error: format ‘%x’ expects argument of type ‘unsigned int’, but argument 4 has type ‘long unsigned int’ [-Werror=format=]
  printf("srr0   = %.16lx  srr1  = %.16lx dsisr  = %.8x\n",
                                                      ^
../arch/powerpc/xmon/xmon.c:1780:54: error: format ‘%x’ expects argument of type ‘unsigned int’, but argument 4 has type ‘long unsigned int’ [-Werror=format=]
  printf("dscr   = %.16lx  ppr   = %.16lx pir    = %.8x\n",
                                                      ^
../arch/powerpc/xmon/xmon.c:1788:54: error: format ‘%x’ expects argument of type ‘unsigned int’, but argument 4 has type ‘long unsigned int’ [-Werror=format=]
  printf("sdr1   = %.16lx  hdar  = %.16lx hdsisr = %.8x\n",
                                                      ^
../arch/powerpc/xmon/xmon.c:1792:54: error: format ‘%x’ expects argument of type ‘unsigned int’, but argument 4 has type ‘long unsigned int’ [-Werror=format=]
  printf("lpcr   = %.16lx  pcr   = %.16lx lpidr  = %.8x\n",
                                                      ^
../arch/powerpc/xmon/xmon.c: In function ‘dump_207_sprs’:
../arch/powerpc/xmon/xmon.c:1809:54: error: format ‘%x’ expects argument of type ‘unsigned int’, but argument 4 has type ‘long unsigned int’ [-Werror=format=]
  printf("dpdes  = %.16lx  tir   = %.16lx cir    = %.8x\n",
                                                      ^
../arch/powerpc/xmon/xmon.c:1812:54: error: format ‘%x’ expects argument of type ‘unsigned int’, but argument 4 has type ‘long unsigned int’ [-Werror=format=]
  printf("fscr   = %.16lx  tar   = %.16lx pspb   = %.8x\n",
                                                      ^
../arch/powerpc/xmon/xmon.c:1825:22: error: format ‘%x’ expects argument of type ‘unsigned int’, but argument 2 has type ‘long unsigned int’ [-Werror=format=]
  printf("pmc1   = %.8x pmc2 = %.8x  pmc3 = %.8x  pmc4   = %.8x\n",
                      ^
../arch/powerpc/xmon/xmon.c:1825:34: error: format ‘%x’ expects argument of type ‘unsigned int’, but argument 3 has type ‘long unsigned int’ [-Werror=format=]
  printf("pmc1   = %.8x pmc2 = %.8x  pmc3 = %.8x  pmc4   = %.8x\n",
                                  ^
../arch/powerpc/xmon/xmon.c:1825:47: error: format ‘%x’ expects argument of type ‘unsigned int’, but argument 4 has type ‘long unsigned int’ [-Werror=format=]
  printf("pmc1   = %.8x pmc2 = %.8x  pmc3 = %.8x  pmc4   = %.8x\n",
                                               ^
../arch/powerpc/xmon/xmon.c:1825:62: error: format ‘%x’ expects argument of type ‘unsigned int’, but argument 5 has type ‘long unsigned int’ [-Werror=format=]
  printf("pmc1   = %.8x pmc2 = %.8x  pmc3 = %.8x  pmc4   = %.8x\n",
                                                              ^
../arch/powerpc/xmon/xmon.c:1828:54: error: format ‘%x’ expects argument of type ‘unsigned int’, but argument 4 has type ‘long unsigned int’ [-Werror=format=]
  printf("mmcra  = %.16lx   siar = %.16lx pmc5   = %.8x\n",
                                                      ^
../arch/powerpc/xmon/xmon.c:1830:54: error: format ‘%x’ expects argument of type ‘unsigned int’, but argument 4 has type ‘long unsigned int’ [-Werror=format=]
  printf("sdar   = %.16lx   sier = %.16lx pmc6   = %.8x\n",
                                                      ^
cc1: all warnings being treated as errors

Signed-off-by: Mathieu Malaterre <malat@debian.org>
---
 arch/powerpc/xmon/spu-dis.c |  2 +-
 arch/powerpc/xmon/xmon.c    | 22 +++++++++++-----------
 2 files changed, 12 insertions(+), 12 deletions(-)

diff --git a/arch/powerpc/xmon/spu-dis.c b/arch/powerpc/xmon/spu-dis.c
index e5f89837c82e..6b83b680b9f6 100644
--- a/arch/powerpc/xmon/spu-dis.c
+++ b/arch/powerpc/xmon/spu-dis.c
@@ -102,7 +102,7 @@ print_insn_spu (unsigned long insn, unsigned long memaddr)
 
   if (index == 0)
     {
-      printf(".long 0x%x", insn);
+      printf(".long 0x%lx", insn);
     }
   else
     {
diff --git a/arch/powerpc/xmon/xmon.c b/arch/powerpc/xmon/xmon.c
index 6117164cb5ba..0e4dcdf12f9e 100644
--- a/arch/powerpc/xmon/xmon.c
+++ b/arch/powerpc/xmon/xmon.c
@@ -1165,7 +1165,7 @@ static int cpu_cmd(void)
 	}
 	/* try to switch to cpu specified */
 	if (!cpumask_test_cpu(cpu, &cpus_in_xmon)) {
-		printf("cpu 0x%x isn't in xmon\n", cpu);
+		printf("cpu 0x%lx isn't in xmon\n", cpu);
 		return 0;
 	}
 	xmon_taken = 0;
@@ -1179,7 +1179,7 @@ static int cpu_cmd(void)
 			/* take control back */
 			mb();
 			xmon_owner = smp_processor_id();
-			printf("cpu 0x%x didn't take control\n", cpu);
+			printf("cpu 0x%lx didn't take control\n", cpu);
 			return 0;
 		}
 		barrier();
@@ -1775,9 +1775,9 @@ static void dump_206_sprs(void)
 
 	/* Actually some of these pre-date 2.06, but whatevs */
 
-	printf("srr0   = %.16lx  srr1  = %.16lx dsisr  = %.8x\n",
+	printf("srr0   = %.16lx  srr1  = %.16lx dsisr  = %.8lx\n",
 		mfspr(SPRN_SRR0), mfspr(SPRN_SRR1), mfspr(SPRN_DSISR));
-	printf("dscr   = %.16lx  ppr   = %.16lx pir    = %.8x\n",
+	printf("dscr   = %.16lx  ppr   = %.16lx pir    = %.8lx\n",
 		mfspr(SPRN_DSCR), mfspr(SPRN_PPR), mfspr(SPRN_PIR));
 	printf("amr    = %.16lx  uamor = %.16lx\n",
 		mfspr(SPRN_AMR), mfspr(SPRN_UAMOR));
@@ -1785,11 +1785,11 @@ static void dump_206_sprs(void)
 	if (!(mfmsr() & MSR_HV))
 		return;
 
-	printf("sdr1   = %.16lx  hdar  = %.16lx hdsisr = %.8x\n",
+	printf("sdr1   = %.16lx  hdar  = %.16lx hdsisr = %.8lx\n",
 		mfspr(SPRN_SDR1), mfspr(SPRN_HDAR), mfspr(SPRN_HDSISR));
 	printf("hsrr0  = %.16lx hsrr1  = %.16lx hdec   = %.16lx\n",
 		mfspr(SPRN_HSRR0), mfspr(SPRN_HSRR1), mfspr(SPRN_HDEC));
-	printf("lpcr   = %.16lx  pcr   = %.16lx lpidr  = %.8x\n",
+	printf("lpcr   = %.16lx  pcr   = %.16lx lpidr  = %.8lx\n",
 		mfspr(SPRN_LPCR), mfspr(SPRN_PCR), mfspr(SPRN_LPID));
 	printf("hsprg0 = %.16lx hsprg1 = %.16lx amor   = %.16lx\n",
 		mfspr(SPRN_HSPRG0), mfspr(SPRN_HSPRG1), mfspr(SPRN_AMOR));
@@ -1806,10 +1806,10 @@ static void dump_207_sprs(void)
 	if (!cpu_has_feature(CPU_FTR_ARCH_207S))
 		return;
 
-	printf("dpdes  = %.16lx  tir   = %.16lx cir    = %.8x\n",
+	printf("dpdes  = %.16lx  tir   = %.16lx cir    = %.8lx\n",
 		mfspr(SPRN_DPDES), mfspr(SPRN_TIR), mfspr(SPRN_CIR));
 
-	printf("fscr   = %.16lx  tar   = %.16lx pspb   = %.8x\n",
+	printf("fscr   = %.16lx  tar   = %.16lx pspb   = %.8lx\n",
 		mfspr(SPRN_FSCR), mfspr(SPRN_TAR), mfspr(SPRN_PSPB));
 
 	msr = mfmsr();
@@ -1822,12 +1822,12 @@ static void dump_207_sprs(void)
 
 	printf("mmcr0  = %.16lx  mmcr1 = %.16lx mmcr2  = %.16lx\n",
 		mfspr(SPRN_MMCR0), mfspr(SPRN_MMCR1), mfspr(SPRN_MMCR2));
-	printf("pmc1   = %.8x pmc2 = %.8x  pmc3 = %.8x  pmc4   = %.8x\n",
+	printf("pmc1   = %.8lx pmc2 = %.8lx  pmc3 = %.8lx  pmc4   = %.8lx\n",
 		mfspr(SPRN_PMC1), mfspr(SPRN_PMC2),
 		mfspr(SPRN_PMC3), mfspr(SPRN_PMC4));
-	printf("mmcra  = %.16lx   siar = %.16lx pmc5   = %.8x\n",
+	printf("mmcra  = %.16lx   siar = %.16lx pmc5   = %.8lx\n",
 		mfspr(SPRN_MMCRA), mfspr(SPRN_SIAR), mfspr(SPRN_PMC5));
-	printf("sdar   = %.16lx   sier = %.16lx pmc6   = %.8x\n",
+	printf("sdar   = %.16lx   sier = %.16lx pmc6   = %.8lx\n",
 		mfspr(SPRN_SDAR), mfspr(SPRN_SIER), mfspr(SPRN_PMC6));
 	printf("ebbhr  = %.16lx  ebbrr = %.16lx bescr  = %.16lx\n",
 		mfspr(SPRN_EBBHR), mfspr(SPRN_EBBRR), mfspr(SPRN_BESCR));
-- 
2.11.0
