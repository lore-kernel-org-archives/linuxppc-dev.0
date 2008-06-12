Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 6AEC5DE1DC
	for <linuxppc-dev@ozlabs.org>; Fri, 13 Jun 2008 09:01:47 +1000 (EST)
Message-Id: <4D6BC3F2-C43D-4317-B0BE-AF0A551E6CF1@kernel.crashing.org>
From: Kumar Gala <galak@kernel.crashing.org>
To: Ron Madrid <ron_madrid@sbcglobal.net>
In-Reply-To: <85644.91618.qm@web83508.mail.sp1.yahoo.com>
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Mime-Version: 1.0 (Apple Message framework v924)
Subject: Re: Using DMA interrupt on MPC8313
Date: Thu, 12 Jun 2008 18:01:41 -0500
References: <85644.91618.qm@web83508.mail.sp1.yahoo.com>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

The dmaengine provides a generic set of APIs w/a FSL dma backend.  It  
might be the case that your need of dma doesnt fit into the current  
set of APIs.

- k

On Jun 12, 2008, at 3:04 PM, Ron Madrid wrote:

> Well in that case wouldn't I need to use the fsldma driver?  Or is  
> dmaengine a generic dma driver?
>
> Ron
> --- Kumar Gala <galak@kernel.crashing.org> wrote:
>
>>
>> On Jun 12, 2008, at 2:35 PM, Ron Madrid wrote:
>>
>>> I'm trying to write a driver that would make use of the DMA on the
>>> MPC8313.  I'm attempting to
>>> register the interrupt with request_irq but it is not passing.  Is
>>> there something that I need to
>>> do before I call request_irq, maybe in the dts or somewhere else?
>>
>>
>> any reason you aren't using the dmaengine driver?
>>
>> - k
>>
