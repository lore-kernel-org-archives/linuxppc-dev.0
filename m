Date: Wed, 13 Jan 1999 22:23:50 -0600 (CST)
From: "David A. Gatwood" <marsmail@globegate.utm.edu>
To: a sun <asun@saul7.u.washington.edu>
cc: linuxppc-dev@lists.linuxppc.org, bh40@calva.net
Subject: Re: Porting to NuBus PowerMacs
In-Reply-To: <199901140409.UAA08871@saul7.u.washington.edu>
Message-ID: <Pine.LNX.3.96.990113221817.12702B-100000@globegate.utm.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Wed, 13 Jan 1999, a sun wrote:

> oh my. i hadn't noticed that. thanks for pointing it out to me. i
> guess a plain eieio() is sometimes not good enough... no doubt, the
> designers of certain unmentionable devices were being directed by some
> cosmic purpose that we, the uninitiated, can only vaguely envision and
> hope to understand.

Actually, I think that the sync was the problem, but eieio might be, too.
I note similar assmbly junk for both, so... who knows....

> luckily, my trusty g3 upgrade card handily curtails my pursuit into
> the ineffable nature of such visionaries. i guess i'll have to add a
> CONFIG_601 to deal with certain "third-party" devices though. that
> way, we can have just as much fun as the other architectures with
> processor-specific tweaks.

Yeah.  I'm planning on releasing certain development kernels (possibly not
mainstream) that use plain old sync and eieio and see what speed
difference it makes.  We might find out that MkLinux's drivers aren't so
bad after all....  You never know.  Anyway, I don't think that register
has always been supported, but somebody with more memory of the MkLinux
coding history could say more (maybe).


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
