Date: Fri, 15 Jan 1999 12:34:56 -0600 (CST)
From: "David A. Gatwood" <marsmail@globegate.utm.edu>
To: Paul.Mackerras@cs.anu.edu.au
cc: brad@pht.com, linuxppc-dev@lists.linuxppc.org
Subject: Re: floppy driver bug: write-protect
In-Reply-To: <199901150331.OAA01845@tango.anu.edu.au>
Message-ID: <Pine.LNX.3.96.990115122915.25116B-100000@globegate.utm.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Fri, 15 Jan 1999, Paul Mackerras wrote:

> OK, I need to check the write-protect status in the floppy_write
> routine in swim3.c.
> 
> I have recently looked at the floppy driver source code in MkLinux,
> which looks like it is derived from macos sources.  It looks like
> there are a few tweaks which I need to do to the Linux/PPC driver.

MkLinux's driver is based on a Copland driver with a Mach Driver
interwoven and some shim code.  Needs massive cleanup, but basically works
as long as you don't have more than one floppy drive.  Also a little
trouble with writing large chunks of data (not sure why).

Thanks for the info on how the write protect is supposed to work.  I put
some checks for write protect on write, but making the mount fail is a
much more logical solution.


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
