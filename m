Return-Path: <B04825@freescale.com>
Received: from ch1outboundpool.messaging.microsoft.com
 (ch1ehsobe003.messaging.microsoft.com [216.32.181.183])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "Microsoft Secure Server Authority" (verified OK))
 by ozlabs.org (Postfix) with ESMTPS id 0F608B70FE
 for <linuxppc-dev@ozlabs.org>; Thu, 17 Nov 2011 08:47:33 +1100 (EST)
Message-ID: <4EC42F6E.2030500@freescale.com>
Date: Wed, 16 Nov 2011 15:47:26 -0600
From: Timur Tabi <timur@freescale.com>
MIME-Version: 1.0
Subject: Re: [RFC][PATCH 15/30] powerpc/85xx: Rework P1022DS device tree
References: <1320941653-29797-1-git-send-email-galak@kernel.crashing.org>
 <1320941653-29797-4-git-send-email-galak@kernel.crashing.org>
 <1320941653-29797-5-git-send-email-galak@kernel.crashing.org>
 <1320941653-29797-6-git-send-email-galak@kernel.crashing.org>
 <1320941653-29797-7-git-send-email-galak@kernel.crashing.org>
 <1320941653-29797-8-git-send-email-galak@kernel.crashing.org>
 <1320941653-29797-9-git-send-email-galak@kernel.crashing.org>
 <1320941653-29797-10-git-send-email-galak@kernel.crashing.org>
 <1320941653-29797-11-git-send-email-galak@kernel.crashing.org>
 <1320941653-29797-12-git-send-email-galak@kernel.crashing.org>
 <1320941653-29797-13-git-send-email-galak@kernel.crashing.org>
 <1320941653-29797-14-git-send-email-galak@kernel.crashing.org>
 <1320941653-29797-15-git-send-email-galak@kernel.crashing.org>
 <1320941653-29797-16-git-send-email-galak@kernel.crashing.org>
 <CAOZdJXU6NXgWv=VwShOvEGH5rm0KJmrQgOCVDiSJtKoVMs5=eg@mail.gmail.com>
In-Reply-To: <CAOZdJXU6NXgWv=VwShOvEGH5rm0KJmrQgOCVDiSJtKoVMs5=eg@mail.gmail.com>
Content-Type: text/plain; charset="ISO-8859-1"
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

 wrote:
> I just noticed this bug in the original p1022ds.dts, and I see you're
> carrying it over here.  The reg property should look like this:
> 
> reg = <0xf 0xffe05000 0 0x1000>;
>        ^^^

It looks like there's also a problem with the 'ranges' property:

	ranges = <0x0 0x0 0xf 0xe8000000 0x08000000
		  0x1 0x0 0xf 0xe0000000 0x08000000
		  0x2 0x0 0x0 0xffa00000 0x00040000
		          ^^^
		  0x3 0x0 0xf 0xffdf0000 0x00008000>;

-- 
Timur Tabi
Linux kernel developer at Freescale
