Return-Path: <tnt@246tNt.com>
Received: from outmx017.isp.belgacom.be (outmx017.isp.belgacom.be
	[195.238.2.116])
	(using TLSv1 with cipher EDH-RSA-DES-CBC3-SHA (168/168 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id C05312BD3C
	for <linuxppc-dev@ozlabs.org>; Tue, 14 Sep 2004 21:45:29 +1000 (EST)
Received: from outmx017.isp.belgacom.be (localhost [127.0.0.1])
	by outmx017.isp.belgacom.be (8.12.11/8.12.11/Skynet-OUT-2.22) with
	ESMTP id i8EBj91h005477
	for <linuxppc-dev@ozlabs.org>; Tue, 14 Sep 2004 13:45:10 +0200
	(envelope-from <tnt@246tNt.com>)
Message-ID: <4146DA0D.3050407@246tNt.com>
Date: Tue, 14 Sep 2004 13:46:21 +0200
From: Sylvain Munaut <tnt@246tNt.com>
MIME-Version: 1.0
References: <4146D833.8040703@246tNt.com>
In-Reply-To: <4146D833.8040703@246tNt.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: Andrew Morton <akpm@osdl.org>, Linux PPC Dev <linuxppc-dev@ozlabs.org>,
	Paul Mackerras <paulus@samba.org>,
	Linux Kernel <linux-kernel@vger.kernel.org>
Subject: [PATCH 1/9] Small updates for Freescale MPC52xx
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

# This is a BitKeeper generated diff -Nru style patch.
#
# ChangeSet
#   2004/09/13 21:04:47+02:00 tnt@246tNt.com
#   ppc: Update name of Freescale MPC52xx platform (IceCube -> LITE5200)
#   
#   The official name is LITE5200, so we take this one for comments and
#   functions names.
#   
#   Signed-off-by: Sylvain Munaut <tnt@246tNt.com>
#
# arch/ppc/platforms/lite5200.c
#   2004/09/13 21:04:17+02:00 tnt@246tNt.com +5 -6
#   ppc: Update name of Freescale MPC52xx platform (IceCube -> LITE5200)
#
diff -Nru a/arch/ppc/platforms/lite5200.c b/arch/ppc/platforms/lite5200.c
--- a/arch/ppc/platforms/lite5200.c     2004-09-14 12:47:23 +02:00
+++ b/arch/ppc/platforms/lite5200.c     2004-09-14 12:47:23 +02:00
@@ -71,16 +71,15 @@
 /* 
======================================================================== */

 static int
-icecube_show_cpuinfo(struct seq_file *m)
+lite5200_show_cpuinfo(struct seq_file *m)
 {
        seq_printf(m, "machine\t\t: Freescale LITE5200\n");
        return 0;
 }

 static void __init
-icecube_setup_arch(void)
+lite5200_setup_arch(void)
 {
-
        /* Add board OCP definitions */
        mpc52xx_add_board_devices(board_ocp);
 }
@@ -126,8 +125,8 @@
        isa_mem_base            = 0;

        /* Setup the ppc_md struct */
-       ppc_md.setup_arch       = icecube_setup_arch;
-       ppc_md.show_cpuinfo     = icecube_show_cpuinfo;
+       ppc_md.setup_arch       = lite5200_setup_arch;
+       ppc_md.show_cpuinfo     = lite5200_show_cpuinfo;
        ppc_md.show_percpuinfo  = NULL;
        ppc_md.init_IRQ         = mpc52xx_init_irq;
        ppc_md.get_irq          = mpc52xx_get_irq;
@@ -139,7 +138,7 @@
        ppc_md.power_off        = mpc52xx_power_off;
        ppc_md.halt             = mpc52xx_halt;

-               /* No time keeper on the IceCube */
+               /* No time keeper on the LITE5200 */
        ppc_md.time_init        = NULL;
        ppc_md.get_rtc_time     = NULL;
        ppc_md.set_rtc_time     = NULL;
