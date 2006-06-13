Return-Path: <joakim.tjernlund@transmode.se>
Received: from tmnt04.transmode.se (147.175.241.83.in-addr.dgcsystems.net
	[83.241.175.147]) by ozlabs.org (Postfix) with ESMTP id F273767A79
	for <linuxppc-embedded@ozlabs.org>;
	Wed, 14 Jun 2006 06:58:30 +1000 (EST)
From: "Joakim Tjernlund" <joakim.tjernlund@transmode.se>
To: "'Kumar Gala'" <galak@kernel.crashing.org>,
	"'Alex Zeffertt'" <ajz@cambridgebroadband.com>
Subject: RE: No ttyS device at I/O port 0xfe004500 for console
Date: Tue, 13 Jun 2006 22:46:13 +0200
Message-ID: <000f01c68f2a$68b83960$0e67a8c0@Jocke>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
In-Reply-To: <2CFF4933-A9D2-4981-BD11-C38537CE193B@kernel.crashing.org>
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

> On Jun 13, 2006, at 11:48 AM, Alex Zeffertt wrote:
> 
> > Hi list,
> >
> > I'm trying to boot a linux-2.6.11 kernel on a MPC83xx based 
> board.   
> > Through
> > some experimentation I have found I need 
> "console=uart,io,0xfe004500"
> > in the kernel command line in order to get any output over 
> the serial 
> > port.
> >
> > Half way through initialisation the kernel appears to swap from its 
> > "early"
> > 8250 serial driver to a "full" 8250 serial driver.  At this 
> point it 
> > prints "No ttyS device at I/O port 0xfe004500 for console" 
> and there 
> > is no further output.
> >
> > Does anyone have any idea what I may be doing wrong?
> >
> > BTW, here's the output that I do get.
> 
> Alex, where did you get this 2.6.11 kernel?  The public tree 
> didn't have support for 83xx in 2.6.11.  I'd suggest looking 
> at using something newer like 2.6.16 and see if you have the 
> same issue.

I suspect he got from the same place I did, freescales LTIB dev. env.
which has been patched to support 832x. I am having the same problem as he
has, any info on what the problem might be would be great.

Also, if anyone has any info on when these patches will be sent upstream, I 
sure would like to hear about it.

 Jocke
