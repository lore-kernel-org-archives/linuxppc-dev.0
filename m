Return-Path: <marco.stornelli@coritel.it>
Received: from nausicaa2.coritel.it
	(host254-130-static.190-82-b.business.telecomitalia.it
	[82.190.130.254]) by ozlabs.org (Postfix) with ESMTP id 45FEADDE41
	for <linuxppc-embedded@ozlabs.org>;
	Fri, 11 Jul 2008 16:59:35 +1000 (EST)
Message-ID: <4877055F.6050306@coritel.it>
Date: Fri, 11 Jul 2008 09:01:51 +0200
From: Marco Stornelli <marco.stornelli@coritel.it>
MIME-Version: 1.0
To: Stephen Horton <SHorton@kodiaknetworks.com>
Subject: Re: mpc744x, Marvell mv6446x kernel guidance please
References: <295C5089A56CE143B316E5F67CA99CB001C9E4BD@cowboy.inovate.inovate.com>
In-Reply-To: <295C5089A56CE143B316E5F67CA99CB001C9E4BD@cowboy.inovate.inovate.com>
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
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

Stephen Horton ha scritto:
> Hello folks,
> 
> In a current work project, I have inherited a compactPCI board that has
> an mpc7447/7448 powerpc processor as well as a Marvell system
> controller, model mv64462 (stripped down mv64460). The board has a
> somewhat working Gentoo Linux port running on it from long ago and a
> company far far away (kernel version 2.6.9 built using arch/ppc). To
> prepare for an upcoming deployment, I would like to bring the OS
> up-to-date on this board with a newer kernel (targeting Gentoo 2008),
> but I am unsure of the approach to take. I am a software developer, but
> normally do not work on kernel porting / board integration. I have
> researched the arch/ppc to arch/powerpc migration, but I'm a bit
> intimidated by the 'new' device tree symantics and other changes to the
> stream. Here are some questions:
> 
> 1.	Is it possible with the 2.6.24 (Gentoo 2008) kernel to still use
> arch/ppc for this platform architecture?  I've tried to get this to
> compile, but am having trouble with files from arch/powerpc getting
> pulled in; then I read some comments (from I believe this forum) that
> indicated that arch/ppc is not longer supposed to compile
> 2.	Does anyone have example code for this platform architecture?
> Any freebees I could use for creating my device tree?
> 3.	Any advice of any kind?
> 
> Regards,
> 
> Stephen
> 
> 
> 
> 
> ------------------------------------------------------------------------
> 
> _______________________________________________
> Linuxppc-embedded mailing list
> Linuxppc-embedded@ozlabs.org
> https://ozlabs.org/mailman/listinfo/linuxppc-embedded

 > 1.	Is it possible with the 2.6.24 (Gentoo 2008) kernel to still use
 > arch/ppc for this platform architecture?  I've tried to get this to
 > compile, but am having trouble with files from arch/powerpc getting
 > pulled in; then I read some comments (from I believe this forum) that
 > indicated that arch/ppc is not longer supposed to compile

Good idea, I suggest you to use arch/powerpc, arch/ppc won't be 
supported in the future and this folder there won't be anymore!

 > 2.	Does anyone have example code for this platform architecture?
 > Any freebees I could use for creating my device tree?

I suggest you to use, as starting point, a dts file for a board similar 
to your board, I don't know if your board is somehow derived from one 
evaluation board.

 > 3.	Any advice of any kind?
First of all read the kernel documentation about dts in the powerpc 
folder. You can find in that documentation even some reference to the 
open-firmware standard (IEEE 1275).

Last suggestions, I wouldn't use Gentoo Linux but a specific embedded 
distribution, for example ELDK.

Regards,

-- 
Marco Stornelli
Embedded Software Engineer
CoRiTeL - Consorzio di Ricerca sulle Telecomunicazioni
http://www.coritel.it

marco.stornelli@coritel.it
+39 06 72582838
