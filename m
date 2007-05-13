Return-Path: <matt@genesi-usa.com>
Received: from mail.genesi-usa.com (mithrandir.softwarenexus.net
	[66.98.186.96])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 9BB69DDDF7
	for <linuxppc-dev@ozlabs.org>; Mon, 14 May 2007 09:29:19 +1000 (EST)
Message-ID: <46479F64.6020907@genesi-usa.com>
Date: Mon, 14 May 2007 00:29:40 +0100
From: Matt Sealey <matt@genesi-usa.com>
MIME-Version: 1.0
To: Sylvain Munaut <tnt@246tNt.com>
Subject: Re: [PATCH 4/9] powerpc: BestComm core support for Freescale MPC5200
References: <11790019171838-git-send-email-tnt@246tNt.com>	<200705130127.08761.arnd@arndb.de>
	<46465295.90309@246tNt.com>	<200705130224.46114.arnd@arndb.de>
	<4646BB76.1080602@246tNt.com>
In-Reply-To: <4646BB76.1080602@246tNt.com>
Content-Type: text/plain; charset=UTF-8
Cc: linuxppc-dev@ozlabs.org, Arnd Bergmann <arnd@arndb.de>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Sylvain Munaut wrote:
>>> However, you could totally implement a "DMA devices" that would just
>>> use a simple "copy from there to there" task using this BestComm driver.
>>> So other part of the kernel (like network) could use that interface to
>>> use the dma engine ...
>>>     
>> Can it also do the advanced operations like XOR on DMA that the
>> Intel ioat has? That would be even more interesting, I guess.
>>   
> Actually yes it can.
> It just need someone motivated enough to write it ;)

Isn't there an XOR-while-copying-DMA example somewhere?

I'm sure I've seen reference to it, or it being used somewhere.. to
be honest the worst part of using BestComm is it's only well documented
on how to use tasks and how to set up the engine, actually writing them
is some kind of black art which Freescale hold close to their chest.

-- 
Matt Sealey <matt@genesi-usa.com>
Genesi, Manager, Developer Relations
