Return-Path: <chuckmeade@mindspring.com>
Received: from txslsmtp2.vzwmail.net (unknown [66.174.85.156])
	by ozlabs.org (Postfix) with ESMTP id 1E5B967A5D
	for <linuxppc-embedded@ozlabs.org>;
	Wed, 14 Jun 2006 12:26:57 +1000 (EST)
From: "Chuck Meade" <chuckmeade@mindspring.com>
To: "Joakim Tjernlund" <joakim.tjernlund@transmode.se>,
	"'Kumar Gala'" <galak@kernel.crashing.org>,
	"'Alex Zeffertt'" <ajz@cambridgebroadband.com>
Subject: RE: No ttyS device at I/O port 0xfe004500 for console
Date: Tue, 13 Jun 2006 22:27:52 -0400
Message-ID: <IIEEICKJLNEPBBDJICNGEEGDLDAA.chuckmeade@mindspring.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
In-Reply-To: <001301c68f48$24f80890$0e67a8c0@Jocke>
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

Hi Joakim,

> > > Here you go:
> > 
> > Thanks, now it boot into the ramdisk and a get a login prompt 
> > and all, but I don't see any output during kernel 
> > startup(only a few garbage chars).
> > Tried the console params Alex sent but makes no difference. 
> > How does your cmdline look like?
> 
> ahem, I forgot the obvious console=ttyS0. Now it works, thanks a lot

Sure no problem.

Chuck
