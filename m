Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 6A0DADE08B
	for <linuxppc-dev@ozlabs.org>; Tue, 13 Jan 2009 06:01:59 +1100 (EST)
Message-Id: <E8C76EB3-7E8E-4E24-BF20-2BE5C7DA2512@kernel.crashing.org>
From: Kumar Gala <galak@kernel.crashing.org>
To: Leon Woestenberg <leon.woestenberg@gmail.com>
In-Reply-To: <c384c5ea0901120920u7cd349b3te9c57301d204aa55@mail.gmail.com>
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Mime-Version: 1.0 (Apple Message framework v929.2)
Subject: Re: [PATCH] powerpc/83xx: Make serial ports work on MPC8315E-RDB
	w/FSL U-Boots
Date: Mon, 12 Jan 2009 12:59:50 -0600
References: <20090111153013.GA31791@oksana.dev.rtsoft.ru>
	<3A45394FD742FA419B760BB8D398F9ED13DD10@zch01exm26.fsl.freescale.net>
	<C37C3C8D-0DAA-4174-9A19-E2983CD32380@kernel.crashing.org>
	<c384c5ea0901120920u7cd349b3te9c57301d204aa55@mail.gmail.com>
Cc: linuxppc-dev@ozlabs.org, Li Yang <leoli@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On Jan 12, 2009, at 11:20 AM, Leon Woestenberg wrote:

> Hello,
>
> On Mon, Jan 12, 2009 at 4:07 PM, Kumar Gala  
> <galak@kernel.crashing.org> wrote:
>> On Jan 12, 2009, at 1:55 AM, Li Yang wrote:
>>>> -----Original Message-----
>>> Freescale BSP is for customer who needs the out-of-box  
>>> experience.  It's
>>> better tested, but doesn't update very frequently.  I would  
>>> suggest the
>>> customer to use the upstream u-boot, if they decide to use latest
>>> upstream kernel.
>>>
>>
> The upstream u-boot did however not support PCI Express, which the
> latest Freescale kernel did.
>
> So it was a chicken-egg problem experience for people wanting to test
> both the latest Freescale kernel as well as Antov's work to bring the
> PCI Express support upstream.
>
> Thanks Antov et al,

Please gripe at your Freescale contacts about getting code into  
mainline/upstream kernel.

(The more they hear it from customers the more importance it will  
get.  The team I work on at Freescale can focus on only so much and  
the other groups need to hear that customers want code in mainline.)

And thanks Anton for cleaning all this up and getting it in a state  
that is acceptable :)

- k
