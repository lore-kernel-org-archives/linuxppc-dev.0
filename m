Message-ID: <20000328160043.23755.qmail@web110.yahoomail.com>
Date: Tue, 28 Mar 2000 08:00:43 -0800 (PST)
From: Michel "D?nzer" <mdaenzer@yahoo.com>
Reply-To: michdaen@iiic.ethz.ch
Subject: Re: XFree86 4.0 working as fbdev on Voodoo3
To: "William H. Schultz" <whschult@uncc.edu>
Cc: linuxppc-dev@lists.linuxppc.org
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


--- "William H. Schultz" <whschult@uncc.edu> wrote:
>
> I don't know if it's because I moved my existing /usr/X11R6
> directory before installing, but XFree86 v4 finally works on
> my Voodoo3.  Granted, it is incredibly slow (slower than
> v3.3.6), but at least it works--for now.

Doesn't the tdfx driver work?


> The major problem that I'm having is that the keyboard isn't
> mapped properly.  The mouse works, so I can logout when I
> use startx, but I can't log in if I use gdm (or xdm for that
> matter).  I can't do a ctrl-alt-del to kill the X-Server
> either, as it isn't recognizing the keys properly.

The Xkb extension doesn't work on PPC yet (a fix by Kostas is on the way :).

Add Option "XkbDisable" to the Keyboard Section.


Michel


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
