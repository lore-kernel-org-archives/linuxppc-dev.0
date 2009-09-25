Return-Path: <akpm@linux-foundation.org>
Received: from smtp1.linux-foundation.org (smtp1.linux-foundation.org
	[140.211.169.13])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "smtp.linux-foundation.org",
	Issuer "CA Cert Signing Authority" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id DE54BB7B7B
	for <linuxppc-dev@ozlabs.org>; Fri, 25 Sep 2009 10:05:47 +1000 (EST)
Date: Thu, 24 Sep 2009 17:05:41 -0700
From: Andrew Morton <akpm@linux-foundation.org>
To: linuxppc-dev@ozlabs.org
Subject: Fw: [PATCH] ppc: add ppc750 CL as supported by oprofile
Message-Id: <20090924170541.5cdffc06.akpm@linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: Dragos Tatulea <dtatulea@ixiacom.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>



Begin forwarded message:

Date: Wed, 16 Sep 2009 11:58:15 +0300
From: Dragos Tatulea <dtatulea@ixiacom.com>
To: paulus@samba.org, linux-kernel@vger.kernel.org
Cc: Octavian Purdila <opurdila@ixiacom.com>
Subject: [PATCH] ppc: add ppc750 CL as supported by oprofile


Hi,

	Here's a patch that adds the ppc750 CL cpu as supported by oprofile.

-- Dragos

Signed-off-by: Dragos Tatulea <dtatulea@ixiacom.com>
---
 arch/powerpc/kernel/cputable.c |    2 ++
 1 files changed, 2 insertions(+), 0 deletions(-)

diff --git a/arch/powerpc/kernel/cputable.c b/arch/powerpc/kernel/cputable.c
index 0b9c913..03c862b 100644
--- a/arch/powerpc/kernel/cputable.c
+++ b/arch/powerpc/kernel/cputable.c
@@ -711,6 +711,8 @@ static struct cpu_spec __initdata cpu_specs[] = {
 		.cpu_setup		= __setup_cpu_750,
 		.machine_check		= machine_check_generic,
 		.platform		= "ppc750",
+		.oprofile_cpu_type      = "ppc/750",
+		.oprofile_type		= PPC_OPROFILE_G4,
 	},
 	{	/* 745/755 */
 		.pvr_mask		= 0xfffff000,
