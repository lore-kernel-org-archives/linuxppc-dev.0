Return-Path: <peko@macbook.be.48ers.dk>
Received: from mx-out.mail001.coreserver.be (mx-out.mail001.coreserver.be
	[83.143.245.21]) by ozlabs.org (Postfix) with ESMTP id EC6EFDDDE3
	for <linuxppc-embedded@ozlabs.org>;
	Mon, 22 Dec 2008 20:29:36 +1100 (EST)
To: onramp123@yahoo.com
Subject: Re: mpc8xxx_gpio.c on mpc8349e-mitx
References: <02dd01c962c9$fc4d1b30$6b03a8c0@sdelaney2>
From: Peter Korsgaard <jacmet@sunsite.dk>
Date: Mon, 22 Dec 2008 10:02:33 +0100
In-Reply-To: <02dd01c962c9$fc4d1b30$6b03a8c0@sdelaney2> (Steve DeLaney's
	message of "Sat\, 20 Dec 2008 09\:40\:01 -0800")
Message-ID: <87d4fkbn12.fsf@macbook.be.48ers.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: linuxppc-embedded@ozlabs.org
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

>>>>> "Steve" == Steve DeLaney <onramp123@yahoo.com> writes:

Hi,

 Steve> We are currently working on LTIB toolchain, and are upgrading
 Steve> a GPIO driver on MPC8349E-MITX platform.

 Steve> This has taken us to the latest kernel 2.6.27.10
 Steve> we ran across a patch on ozlabs patchwork that looks like it should
 Steve> work for us, and we thank you first of all for the contribution.

You're welcome.

 Steve> The topic here pertains to how various distros are related
 Steve> Sorry for this basic question but it will help us better understand
 Steve> the best path for our development.

 Steve> in ozlabs patchwork Sep 21 08 is what appears to be the original
 Steve> implementation of GPIO support.
 Steve> In the denx git there is arch/powerpc/sysdev/mpc8xxx_gpio.c, so it looks
 Steve> like the ozlabs GPIO support made it into the denx distro.

More importantly, it's included in the mainline kernel.org kernel
since 2.6.28-rc1

 Steve> mpc8xxx_gpio.c is not present in the kernel.org 2.6.27.10 distro. 
 Steve> But is is likely that mpc8xxx_gpio.c will eventually go upstream to
 Steve> kernel.org?

It is. 2.6.28 is scheduled to release any moment now.

 Steve> Just also curious what are the primary powerpc contributions,
 Steve> such as denx, freescale, others??

It's basically all over the map. I wrote the gpio driver and I'm not
involved with any of those.

-- 
Bye, Peter Korsgaard
