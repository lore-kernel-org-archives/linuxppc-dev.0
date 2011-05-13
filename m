Return-Path: <R58472@freescale.com>
Received: from CH1EHSOBE001.bigfish.com
	(ch1outboundpool.messaging.microsoft.com [216.32.181.186])
	(using TLSv1 with cipher AES128-SHA (128/128 bits))
	(Client CN "mail.global.frontbridge.com",
	Issuer "Cybertrust SureServer Standard Validation CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 93137B6EE6
	for <linuxppc-dev@lists.ozlabs.org>;
	Fri, 13 May 2011 20:36:31 +1000 (EST)
From: Li Yang-R58472 <R58472@freescale.com>
To: Wood Scott-B07421 <B07421@freescale.com>
Subject: RE: [linuxppc-release] [PATCH 1/2] powerpc,	e5500: add networking
	to defconfig
Date: Fri, 13 May 2011 10:36:19 +0000
Message-ID: <3F607A5180246847A760FD34122A1E0515096A@039-SN1MPN1-002.039d.mgd.msft.net>
References: <20110510180147.GA18443@schlenkerla.am.freescale.net>
	<3F607A5180246847A760FD34122A1E0514EC65@039-SN1MPN1-002.039d.mgd.msft.net>
	<20110512103108.6dd3ca2a@schlenkerla.am.freescale.net>
	<20110512103135.2c2a037a@schlenkerla.am.freescale.net>
In-Reply-To: <20110512103135.2c2a037a@schlenkerla.am.freescale.net>
Content-Type: text/plain; charset="Windows-1252"
MIME-Version: 1.0
Cc: "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

>Subject: Re: [linuxppc-release] [PATCH 1/2] powerpc, e5500: add networking
>to defconfig
>
>On Thu, 12 May 2011 10:31:08 -0500
>Scott Wood <scottwood@freescale.com> wrote:
>
>> On Thu, 12 May 2011 01:11:03 -0500
>> Li Yang-R58472 <R58472@freescale.com> wrote:
>>
>> > >diff --git a/arch/powerpc/configs/e55xx_smp_defconfig
>> > >b/arch/powerpc/configs/e55xx_smp_defconfig
>> > >index 9fa1613..f4c5780 100644
>> > >--- a/arch/powerpc/configs/e55xx_smp_defconfig
>> > >+++ b/arch/powerpc/configs/e55xx_smp_defconfig
>> > >@@ -6,10 +6,10 @@ CONFIG_NR_CPUS=3D2
>> > > CONFIG_EXPERIMENTAL=3Dy
>> > > CONFIG_SYSVIPC=3Dy
>> > > CONFIG_BSD_PROCESS_ACCT=3Dy
>> > >+CONFIG_SPARSE_IRQ=3Dy
>> >
>> > Hi Scott,
>> >
>> > I remember in previous testing that this option has a negative effect
>on performance.  Do we really need it to be enabled?
>>
>> I didn't change this setting, it just moved due to running it through
>> savedefconfig.
>
>What was the performance impact?

It adds CPU cycles to the interrupt handling path.  Will cause performance =
drop for benchmarks with large amount of interrupts such as IP forwarding.

- Leo
