Return-Path: <mmporter@cox.net>
Received: from fed1rmmtao07.cox.net (fed1rmmtao07.cox.net [68.230.241.32])
	by ozlabs.org (Postfix) with ESMTP id 13DB72BDF2
	for <linuxppc-embedded@ozlabs.org>;
	Fri, 12 Nov 2004 15:20:54 +1100 (EST)
Date: Thu, 11 Nov 2004 21:20:47 -0700
From: Matt Porter <mporter@kernel.crashing.org>
To: "Howard, Marc" <Marc.Howard@KLA-Tencor.com>
Message-ID: <20041111212047.B5291@home.com>
References: <91B22F93A880FA48879475E134D6F0BE283EBD@CA1EXCLV02.adcorp.kla-tencor.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <91B22F93A880FA48879475E134D6F0BE283EBD@CA1EXCLV02.adcorp.kla-tencor.com>;
	from Marc.Howard@KLA-Tencor.com on Thu, Nov 11, 2004 at 06:19:02PM
	-0800
Cc: linuxppc-embedded@ozlabs.org
Subject: Re: Trouble booting uboot on 440GX (ocotea) eval board after
	initial power-up boot
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

On Thu, Nov 11, 2004 at 06:19:02PM -0800, Howard, Marc wrote:
> Hi,
> 
> I've built and installed U-Boot 1.1.2 on an IBM 440GX eval board
> (ocotea).  After powering the board I can get the uboot interactive
> prompt.  If I type 'reset' or hit the reset button it hangs.  I get the
> same results whether or not I use the BDI2000.  Doing a power cycle of
> the board is the only way to get back to the prompt.
> 
> Is there some reconfiguation U-Boot does that causes the processor boot
> address to change after the initial power-up?  Am I missing something
> here?

You might find more help on the u-boot users list.

-Matt
