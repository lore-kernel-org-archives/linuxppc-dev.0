Return-Path: <seanm@seanm.ca>
Received: from yow.seanm.ca (toronto-hs-216-138-233-67.s-ip.magma.ca
	[216.138.233.67]) by ozlabs.org (Postfix) with SMTP id CF19DDDFE3
	for <linuxppc-dev@ozlabs.org>; Sun, 13 Apr 2008 12:38:34 +1000 (EST)
Date: Sat, 12 Apr 2008 22:38:33 -0400
From: Sean MacLennan <seanm@seanm.ca>
To: "Grant Likely" <grant.likely@secretlab.ca>
Subject: Re: Warp patches for 2.6.26
Message-ID: <20080412223833.27ca5f23@lappy.seanm.ca>
In-Reply-To: <fa686aa40804121909s4ee04731ua63afa76fe088828@mail.gmail.com>
References: <20080412134831.424480cf@lappy.seanm.ca>
	<20080413104430.c98244d2.sfr@canb.auug.org.au>
	<20080412215544.38fa2d0b@lappy.seanm.ca>
	<fa686aa40804121909s4ee04731ua63afa76fe088828@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: Stephen Rothwell <sfr@canb.auug.org.au>, linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

 
> A changelog of "updates a bunch of stuff" is pretty much irrelevant in
> all situations I can think of.

Ok, I hope I got everything:

Changes to match new FPGA/HW functionality.
* Switched from 64M NOR/64M NAND to 4M NOR/256M NAND.
* Moved/resized partitions to match the flash changes.
* Fixup code added for Rev A boards to handle flash changes.
* Added DTM critical temperature.
* Added DTM fan error - currently disable in FPGA.
* Added POST information.
* Removed LED function, moved to new LED driver.
* Moved ad7414 to new style I2C initialization.


Cheers,
   Sean
