Message-ID: <7283DE19D141D111AD0E00A0C95B195502C5F605@mail2.aiinet.com>
From: "Whitney, John" <johnw@aiinet.com>
To: "'greyham@research.canon.com.au'" <greyham@research.canon.com.au>,
        kd@flaga.is
Cc: linuxppc-embedded@lists.linuxppc.org
Subject: RE: ext2fs or ramdisk problems......
Date: Fri, 25 Aug 2000 09:30:23 -0400
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


I have had odd results using ext2 on the ramdisk (in my case, a 16MB
ramdisk).  Using the 2.2.13, ramdisks I created using ext2 would boot
up just fine on the system, but after use the filesystem would declare
that it was out of space, even though "df" showed several megabytes
free on that filesystem.

I never did find out where the oddity was.  I moved forward to 2.2.15
in an effort to correct the problem, but that didn't help either.
Eventually, I moved on to using the Minix filesystem (which from what
I understand, uses diskspace better for what I need anyway) and have
not had similar problems.  The one downside is that Minix is not
byte-ordering independant, so currently I build the ramdisk image on
a iMac running YellowDog Linux.  Someday I'll go into the Minix source
code on my PC and modify it to be big-endian, so I don't have to worry
about it anymore.

Has anyone else seen problems like this using ext2?

John Whitney
johnw@aiinet.com

-----Original Message-----
From: greyham@research.canon.com.au
[mailto:greyham@research.canon.com.au]
Sent: Thursday, August 24, 2000 8:19 PM
To: kd@flaga.is
Cc: linuxppc-embedded@lists.linuxppc.org
Subject: Re: ext2fs or ramdisk problems......



kd@flaga.is writes:
> Or is this still the ramdisk driver teesing me?

If you haven't solved your problem with the ramdisk crashing, I very much
doubt that it will cope with having a filesystem mounted on it.  As it's a
custom board, how do you know your UPM tables are correct?  Have you tried
running the same kernel on a known-good board from Embedded Planet,
Bright Star or TQM?

Regards,
Graham


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
