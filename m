Message-ID: <38DC73C2.36142025@iiic.ethz.ch>
Date: Sat, 25 Mar 2000 09:07:30 +0100
From: Michel Dänzer <michdaen@iiic.ethz.ch>
MIME-Version: 1.0
To: khendricks@ivey.uwo.ca
CC: Kostas Gewrgiou <gewrgiou@imbc.gr>, Ani Joshi <ajoshi@shell.unixbox.com>,
        linuxppc-dev@lists.linuxppc.org
Subject: Re: Found bug in mode switching but who is at fault...XFree86 or
 aty128fb.c?
References: <Pine.LNX.4.10.10003230911180.6826-100000@shell.unixbox.com> <00032313263100.01328@localhost.localdomain> <00032423100100.00584@localhost.localdomain> <38DC7171.735D9DF5@iiic.ethz.ch>
Content-Type: text/plain; charset=iso-8859-1
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Michel Dänzer wrote:
>
> Kevin Hendricks wrote:
>
> > This is not a problem if xres == vxres.  Which is what happens when the
> > aty128fb.c starts up.
>
> Not necessarily. The problem could have shown up if someone had put a mode
> with xres < vxres as first in the "Modes" line, but apparently only
> configuration tools tend to do that...

Oops. I misread you were writing about the r128 driver. My apologies.


Michel


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
