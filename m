Message-ID: <398C60D0.BF0D2778@valinux.com>
Date: Sat, 05 Aug 2000 14:45:36 -0400
From: Gareth Hughes <gareth@valinux.com>
MIME-Version: 1.0
To: Kostas Gewrgiou <gewrgiou@imbc.gr>
CC: Michel Ddnzer <daenzerm@student.ethz.ch>, dri-devel@lists.sourceforge.net,
        linuxppc-dev@lists.linuxppc.org
Subject: Re: [Dri-devel] Re: Kind of success! (r128 on PPC (Re: LinuxPPC X
 Server))
References: <Pine.LNX.4.21.0008041831040.29474-100000@idd-01.imbc.gr>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Kostas Gewrgiou wrote:
>
> >
> > About performance: It's much better than software rendering (at least for big
> > windows) of course, however not too fast with lots of polygons. AGP GART would
> > definitely be a good thing I guess (Ben: hint, hint :)
> >
>
> Do you have any numbers from gears, glquake etc ??

Is someone working on the AGP GART module for PPC Linux?  Without that,
you're stuck with PIO mode which can be slower than software rendering.

Again, I'd love to help you guys out.  Do you have patches we could look
at?

-- Gareth

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
