Return-Path: <kumar.gala@freescale.com>
Received: from az33egw01.freescale.net (az33egw01.freescale.net
	[192.88.158.102]) by ozlabs.org (Postfix) with ESMTP id 583B067A6E
	for <linuxppc-embedded@ozlabs.org>;
	Tue,  8 Mar 2005 04:38:36 +1100 (EST)
In-Reply-To: <422C27FE.6000709@bitsim.se>
References: <422C27FE.6000709@bitsim.se>
Mime-Version: 1.0 (Apple Message framework v619.2)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <f3ed8c626354b5b1b51f355838e877eb@freescale.com>
From: Kumar Gala <kumar.gala@freescale.com>
Date: Mon, 7 Mar 2005 11:38:26 -0600
To: "Jakob Viketoft" <jakob.viketoft@bitsim.se>
Cc: Linux PPC Embedded list <linuxppc-embedded@ozlabs.org>
Subject: Re: Adding machine types to the kernel tree...
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>


On Mar 7, 2005, at 4:07 AM, Jakob Viketoft wrote:

> Thanks for the comments!
>
> Andrew May wrote:
>  > I think a huge first step would be to banish xparameters.h from all 
> the
>  > kernel code.
>  > Our HW guys just seem to do the strangest things without checking.
>  > So I have 2 spins of a board with 2 Virtex-II pro's each.
>  > The 2 spins have a small refrence clock change and the 2 CPU's have
>  > different IRQ mappings.
>
> I understand that there is numerous resentment against having this file
> in the kernel and I've been thinking of a solution without it. One such
> path would be serving the kernel with a OCP list of the devices used,
> but I'm unsure about the current status of OCP. Is this The Right Way 
> to
> do it, or are OCP likely to be abandoned further along the 2.6 road?

If you are talking about 2.6, dont use OCP.  Use the driver model and 
platform devices.  You can take a look at the arch/ppc/syslib/ppc_sys.c 
and arch/ppc/platforms/85xx for examples.

- kumar
