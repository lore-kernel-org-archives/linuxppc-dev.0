Date: Wed, 13 Jan 1999 13:27:28 -0600 (CST)
From: "David A. Gatwood" <marsmail@globegate.utm.edu>
To: a sun <asun@saul9.u.washington.edu>
cc: linuxppc-dev@lists.linuxppc.org, bh40@calva.net
Subject: Re: Porting to NuBus PowerMacs
In-Reply-To: <199901131910.LAA28570@saul9.u.washington.edu>
Message-ID: <Pine.LNX.3.96.990113132556.9506A-100000@globegate.utm.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Tue, 12 Jan 1999, a sun wrote:

> heh. am i correct in assuming then that just using memory barriers
> just won't cut it for a certain device that seems to have a bunch of
> delay()'s sprinkled throughout it? strangely, this same piece of
> hardware seems to be necessary to get the newer tech g3 extension and
> the mklinux booter happy... any insights there?

Actually, on looking at it, there is the use of memory barriers.  The real
change is in the code for the memory barriers (and possibly in other
places, too... not certain).  See 

.../osfmk/src/mach_kernel/ppc/proc_reg.h:440

in the MkLinux sources.  :-)


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
