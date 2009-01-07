Return-Path: <leon.woestenberg@gmail.com>
Received: from mail-bw0-f10.google.com (mail-bw0-f10.google.com
	[209.85.218.10]) by ozlabs.org (Postfix) with ESMTP id EED6BDDFF5
	for <linuxppc-dev@ozlabs.org>; Wed,  7 Jan 2009 11:40:57 +1100 (EST)
Received: by bwz3 with SMTP id 3so21354259bwz.9
	for <linuxppc-dev@ozlabs.org>; Tue, 06 Jan 2009 16:40:55 -0800 (PST)
Message-ID: <c384c5ea0901061640i54fc8cbg91f970177448f104@mail.gmail.com>
Date: Wed, 7 Jan 2009 01:40:54 +0100
From: "Leon Woestenberg" <leon.woestenberg@gmail.com>
To: avorontsov@ru.mvista.com
Subject: Re: [PATCH v2 4/4] powerpc/83xx: Add PCI-E support for all MPC83xx
	boards with PCI-E
In-Reply-To: <20090106234256.GA26089@oksana.dev.rtsoft.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
References: <1F7739C2-930B-49C1-B8FF-679AF1BBAEAE@kernel.crashing.org>
	<B64DF110-E26A-4229-8384-E7933732BC01@kernel.crashing.org>
	<20090105174645.GA23766@ld0162-tx32.am.freescale.net>
	<20090105180122.GA12237@oksana.dev.rtsoft.ru>
	<c384c5ea0901061053r21fbc853y3b28ae3c8e3a0e6f@mail.gmail.com>
	<20090106192747.GA3056@oksana.dev.rtsoft.ru>
	<2B8AFE67-67BF-4926-B41B-79ACD72CA505@kernel.crashing.org>
	<20090106211513.GA23914@oksana.dev.rtsoft.ru>
	<c384c5ea0901061433y446f4ab4i2e18d1141734d60e@mail.gmail.com>
	<20090106234256.GA26089@oksana.dev.rtsoft.ru>
Cc: Scott Wood <scottwood@freescale.com>, linuxppc-dev@ozlabs.org,
	Wolfgang Denk <wd@denx.de>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Hello Anton,

On Wed, Jan 7, 2009 at 12:42 AM, Anton Vorontsov
<avorontsov@ru.mvista.com> wrote:
> On Tue, Jan 06, 2009 at 11:33:35PM +0100, Leon Woestenberg wrote:
>> So to summarize, we need u-boot to initialize the PCIe controller, in
>> order for Linux to further take it over.
>>
>> What u-boot versions/releases do provide this initialization?
>
> Only FSL U-Boots so far (i.e. community u-boot + fsl patches).
>
Could you be more specific?

I would like to test your Linux kernel patch for 83xx/PCIe mainlining.


What version (and what patches) of u-boot do both initialize pcie
*and* work with recent Linux kernels?

I am aware of the latest MPC8315E BSP (~2008-06), bitshrine.org/gpp/,
the 83xx git tree at denx, and master git.

The first works with 2.6.24, but not with 2.6.25+
The patches at bitshrine are not newer than that.
The tree's are not FSL, or is this the FSL U-Boot you mean?

>> I know the u-boot with the board works, but it's incompatible with
>> recent Linux kernels.
>
> We should fix that (if possible).
>
I was told "just to upgrade u-boot", not what the actual problem was,
although I would like to learn that.

http://www.mail-archive.com/u-boot-users@lists.sourceforge.net/msg06551.html

Basically, this means I am unable to ship a bootloader now, supporting
2.6.24.7 now and 2.6.28 later.

Regards,
-- 
Leon
