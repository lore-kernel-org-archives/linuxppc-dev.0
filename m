Date: Mon, 13 Sep 1999 03:23:13 +0100 (BST)
From: Jules Bean <jmlb2@hermes.cam.ac.uk>
To: Alex Fishman <fosh@fosh.com>
cc: linuxppc-dev@lists.linuxppc.org
Subject: Re: Kensington 'orbit' trackball - think's it's a turbomouse 5?
In-Reply-To: <Pine.LNX.3.96.990911115053.7386A-100000@localhost.localdomain>
Message-ID: <Pine.SOL.4.10a.9909130317290.17504-100000@orange.csi.cam.ac.uk>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Sat, 11 Sep 1999, Alex Fishman wrote:

> 
> Infact, the mouse really is a turbo mouse 5 in disguise, this is not the
> problem, the problem is that the two buttons on the mouse are mapped to
> one and two, you want them mapped to one and three (i.e.  The button on
> the left is like the first button on a three button, the button on the
> right is like the third button, and chording is like the second button).
> TO accomplish this, type:
> 
> xmodmap -e "pointer = 1 3 2"

I have tried this, as I did in fact mention (briefly) - sorry if it wasn't
clear.

It does correctly make the right button button 3, but it *doesn't* make
chording work.  This made me guess that the chording code is at a lower
level, in the XF86 mouse drivers, and therefore it isn't affected by
xmodmap.

> > 
> > When I'm in X, the mouse operates fine as a two-button mouse, except that
> > it is sending buttons 1 and 2, rather than the more useful 1 and 3.
> > 
> > I can superficially fix this last using xmodmap pointer, although (AFAIK)
> > there's no way of doing an 'emulate3buttons' trick at this stage.

<<snip>>

Jules


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
