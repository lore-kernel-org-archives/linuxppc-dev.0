Return-Path: <joakim.tjernlund@transmode.se>
Received: from tmnt04.transmode.se (147.175.241.83.in-addr.dgcsystems.net
	[83.241.175.147]) by ozlabs.org (Postfix) with ESMTP id C1F7367B2A
	for <linuxppc-embedded@ozlabs.org>;
	Wed, 14 Jun 2006 09:53:42 +1000 (EST)
From: "Joakim Tjernlund" <joakim.tjernlund@transmode.se>
To: "'Chuck Meade'" <chuckmeade@mindspring.com>,
	"'Kumar Gala'" <galak@kernel.crashing.org>,
	"'Alex Zeffertt'" <ajz@cambridgebroadband.com>
Subject: RE: No ttyS device at I/O port 0xfe004500 for console
Date: Wed, 14 Jun 2006 01:53:36 +0200
Message-ID: <001201c68f44$962c1fa0$0e67a8c0@Jocke>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
In-Reply-To: <IIEEICKJLNEPBBDJICNGCEFHLDAA.chuckmeade@mindspring.com>
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

Hi Chuck

> 
> > > Hi Joakim,
> > > 
> > > Same here -- go into arch/ppc/platforms/83xx and edit file 
> > > mpc83xx_sys.c.
> > > If you are using the 8323e cpu, then you need to make sure
> > 
> > Yes, got one of those.
> >  
> > > that file has code to support the 8323E.  Mine didn't, so 
> I got no 
> > > platform devices initialized (no serial port, no Eth 
> devs).  I added 
> > > a block of code to support the 8323E (set mask to 0xffff0000 and 
> > > "value" to 0x80620000, then the device list for the 8323E).  Use 
> > > existing code there as a guide, it was not difficult once 
> I figured 
> > > out that this was the problem.
> > 
> > hmm, you don't have a patch handy?
> 
> Here you go:

Thanks, now it boot into the ramdisk and a get a login prompt and all, but I don't
see any output during kernel startup(only a few garbage chars).
Tried the console params Alex sent but makes no difference. How does
your cmdline look like?
