Return-Path: <tnt@246tNt.com>
Received: from outmx016.isp.belgacom.be (outmx016.isp.belgacom.be
	[195.238.4.115])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 43D39DDED7
	for <linuxppc-dev@ozlabs.org>; Mon, 14 May 2007 15:18:38 +1000 (EST)
Received: from outmx016.isp.belgacom.be (localhost [127.0.0.1])
	by outmx016.isp.belgacom.be (8.12.11.20060308/8.12.11/Skynet-OUT-2.22)
	with ESMTP id l4E5IUHU004687
	for <linuxppc-dev@ozlabs.org>; Mon, 14 May 2007 07:18:30 +0200
	(envelope-from <tnt@246tNt.com>)
Message-ID: <4647F084.30109@246tNt.com>
Date: Mon, 14 May 2007 07:15:48 +0200
From: Sylvain Munaut <tnt@246tNt.com>
MIME-Version: 1.0
To: Matt Sealey <matt@genesi-usa.com>
Subject: Re: [PATCH 4/9] powerpc: BestComm core support for Freescale MPC5200
References: <11790019171838-git-send-email-tnt@246tNt.com>	<200705130127.08761.arnd@arndb.de>
	<46465295.90309@246tNt.com>	<200705130224.46114.arnd@arndb.de>
	<4646BB76.1080602@246tNt.com> <46479F64.6020907@genesi-usa.com>
In-Reply-To: <46479F64.6020907@genesi-usa.com>
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

Matt Sealey wrote:
> Sylvain Munaut wrote:
>   
>>>> However, you could totally implement a "DMA devices" that would just
>>>> use a simple "copy from there to there" task using this BestComm driver.
>>>> So other part of the kernel (like network) could use that interface to
>>>> use the dma engine ...
>>>>     
>>>>         
>>> Can it also do the advanced operations like XOR on DMA that the
>>> Intel ioat has? That would be even more interesting, I guess.
>>>   
>>>       
>> Actually yes it can.
>> It just need someone motivated enough to write it ;)
>>     
>
> Isn't there an XOR-while-copying-DMA example somewhere?
>   
Never saw it. But in the gen BD task it's easy to find the DRD that
really does the copy and using the hand assembly guide and the
example DRD than auto-shutdown the task, it's possible to figure out
how to replace that simple DRD by a one calling xor in EU3.
> I'm sure I've seen reference to it, or it being used somewhere.. to
> be honest the worst part of using BestComm is it's only well documented
> on how to use tasks and how to set up the engine, actually writing them
> is some kind of black art which Freescale hold close to their chest.
>   
No kidding ;)

   Sylvain
