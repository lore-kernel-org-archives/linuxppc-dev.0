Date: Thu, 14 Jan 1999 20:18:16 -0600 (CST)
From: "David A. Gatwood" <marsmail@globegate.utm.edu>
To: Brad Midgley <brad@pht.com>
cc: linuxppc-dev@lists.linuxppc.org
Subject: Re: floppy driver bug: write-protect
In-Reply-To: <Pine.LNX.3.95.981115182106.10912A-100000@pacific.pht.com>
Message-ID: <Pine.LNX.3.96.990114201533.20267D-100000@globegate.utm.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Sun, 15 Nov 1998, Brad Midgley wrote:

> is this a known bug?
> 
> on intel linux, if you try to mount a write-protected floppy disk
> read-write, the mount succeeds but is demoted to read-only. 
> 
> the current pmac kernel will mount the disk read-write and will allow
> "writes" to the disk. the writes even appear to succeed and the mounted
> filesystem returns really strange results when you look at it (it's
> caching the "writes" and everything seems normal until uncached data has
> to be loaded from the disk!)
> 
> is it known how to query the drive for the write-protect status? does this
> problem affect any other removable media?

Wow, so you guys have that problem, too, eh?  MkLinux's floppy driver does
the same thing.  It's given me fits trying to find something in LinuxPPC
to demote it to read-only.  Guess that's why I didn't find anything!!!
:-)

If anybody figures out how to fix this (no doubt the same fix, roughly,
for both), please let me know.  I've gotten as far as forcing the device
read-only, but that flag is ignored by at least umsdos filesystem support,
not sure what else....  :-(


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
