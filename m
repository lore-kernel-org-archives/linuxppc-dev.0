Date: Mon, 25 Jan 1999 09:47:34 -0600 (CST)
From: "David A. Gatwood" <marsmail@globegate.utm.edu>
To: Ken Roberts <ken.r@worldnet.att.net>
cc: Tom Harrington <tph@rmi.net>,
        Robin Colgrove <robin@louis.bidmc.harvard.edu>,
        linuxppc-dev@lists.linuxppc.org
Subject: Re: Linux and Mac together (Was: Re: mac-on-linux project status)
In-Reply-To: <Pine.LNX.3.96.990124230812.434A-100000@dancer.at.home>
Message-ID: <Pine.LNX.3.96.990125094415.17040D-100000@globegate.utm.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Sun, 24 Jan 1999, Ken Roberts wrote:

> >> Maybe I am just not understanding this but if both MkLinux and OS X run on 
> >> top of the Mach microkernel, could they both be running simultaneously? If 
> >
> >In principle, yes,  Mach is capable of running multiple server operating 
> >systems at the same time.  I have no idea what's involved in making this
> >happen, but supposedly one of the advantges of a microkernel-based Linux
> 
> this was explained to the mklinux list quite some time back.  i believe
> this will not work because mklinux and osx use different versions of the
> mach kernel. 
> 
> from what i remember, mklinux uses a more recent kernel than the
> official apple stuff.  the interfaces are different enough so that the
> two worlds are incompatible. 

MkLinux uses a more modern Mach than OS X server, yes.  It uses a very
similar kernel to what OS X final is expected to use, though.  I like to
think there are always possibilities.  I won't be certain whether there's
any porting potential or not until OS X is released, though.


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
