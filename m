Date: Tue, 12 Jan 1999 18:12:46 -0600 (CST)
From: "David A. Gatwood" <marsmail@globegate.utm.edu>
To: Benjamin Herrenschmidt <bh40@calva.net>
cc: linuxppc-dev@lists.linuxppc.org,
        Hubert Figuiere <Hubert.Figuiere@solsoft.fr>
Subject: Re: Porting to NuBus PowerMacs
In-Reply-To: <19990112202948.028828@mail.mipsys.com>
Message-ID: <Pine.LNX.3.96.990112175935.4930B-100000@globegate.utm.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Tue, 12 Jan 1999, Benjamin Herrenschmidt wrote:

> That was the original idea, but several things makes me wonder if it
> wouldn't be simpler to just pass a list of known infos (total ram size,
> processor type, machine ID and a couple of baseaddresses) to the kernel
> and almost-hard-code things in drivers since this hardware will not
> evolve very much now ;-)

RAM chips on that machine are... according to a reliable source... aligned
on 64 meg boundaries, and are thought to be mirrored throughout that bank
if they're <64 megs.  Question is... what happens if a bank isn't filled. 
This is left as an exercise for the reader.  But determining the memory
layout is critical to getting it working.  I'm hoping that I can get that
bit of code from the MkLinux booter, but I'm not making any promises.


> Basically, I have to provide him a version of BootX that works on those
> machines and provide the requested infos. I didn't have time to work a
> lot on BootX those few last days, but I think I'll send him something
> around the end of the week, maybe next week.

Also, please pass the machine gestalt (for model detection), video
address, processor speed, and a flattened OF tree, if you could (and if
you aren't already).  That would ease porting the Mach MK to BootX-style
booting (which is basically the only way MkLinux will ever run on iMacs
and the new G3 MiniTower machines, unless we add OF booting, which I don't
want to muck with right now).


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
