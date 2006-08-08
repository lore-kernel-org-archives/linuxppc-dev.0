Return-Path: <galak@kernel.crashing.org>
Received: from nommos.sslcatacombnetworking.com
	(nommos.sslcatacombnetworking.com [67.18.224.114])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id C6FFD67B52
	for <linuxppc-embedded@ozlabs.org>;
	Wed,  9 Aug 2006 01:04:03 +1000 (EST)
In-Reply-To: <20060808135020.GG26606@igloo.df.lth.se>
References: <20060808135020.GG26606@igloo.df.lth.se>
Mime-Version: 1.0 (Apple Message framework v752.2)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Message-Id: <5C1C19D6-8FC8-46AF-9C4B-B9989B1A997B@kernel.crashing.org>
From: Kumar Gala <galak@kernel.crashing.org>
Subject: Re: PowerPC Local Bus
Date: Tue, 8 Aug 2006 10:03:59 -0500
To: Fredrik Roubert <roubert@df.lth.se>
Cc: linuxppc-embedded@ozlabs.org
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>


On Aug 8, 2006, at 8:50 AM, Fredrik Roubert wrote:

> Hi!
>
> I'm about to write drivers for some FPGA's that are connected to the
> local bus of a PowerQUICC II Pro processor and use the user- 
> programmable
> machines (UPM's) to transfer data over the bus. What code does already
> exist for Linux to help me with this? In the stock kernels, I can't  
> even
> find a structure definition for the registers of the local bus
> controller, but it seems strange that no-one has written such code
> before me. Will I really have to write everything from scratch, or  
> what
> code is there that I don't know about yet?


The reason you haven't seen any code is due to several reasons.  One,  
FPGA/localbus implementations can be very specific and thus reuse is  
difficult.  Two, some of this code tends to end up it boot loaders to  
setup the UPM (take a look at U-boot for possible UPM config code).

- kumar
