Message-ID: <399BA174.A02BBE43@relog.ch>
Date: Thu, 17 Aug 2000 10:25:24 +0200
From: Michel Dänzer <daenzer@relog.ch>
Reply-To: daenzerm@student.ethz.ch
MIME-Version: 1.0
To: "David A. Gatwood" <dgatwood@deepspace.mklinux.org>
CC: linuxppc-dev@lists.linuxppc.org
Subject: Re: Xlib Question
References: <Pine.LNX.3.96.1000816200011.30198E-100000@deepspace.mklinux.org>
Content-Type: text/plain; charset=iso-8859-1
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


"David A. Gatwood" wrote:

> > > xlib messages stop being delivered from xlib to the program, resulting
> > > in XNextEvent stalling.  Most of the time, if you click somewhere in
> > > that window, those events all get delivered at once, sometimes twenty or
> > > thirty at a time.
> >
> > I've noticed that Netscape often stalls up/downloads to/from the roaming
> > access server. When I click into the window, it continues. Is that the
> > problem you are seeing as well?
>
> I'm actually seeing the thing not update the window, then when you click
> over to another one, and click back, the thing (most of the time) updates.

Yes, that's what I mean. If only the window updates stalled, it wouldn't be a
problem, but for me the transfer stalls as well.


> > This makes me suspect the 4.0.1 server (I don't remember it happening with
> > 4.0), are you using that as well?
>
> No, using Xpmac, from 3.3.6 XFree.

Hmm. Wonder what's causing this then - I'm pretty sure it didn't happen some
time ago.


Michel


--
Earthling Michel Dänzer (MrCooper)  \  CS student and free software enthusiast
Debian GNU/Linux (powerpc,i386) user \   member of XFree86 and the DRI project

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
