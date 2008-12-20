Return-Path: <onramp123@yahoo.com>
Received: from n22b.bullet.mail.mud.yahoo.com (n22b.bullet.mail.mud.yahoo.com
	[68.142.206.159]) by ozlabs.org (Postfix) with SMTP id A02ED474C1
	for <linuxppc-embedded@ozlabs.org>;
	Sun, 21 Dec 2008 04:50:33 +1100 (EST)
From: "Steve DeLaney" <onramp123@yahoo.com>
To: <linuxppc-embedded@ozlabs.org>
Subject: mpc8xxx_gpio.c on mpc8349e-mitx
Date: Sat, 20 Dec 2008 09:40:01 -0800
Message-ID: <02dd01c962c9$fc4d1b30$6b03a8c0@sdelaney2>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Reply-To: onramp123@yahoo.com
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>


We are currently working on LTIB toolchain, and are upgrading a GPIO driver
on MPC8349E-MITX platform.  

This has taken us to the latest kernel 2.6.27.10
we ran across a patch on ozlabs patchwork that looks like it should
work for us, and we thank you first of all for the contribution.

The topic here pertains to how various distros are related
Sorry for this basic question but it will help us better understand
the best path for our development.

in ozlabs patchwork Sep 21 08 is what appears to be the original
implementation of GPIO support.
In the denx git there is arch/powerpc/sysdev/mpc8xxx_gpio.c, so it looks
like the ozlabs GPIO support made it into the denx distro.

mpc8xxx_gpio.c is not present in the kernel.org 2.6.27.10 distro. 
But is is likely that mpc8xxx_gpio.c will eventually go upstream to
kernel.org?
Just also curious what are the primary powerpc contributions, such as 
denx, freescale, others??

Thanks,
/steverino2

 
