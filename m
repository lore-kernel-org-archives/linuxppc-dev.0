Date: Mon, 7 Dec 1998 11:46:40 -0600 (CST)
From: "David A. Gatwood" <marsmail@globegate.utm.edu>
To: Geert Uytterhoeven <Geert.Uytterhoeven@cs.kuleuven.ac.be>
cc: Elgin Lee <ehl@funghi.com>, linuxppc-dev@lists.linuxppc.org
Subject: Re: XF68_FBDev under MkLinux? 
In-Reply-To: <Pine.LNX.4.03.9812070957590.31794-100000@mercator.cs.kuleuven.ac.be>
Message-ID: <Pine.LNX.3.96.981207114602.20658A-100000@globegate.utm.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Mon, 7 Dec 1998, Geert Uytterhoeven wrote:

> On Sun, 6 Dec 1998, David A. Gatwood wrote:
> > On Sat, 5 Dec 1998, Elgin Lee wrote:
> > > >   2. Adopt XF68_FBdev so it can use the MkLinux video mode ioctl stuff.
> > 
> > vmode ioctl stuff?  Since when does MkLinux support detecting or changing
> > video modes?  This is where we're going to run into trouble either way.
> 
> Doesn't the stuff in <asm/vc_ioctl.h> come from MkLinux?

Maybe.  I'm not saying the linux server part doesn't have the support,
just that the mach kernel drivers don't, AFAIK.  :-)


Later,
David

David A. Gatwood                         Visit globegate's internet
dgatwood@globegate.utm.edu                  talker, Deep Space 36
http://globegate.utm.edu                telnet globegate.utm.edu:9624

-----BEGIN GEEK CODE BLOCK-----
Version 3.1
GCS/CC/FA/H/L/MC/M/MU/PA/TW d-@ s:>- a-- C++ ++>$ UBLAS*++ ++>$
P+?>$ L++ +>$ !E--- W++ +>$ N++(++ +)>++ +$ !o? K-? !w--- !O
M++>$ !V-- PS+>$ !PE- Y+>$ PGP+>$ t++ +>$ 5+>++ ++$ !X- !R tv+>$
b++>$ !DI !D- G++(++ +)>$ e>++ ++ h--! r--- !y-
------END GEEK CODE BLOCK------


[[ This message was sent via the linuxppc-dev mailing list. Replies are ]]
[[ not forced back to the list, so be sure to  Cc linuxppc-dev  if your ]]
[[ reply is of general interest. To unsubscribe from linuxppc-dev, send ]]
[[ the message 'unsubscribe' to linuxppc-dev-request@lists.linuxppc.org ]]
