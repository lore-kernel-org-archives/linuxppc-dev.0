Message-ID: <3911FA58.615BC161@mondonet.net>
Date: Fri, 05 May 2000 00:31:52 +0200
From: Mario Scarpa <m.scarpa@mondonet.net>
MIME-Version: 1.0
CC: Gabriel Ricard <g_ricard@yahoo.com>, linuxppc-dev@lists.linuxppc.org
Subject: Re: Lombard hard freeze (still there)
References: <Pine.LNX.4.10.10005041802480.30927-100000@opal.biophys.uni-duesseldorf.de>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Michael Schmitz wrote:
>
> > > include a wandering mouse pointer: i.e. when I am
> > > typing rapidly, X will occasionally think I've clicked
> > > the mouse button and the focus goes to where the
> > > pointer was located.
> >
> > Same for me. And it is really annoying to write the
> > emails two or three times ;-)
> > My mouse is a brand x 5$ usb mouse with three buttons...
>
> That's Xpmac or FBDev? I'm using FBDev on 2.2.15pre9 and have no such
> problems. And I can't imagine mouse data ending up as keyboard data except
> for Xpmac (where mouse data are fed to the X tty prefixed by a special
> escape char. Make X choke and drop the escape char, and you probably get
> what you described. Or get a garbled keyboard char, similar effect).


Indeed it was my Xpmac try...cannot remember (or be sure) about
it happening under FBDev (which I am currently using)...good to
know.

Cheers,

--
Mario Scarpa

Mondonet NOC
Phone: +39 06 52.47.37.02

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
