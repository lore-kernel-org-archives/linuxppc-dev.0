Return-Path: <seanm@seanm.ca>
Received: from yow.seanm.ca (toronto-hs-216-138-233-67.s-ip.magma.ca
	[216.138.233.67]) by ozlabs.org (Postfix) with SMTP id 0AB69DE1B8
	for <linuxppc-dev@ozlabs.org>; Sun, 13 Apr 2008 11:55:46 +1000 (EST)
Date: Sat, 12 Apr 2008 21:55:44 -0400
From: Sean MacLennan <seanm@seanm.ca>
To: "Stephen Rothwell" <sfr@canb.auug.org.au>
Subject: Re: Warp patches for 2.6.26
Message-ID: <20080412215544.38fa2d0b@lappy.seanm.ca>
In-Reply-To: <20080413104430.c98244d2.sfr@canb.auug.org.au>
References: <20080412134831.424480cf@lappy.seanm.ca>
	<20080413104430.c98244d2.sfr@canb.auug.org.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Sun, 13 Apr 2008 10:44:30 +1000
"Stephen Rothwell" <sfr@canb.auug.org.au> wrote:

> Hi Sean,
> 
> First comment is that you need reasonable changelogs i.e. explain why
> you are making changes as well as what they do.  Also the first line
> of each changelog (which becomes the subject of any mail generated
> from git) should be a useful and relatively unique summary.
> 

These patches are an amalgamation of a lot of commits. For
example, warp.c was changed 15 times since I last sent a patch to
linuxppc-dev. warp-nand.c was probably changed even more as we kept
shifting the design.

One of the advantages of an FPGA based design is you can work around a
lot of hardware problems. A disadvantage is that it is easy to change,
so it changes a lot. And the HW guys push the specs out to after they
actually get the feature going. There is no SW input into the FPGA
design.

So these patches are basically following the changes to the FPGA and
changes to the hardware. As new functionality was added, I updated the
code.

Is there a particular way I should word this to make it a changelog?

Cheers,
   Sean
