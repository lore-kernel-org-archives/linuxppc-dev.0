Return-Path: <leon.woestenberg@gmail.com>
Received: from mail-bw0-f10.google.com (mail-bw0-f10.google.com
	[209.85.218.10]) by ozlabs.org (Postfix) with ESMTP id 68141474CC
	for <linuxppc-dev@ozlabs.org>; Tue,  6 Jan 2009 23:19:34 +1100 (EST)
Received: by bwz3 with SMTP id 3so20638391bwz.9
	for <linuxppc-dev@ozlabs.org>; Tue, 06 Jan 2009 04:19:32 -0800 (PST)
Message-ID: <c384c5ea0901060418x48c507afq26bf6cec109ed9c4@mail.gmail.com>
Date: Tue, 6 Jan 2009 13:18:56 +0100
From: "Leon Woestenberg" <leon.woestenberg@gmail.com>
To: avorontsov@ru.mvista.com
Subject: Re: [PATCH v2 4/4] powerpc/83xx: Add PCI-E support for all MPC83xx
	boards with PCI-E
In-Reply-To: <20090105180122.GA12237@oksana.dev.rtsoft.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
References: <20081229164040.GD8215@oksana.dev.rtsoft.ru>
	<C96CE59B-05FA-4728-930F-D4430EFB9B99@kernel.crashing.org>
	<20081230201916.GA20059@oksana.dev.rtsoft.ru>
	<1F7739C2-930B-49C1-B8FF-679AF1BBAEAE@kernel.crashing.org>
	<20081231171017.6FCF585AD247@gemini.denx.de>
	<B64DF110-E26A-4229-8384-E7933732BC01@kernel.crashing.org>
	<20090105174645.GA23766@ld0162-tx32.am.freescale.net>
	<20090105180122.GA12237@oksana.dev.rtsoft.ru>
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

Hello,

On Mon, Jan 5, 2009 at 7:01 PM, Anton Vorontsov
<avorontsov@ru.mvista.com> wrote:
> On Mon, Jan 05, 2009 at 11:46:45AM -0600, Scott Wood wrote:
> [...]
>> > My statement was to convey that the kernel.org kernel should only
>> > worry itself with the denx.de u-boot (w/regards to compatibility).
>>
>> Why?  Unless the BSP u-boots do something insane, I think we should try
>> to have the upstream kernel boot on the u-boot that comes on the board
>> (it's not nice to require users to reflash unnecessarily).
>

The u-boot that came with the boards (at least MPC8315E-RDB) is too
old for 2.6.25+ kernels:

I have run into this earlier:

http://www.mail-archive.com/u-boot-users@lists.sourceforge.net/msg06551.html



Regards,
-- 
Leon
