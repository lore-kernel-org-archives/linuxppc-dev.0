Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 360DEDDE19
	for <linuxppc-dev@ozlabs.org>; Tue, 13 May 2008 11:06:24 +1000 (EST)
Message-Id: <B96AC01D-4805-4B49-9AFD-A6B4783CE42E@kernel.crashing.org>
From: Kumar Gala <galak@kernel.crashing.org>
To: cbouatmailru@gmail.com
In-Reply-To: <20080512221243.GA1536@zarina>
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Mime-Version: 1.0 (Apple Message framework v919.2)
Subject: Re: [PATCH 1/3] [WATCHDOG] mpc83xx_wdt: add support for MPC86xx CPUs
Date: Mon, 12 May 2008 20:06:08 -0500
References: <64629276-8337-4FFE-B3E1-306678BF179D@kernel.crashing.org>
	<20080512205303.GA14198@zarina> <4828AFBD.1040501@freescale.com>
	<4828B012.9090805@freescale.com> <20080512211856.GA21532@zarina>
	<4828B4BB.2020403@freescale.com> <20080512213529.GA27087@zarina>
	<4828B9D1.9040106@freescale.com> <20080512214858.GA30803@zarina>
	<4828BCC4.3030308@freescale.com> <20080512221243.GA1536@zarina>
Cc: Scott Wood <scottwood@freescale.com>, linuxppc-dev@ozlabs.org,
	Wim Van Sebroeck <wim@iguana.be>, Timur Tabi <timur@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On May 12, 2008, at 5:12 PM, Anton Vorontsov wrote:

> On Mon, May 12, 2008 at 04:55:16PM -0500, Timur Tabi wrote:
>> Anton Vorontsov wrote:
>>
>>> I don't know the IP block name... what is it for the 83xx/86xx
>>> watchdogs?
>>
>> My point was that we developers should just pick a name and run  
>> with it.
>> That's where the name "Elo" came from.  None of official Freescale
>> documentation calls the DMA controller on 85xx parts "Elo", but the
>> kernel code does.
>
> Ahh, I see. Ok, my purpose: name the driver for mpc83xx-like watchdogs
> as mpc83xx_wdt.c? :-)
>
> It's less confusion. For example DMA. I really don't know what the
> "Elo" is. Nobody does actually, except the few people who discussed
> Linux Freescale DMA drivers...

I repeat, name it mpc8xxx_wdt.c or fsl_ppc_soc_wdt.c.

- k
