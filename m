Date: Tue, 13 Jan 2004 18:09:38 +0100 (MET)
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: Sven Luther <sven.luther@wanadoo.fr>
Cc: Debian PowerPC List <debian-powerpc@lists.debian.org>,
	Linux/PPC Development <linuxppc-dev@lists.linuxppc.org>
Subject: Re: 2.4.21-ben2 issues: RTC, Thermal and RTAS
In-Reply-To: <20040113151230.GA12089@iliana>
Message-ID: <Pine.GSO.4.58.0401131806560.9060@waterleaf.sonytel.be>
References: <20030823171845.GA1963@dat.etsit.upm.es> <20031217011849.GA26643@iliana>
 <Pine.GSO.4.58.0312171042530.24864@waterleaf.sonytel.be> <20031217095241.GD2283@iliana>
 <Pine.GSO.4.58.0312171056030.24864@waterleaf.sonytel.be> <20031217100358.GA2655@iliana>
 <Pine.GSO.4.58.0312171112040.24864@waterleaf.sonytel.be> <20040113151230.GA12089@iliana>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Tue, 13 Jan 2004, Sven Luther wrote:
> On Wed, Dec 17, 2003 at 11:13:58AM +0100, Geert Uytterhoeven wrote:
> > On Wed, 17 Dec 2003, Sven Luther wrote:
> > > On Wed, Dec 17, 2003 at 10:57:07AM +0100, Geert Uytterhoeven wrote:
> > > > It uses the PC-style RTC driver (genrtc.o is not loaded).
> > >
> > > Mmm, what was your box again ? a chrp no ?
> >
> > Yep, CHRP LongTrail. It has a Winbond/Symphony Labs W83C553 SouthBridge.
>
> Could you tell me the content of your rtc OF node ? In particular i am
> interested in the reg value (probably 70/71 in isa space or so), and of
> the compatible stuff (i have ds1385-rtc).

/proc/device-tree/pci/isa@1/rtc/ has:

total 0
-r--r--r--    1 root     root           11 Jan 13 18:06 compatible
-r--r--r--    1 root     root            4 Jan 13 18:06 device_type
-r--r--r--    1 root     root            4 Jan 13 18:06 linux,phandle
-r--r--r--    1 root     root            4 Jan 13 18:06 name
-r--r--r--    1 root     root           12 Jan 13 18:06 reg

compatible:	pnpPNP,b00			(ASCII)
device_type:	rtc				(ASCII)
linux,phandle:	ff86 2aa4			(hexdump)
name:		rtc				(ASCII)
reg:		0000 0001 0000 0070 0000 0002	(hexdump)

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
