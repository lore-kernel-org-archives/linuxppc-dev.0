Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 717AEDE03B
	for <linuxppc-dev@ozlabs.org>; Fri,  4 Jul 2008 04:36:27 +1000 (EST)
Message-Id: <22CE08E8-F5CD-4CF4-A163-A462500E6497@kernel.crashing.org>
From: Kumar Gala <galak@kernel.crashing.org>
To: Scott Wood <scottwood@freescale.com>
In-Reply-To: <486D1A58.8010403@freescale.com>
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Mime-Version: 1.0 (Apple Message framework v924)
Subject: Re: New fsl device bindings file
Date: Thu, 3 Jul 2008 13:36:16 -0500
References: <40B88BFD-1FEB-4E36-9917-54C7380FF801@kernel.crashing.org>
	<486D1A58.8010403@freescale.com>
Cc: linuxppc-dev list <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On Jul 3, 2008, at 1:28 PM, Scott Wood wrote:

> Kumar Gala wrote:
>> I'm sure you'll hate for doing this, but I've asked Kim to create a  
>> new Documentation/powerpc/fsl-device-tree-bindings.txt as part of  
>> his SEC patch.
>> I'm going to move all the Freescale SoC related bindings into this  
>> new file.  One of the aspects of the new file is we will NOT having  
>> an ordinal heading index.
>
> How about splitting up like this:
>
> Documentation/powerpc/device-tree/fsl/cpm.txt
> Documentation/powerpc/device-tree/fsl/cpm/uart.txt
> Documentation/powerpc/device-tree/fsl/tsec.txt
> Documentation/powerpc/device-tree/interrupts.txt
> Documentation/powerpc/device-tree/dtb.txt
>
> etc?

I like this, we can start with just the fsl/ dirs for now and see if  
others feelings on the other higher level bits.

- k
