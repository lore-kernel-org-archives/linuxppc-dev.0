Date: Thu, 4 May 2000 18:07:07 +0200 (CEST)
From: Michael Schmitz <schmitz@opal.biophys.uni-duesseldorf.de>
To: Mario Scarpa <m.scarpa@mondonet.net>
cc: Gabriel Ricard <g_ricard@yahoo.com>, linuxppc-dev@lists.linuxppc.org
Subject: Re: Lombard hard freeze (still there)
In-Reply-To: <39116DF7.4CD7FFBD@mondonet.net>
Message-ID: <Pine.LNX.4.10.10005041802480.30927-100000@opal.biophys.uni-duesseldorf.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


> > include a wandering mouse pointer: i.e. when I am
> > typing rapidly, X will occasionally think I've clicked
> > the mouse button and the focus goes to where the
> > pointer was located.
>
> Same for me. And it is really annoying to write the
> emails two or three times ;-)
> My mouse is a brand x 5$ usb mouse with three buttons...

That's Xpmac or FBDev? I'm using FBDev on 2.2.15pre9 and have no such
problems. And I can't imagine mouse data ending up as keyboard data except
for Xpmac (where mouse data are fed to the X tty prefixed by a special
escape char. Make X choke and drop the escape char, and you probably get
what you described. Or get a garbled keyboard char, similar effect).

	Michael


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
