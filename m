Return-Path: <leon.woestenberg@gmail.com>
Received: from mail-qy0-f21.google.com (mail-qy0-f21.google.com
	[209.85.221.21]) by ozlabs.org (Postfix) with ESMTP id 101BADDDFB
	for <linuxppc-dev@ozlabs.org>; Thu,  4 Dec 2008 00:57:26 +1100 (EST)
Received: by qyk14 with SMTP id 14so5915709qyk.9
	for <linuxppc-dev@ozlabs.org>; Wed, 03 Dec 2008 05:57:24 -0800 (PST)
Message-ID: <c384c5ea0812030557q1293a2beo3a306e176c306e0a@mail.gmail.com>
Date: Wed, 3 Dec 2008 14:57:24 +0100
From: "Leon Woestenberg" <leon.woestenberg@gmail.com>
To: "Trent Piepho" <tpiepho@freescale.com>
Subject: Re: [U-Boot] NAND only (no NOR)
In-Reply-To: <Pine.LNX.4.64.0812022339030.10176@t2.domain.actdsltmp>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
References: <4934F7FC.2030105@aimvalley.nl>
	<20081202215033.501f3403@lappy.seanm.ca>
	<200812030648.57618.sr@denx.de>
	<20081203013818.016619b6@lappy.seanm.ca>
	<Pine.LNX.4.64.0812022339030.10176@t2.domain.actdsltmp>
Cc: linuxppc-dev@ozlabs.org, u-boot@lists.denx.de, Stefan Roese <sr@denx.de>,
	Norbert van Bolhuis <nvbolhuis@aimvalley.nl>,
	Sean MacLennan <smaclennan@pikatech.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Hello,

On Wed, Dec 3, 2008 at 8:40 AM, Trent Piepho <tpiepho@freescale.com> wrote:
> On Wed, 3 Dec 2008, Sean MacLennan wrote:
>>> Yes, I would recommend to do it this way if possible. A small NOR for
>>> U-Boot and environment and everything else in NAND. This makes things
>>> much easier. But I understand that this is sometimes a problem with
>>> space (2 FLASH chips) and costs.
>>
>> Mainly cost. We didn't want to pay for a second chip.
>
> I think for NAND the latches necessary to de-multiplex the localbus aren't
> necessary like they are for NOR?  On our board the latches might even take
> more space than the flash chip.

The local bus can be configured to run non-multiplexed.

Regards,
-- 
Leon
