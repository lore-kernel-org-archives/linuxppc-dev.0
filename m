Message-ID: <40E31C12.1020504@246tNt.com>
Date: Wed, 30 Jun 2004 22:01:22 +0200
From: Sylvain Munaut <tnt@246tnt.com>
MIME-Version: 1.0
To: linuxppc-dev@lists.linuxppc.org,
	Matt Porter <mporter@KERNEL.CRASHING.ORG>
Subject: [PATCH] MPC52xx support for 2.6 - Revised version
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Hi

Here is the new revised version of the patch. As usual, available from :

 bk://bkbits.246tNt.com/linux-2.5-mpc52xx-pending
 http://www.246tnt.com/linux-2.5-mpc52xx-pending-20040630.bksend  (
bksend generated patch )

The modifications :
 - Added SysRq support on the console
 - Few typos / forgotten name changes
 - And, thanks to Dale, the serial console bug is fixed and the kernel
support booting from other boot loader than U-Boot.

Note that in the current kernel tree state the symbol
CONFIG_KALLSYMS_EXTRA_PASS need to be defined. But it seems to me that
this issue is unrelated to the patch.


Sylvain

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
