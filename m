Return-Path: <matt@genesi-usa.com>
Received: from mail.genesi-usa.com (mithrandir.softwarenexus.net
	[66.98.186.96])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 1586BDDDCA
	for <linuxppc-embedded@ozlabs.org>;
	Tue, 14 Aug 2007 03:42:45 +1000 (EST)
Message-ID: <46C0985B.9040401@genesi-usa.com>
Date: Mon, 13 Aug 2007 18:43:55 +0100
From: Matt Sealey <matt@genesi-usa.com>
MIME-Version: 1.0
To: Jon Smirl <jonsmirl@gmail.com>
Subject: Re: MPC5200 and Bestcomm
References: <9e4733910708130927l70163a80vf0362ee8649a6c29@mail.gmail.com>	<fa686aa40708130934v912eda2r691d2db30a9bc17c@mail.gmail.com>	<9e4733910708130950y38f60687ma7957cf42a758cdd@mail.gmail.com>
	<9e4733910708130952m9c5e512xe41fec3a02435298@mail.gmail.com>
In-Reply-To: <9e4733910708130952m9c5e512xe41fec3a02435298@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Cc: linuxppc-embedded@ozlabs.org
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

The current (2.6.22) patchset for the Efika is being held here for
the moment; http://dev.gentoo.org/~nixnut/efika/

That's everything you 'really need' and it's probably the same as
this patch list.

However practically none of it is mainline-worthy at the moment,
Sylvain has detailed too many things he thinks is wrong with it.

I'm having a go with the new ethernet driver patch right now (a
customer asked me for a prebuilt kernel..) so I can get on with
testing that. The most important ones for rewrites besides that
are the AC97 driver (which is a little.. sparse) and actually
using the ATA task.

I'll put in a decent request here for any work on this subject to
please at least attempt to retrieve the tasks from the Efika
firmware rather than replacing them in Linux gratuituously.
I understand this doesn't help the Lite5200 guys.. but.. pretty
please with a cherry on top? :]

-- 
Matt Sealey <matt@genesi-usa.com>
Genesi, Manager, Developer Relations

Jon Smirl wrote:
> Another series is being posted to the Efika boards.
> 
> 0001-powerpc-exports-rheap-symbol-to-modules.patch
> 0002-powerpc-Changes-the-config-mechanism-for-rheap.patch
> 0003-powerpc-ppc32-Update-mpc52xx_psc-structure-with-B-r.patch
> 0004-powerpc-BestComm-core-support-for-Freescale-MPC5200.patch
> 0005-powerpc-BestcComm-ATA-task-support.patch
> 0006-powerpc-BestcComm-FEC-task-support.patch
> 0007-powerpc-BestcComm-GenBD-task-support.patch
> 0008-drivers-net-Add-support-for-Freescale-MPC5200-SoC-i.patch
> 0009-sound-Add-support-for-Freescale-MPC5200-AC97-interf.patch
> 0010-powerpc-In-rheap.c-move-the-EXPORT_SYMBOL-and-use.patch
> 0011-powerpc-BestComm-move-the-EXPORT_SYMBOL-and-use-th.patch
> 0012-powerpc-BestComm-ATA-task-move-the-EXPORT_SYMBOL-a.patch
> 0013-powerpc-BestComm-FEC-task-move-the-EXPORT_SYMBOL-a.patch
> 0014-powerpc-BestComm-GenBD-task-move-the-EXPORT_SYMBOL.patch
> 0015-powerpc-BestComm-Replace-global-variable-bcom-by-b.patch
> 0016-powerpc-Make-the-BestComm-driver-a-standard-of_plat.patch
> 0017-powerpc-Fix-typo-in-BestComm-ATA-task-support-code.patch
> 0018-powerpc-BestComm-ATA-task-microcode-insert-copyri.patch
> 0019-powerpc-BestComm-FEC-task-microcode-insert-copyri.patch
> 0020-powerpc-BestComm-GenBD-task-microcode-insert-copy.patch
> 0021-powerpc-Fix-errors-in-bcom-bcom_eng-renaming.patch
> 0081-mpc52xx-correct-calculation-of-FEC-RX-errors.patch
> 0082-powerpc-pata_mpc52xx-suspend.patch
> 
