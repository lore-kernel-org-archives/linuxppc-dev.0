Return-Path: <avorontsov@ru.mvista.com>
Received: from buildserver.ru.mvista.com (unknown [85.21.88.6])
	by ozlabs.org (Postfix) with ESMTP id A585DDE381
	for <linuxppc-dev@ozlabs.org>; Fri,  4 Jul 2008 01:59:26 +1000 (EST)
Date: Thu, 3 Jul 2008 19:59:23 +0400
From: Anton Vorontsov <avorontsov@ru.mvista.com>
To: Kumar Gala <galak@kernel.crashing.org>
Subject: Re: patches for 2.6.27...
Message-ID: <20080703155923.GA24286@polina.dev.rtsoft.ru>
References: <068935A1-11BE-4AEB-9C0E-E1AB53F1618E@kernel.crashing.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf8
In-Reply-To: <068935A1-11BE-4AEB-9C0E-E1AB53F1618E@kernel.crashing.org>
Cc: "linuxppc-dev@ozlabs.org list" <linuxppc-dev@ozlabs.org>
Reply-To: avorontsov@ru.mvista.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Wed, Jul 02, 2008 at 02:56:16AM -0500, Kumar Gala wrote:
> Please point out any patches that have been posted but havent made it  
> into a git tree related to Freescale chips.

How about RTC work for MPC8610HPCD/MPC8572DS:

[PATCH 1/4] powerpc: fsl_uli1575: fix RTC quirk to work on MPC8572DS and MPC8610HPCD
http://patchwork.ozlabs.org/linuxppc/patch?id=18913

[PATCH 2/4] powerpc/85xx/86xx: some refactoring for fsl_uli1575 code
http://patchwork.ozlabs.org/linuxppc/patch?id=18914

[PATCH 3/4] powerpc: rtc_cmos_setup: assign interrupts only if there is i8259 PIC
http://patchwork.ozlabs.org/linuxppc/patch?id=18915

[PATCH 4/4] powerpc/86xx: mpc8610_hpcd: add support for ULI RTC
http://patchwork.ozlabs.org/linuxppc/patch?id=18916


And mpc83xx_defconfig update for MPC8360E-RDK:

[PATCH v3] powerpc/83xx: update mpc83xx_defconfig to support MPC8360E-RDK
http://patchwork.ozlabs.org/linuxppc/patch?id=18903

-- 
Anton Vorontsov
email: cbouatmailru@gmail.com
irc://irc.freenode.net/bd2
