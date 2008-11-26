Return-Path: <andre.schwarz@matrix-vision.de>
Received: from p15137414.pureserver.info (matrixvision.de [217.160.213.229])
	by ozlabs.org (Postfix) with ESMTP id A7FC5DDDFF
	for <linuxppc-dev@ozlabs.org>; Thu, 27 Nov 2008 04:39:10 +1100 (EST)
Received: from pandora.intern.matrix-vision.de (g1.matrix-vision.com
	[217.7.222.190])
	by p15137414.pureserver.info (Postfix) with ESMTP id 8C0E442007A
	for <linuxppc-dev@ozlabs.org>; Wed, 26 Nov 2008 18:39:06 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by pandora.intern.matrix-vision.de (Postfix) with ESMTP id 7DA6FE3C09
	for <linuxppc-dev@ozlabs.org>; Wed, 26 Nov 2008 20:39:13 +0100 (CET)
Received: from hegemone (hegemone.intern.matrix-vision.de [192.168.5.77])
	by pandora.intern.matrix-vision.de (Postfix) with ESMTP id 6C1E8E3C09
	for <linuxppc-dev@ozlabs.org>; Wed, 26 Nov 2008 20:39:13 +0100 (CET)
Received: from [192.168.65.5] (unknown [192.168.65.5])
	by hegemone (Postfix) with ESMTP id 675A551E
	for <linuxppc-dev@ozlabs.org>; Wed, 26 Nov 2008 20:35:22 +0100 (CET)
Message-ID: <492D89B9.1040708@matrix-vision.de>
Date: Wed, 26 Nov 2008 18:39:05 +0100
From: Andre Schwarz <andre.schwarz@matrix-vision.de>
MIME-Version: 1.0
To: linuxppc-dev@ozlabs.org
Subject: machine check on mpc8343
Content-Type: text/plain; charset=ISO-8859-15
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

All,

we're running 2.6.27 on a MPC8343 cpu - nothing special so far.

With heavy system load I get a machine check exception on some boards
within 1-3 days leading to immediate reset.

U-Boot blames "Check Stop" causing the reset - I can also observe the
check_stop_out signal of the CPU being asserted.

Dumping the kernel's "__log_buf" location within U-Boot shows the kernel
log buffer without any error.

Is there a reasonable/default way to get more Infos out of the kernel
before he dies ?

A solution other than "write your own ppc_md.machine_check_exception" is
preferred ;-)


regards,
Andre



MATRIX VISION GmbH, Talstraße 16, DE-71570 Oppenweiler  - Registergericht: Amtsgericht Stuttgart, HRB 271090
Geschäftsführer: Gerhard Thullner, Werner Armingeon, Uwe Furtner
