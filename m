Return-Path: <kumar.gala@freescale.com>
Received: from az33egw01.freescale.net (az33egw01.freescale.net
	[192.88.158.102]) by ozlabs.org (Postfix) with ESMTP id 2898167A64
	for <linuxppc-embedded@ozlabs.org>;
	Wed,  9 Mar 2005 11:34:14 +1100 (EST)
In-Reply-To: <422E3CCD.4020204@kylo.net>
References: <422E3CCD.4020204@kylo.net>
Mime-Version: 1.0 (Apple Message framework v619.2)
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Message-Id: <720b2b390f49b33d5457acde69c745a2@freescale.com>
From: Kumar Gala <kumar.gala@freescale.com>
Date: Tue, 8 Mar 2005 18:34:05 -0600
To: "Kylo Ginsberg" <kylo@kylo.net>
Cc: inuxppc-embedded List <linuxppc-embedded@ozlabs.org>
Subject: Re: Recommended kernel version/tree for use with MPC8555E?
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Kylo,

All active development for PPC (including the MPCE8555E) is being done=20=

in 2.6 only at this point.  I would recommend using 2.6.11 as a=20
starting point.  Any code to support new features of the MPC8555E will=20=

be developed for 2.6 at this point.

The 2.6.11 tree has support for both the MPC8560 ADS board=20
(mpc8560_ads_defconfig) and the MPC8555 CDS board=20
(mpc8555_cds_defconfig).  Those should be good starting points for any=20=

work you are doing.

- kumar

On Mar 8, 2005, at 6:01 PM, Kylo Ginsberg wrote:

> I've just started working on s/w for an 8555E-based board.=A0 On the=20=

> 8555E
> I will be using the TSECs (Gigabit ethernet interfaces), DMA engines,
> the security engine, UARTs, DDR and Local Bus controllers and that's
> about it.
>
> Right now I've got an MPC8560ADS eval board to test against.=A0 This=20=

> board
> came with a 2.4.26-based kernel; it boots ok and runs the basic apps
>  fine, however I haven't yet had an opportunity to exercise the wide
> array of functionality on the chip, so I don't know what gotchas or
> porting difficulties I might meet ahead.
>
> Based on that, what kernel version/tree would you recommend?=A0 Should =
I
> stick with what I've got, move to a ppc-specific 2.4 tree, or jump to
> 2.6.x?=A0 Are there performance/features vs. stability tradeoffs I =
should
> be warned of?
>
> Thanks in advance for any thoughts you may have.
>
> Kylo
>  _______________________________________________
> Linuxppc-embedded mailing list
>  Linuxppc-embedded@ozlabs.org
> https://ozlabs.org/mailman/listinfo/linuxppc-embedded
