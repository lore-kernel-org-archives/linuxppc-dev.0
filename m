From: "Ron Bianco" <ronb@junction.net>
To: "Gregory Allen" <gallen@arlut.utexas.edu>
Cc: <linuxppc-embedded@lists.linuxppc.org>
Subject: RE: Ethernet controller
Date: Fri, 19 Jan 2001 12:23:16 -0800
Message-ID: <000001c08255$a7bf3150$4d012ac7@warp-speed>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
In-reply-to: <200101181805.MAA88737@ns5.arlut.utexas.edu>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Hi Greg,

We've been using the 82559 on our custom 8240 board.
The microBGA package required really tiny vias because of the tight pad spacing, but
otherwise was easy to deal with in layout.
BTW, we put in interstitial vias for all the pads, for a couple of reasons.  I can
elaborate if desired.

We used a suggested xformer:  Pulse H1012, and kept the pairs of ethernet signals as
short as possible and the xformer really close to the connector.  Total board space
used was about 2" x 1" including connector!

The eepro100 driver seems to work well and we're getting good 100baseT performance.
Haven't really had time to come up with hard benchmarks, yet, as I've been really
busy working on a custom device driver for another subsystem.  If you had a test
method to suggest, I could probably sqeeze it in.   Pretty modern bus mastering chip
tho' I'd say.

We've been struggling along with linux 2.3.16 which, due to a probably mm(u) related
bug, is unstable if using either an initrd or SCSI disk as root.  Especially
difficult loading and running init properly from initrd.

We'll be porting to 2.4.x as soon as time allows, and for now an nfsroot is working
OK.

Cheers, Ron

Ron Bianco
Computer Systems Technologist
Level Control Systems
email: ronb@junction.net
phone: 250-549-2558 Ext 8
web:  www.lcsaudio.com

> -----Original Message-----
> From: owner-linuxppc-embedded@lists.linuxppc.org
> [mailto:owner-linuxppc-embedded@lists.linuxppc.org]On Behalf Of Gregory
> Allen
> Sent: Thursday, January 18, 2001 10:05 AM
> To: linuxppc-embedded@lists.linuxppc.org
> Subject: Ethernet controller
>
>
>
> I am designing an embedded PPC8240 board with an ethernet interface. I am
> down to 2 choices: i82559 and RTL8139
>
> I prefer to avoid the BGA package of the i82559, but the RTL8139 driver
> support is listed as having "limited PowerPC testing". I am also curious
> about their relative performance.
>
> Can anyone speak to this?
>
> Thanks,
> -Greg
>
> ------
>  Gregory E. Allen, MSEE Research Engineer
>  Applied Research Laboratories:
>  The University of Texas at Austin
>
>


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
