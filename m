Return-Path: <kumar.gala@freescale.com>
Received: from az33egw01.freescale.net (az33egw01.freescale.net
	[192.88.158.102]) by ozlabs.org (Postfix) with ESMTP id E4B6567A6C
	for <linuxppc-embedded@ozlabs.org>;
	Fri, 17 Jun 2005 01:02:11 +1000 (EST)
In-Reply-To: <42B11F5B.2050706@intracom.gr>
References: <42B11F5B.2050706@intracom.gr>
Mime-Version: 1.0 (Apple Message framework v619.2)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <bf22963c817dc3a1dc62a682c30c5a4a@freescale.com>
From: Kumar Gala <kumar.gala@freescale.com>
Date: Thu, 16 Jun 2005 10:02:03 -0500
To: "Pantelis Antoniou" <panto@intracom.gr>
Cc: linuxppc-embedded <linuxppc-embedded@ozlabs.org>
Subject: Re: RFC: cpm2_devices.c
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

I'm not sure I follow on what you want done.  I done see the 
pq2_device.c file changing much once we put it in place.  If there is a 
little duplication between pq1_device.c, pq2_device.c and 
mpc85xx_device.c I'm not to concerned about it since the only 
information in there is memory offsets and IRQs.

If the structures for an SCC uart driver are the same for PQ1 and PQ2 
then I would expect the SCC uart driver to handle that fact going 
forward.

- kumar

On Jun 16, 2005, at 1:42 AM, Pantelis Antoniou wrote:

> Let me hop in here...
>
> Have you thought about breaking up the structures per
> cpm peripheral?
>
> Some registers are unique for each processor family, but
> others are (almost) common to all.
>
> For example SCC parameters & stuff are the same on 8xx/82xx ...
>
> IMHO keeping one definition in the tree for these will make
> keeping them in sync easier.
>
> Then the main header file will be the definitions of the
> unique registers, a number of defines for the structures offsets
> and a list of included files for the common peripherals...
>
> Regards
>
> Pantelis
