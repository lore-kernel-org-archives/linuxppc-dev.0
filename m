Mime-Version: 1.0
Message-Id: <v04210102b405ce2cdefb@[192.168.0.1]>
In-Reply-To: <v04210103b4058cbb5883@[17.203.21.242]>
References: <19990915113905.031280@mailhost.mipsys.com>
 <v04210108b4051bfbea54@[192.168.0.1]>
 <v04210103b4058cbb5883@[17.203.21.242]>
Date: Wed, 15 Sep 1999 14:37:35 -0800
To: Kevyn Shortell <kevyn@apple.com>
From: Ethan Benson <erbenson@alaska.net>
Subject: Re: New booter
Cc: Benjamin Herrenschmidt <bh40@calva.net>, linuxppc-dev@lists.linuxppc.org
Content-Type: text/plain; charset="us-ascii" ; format="flowed"
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On 15/9/99 Kevyn Shortell wrote:

>You need to use HFS to boot, no other method is guaranteed to work.
>You can call it a kludge if you want to, but while you up there on
>the soapbox, you might want to rethink your statement and consider how
>Linux boots on X86.

it boots very cleanly on x86, booting linux instead of windows is 
complete non issue there.

BIOS loads the bootblock from boot disk or if one does not exist it 
looks for a partition marked bootable in the partition table and 
loads the bootblock from that.  the BIOS knows NOTHING about ANY 
filesystem not ext2 not FAT, NTFS, DOSfs, not HFS.  lilo works 
wonderfully, and does not require its very own partition in a 
specific filesystem format to work. *I* think this is a very clean 
way to boot it allows the replacement of the filesystem without 
anything more then a update to lilo at most.  not a whole new machine 
or a kludge like creating dedicated partitions just to bootstrap your 
OS.

>Linux as a OS, has more kludge factor than anything else on the planet
>and it works, people use it, life goes on.

I disagree

>No other boot method besides HFS is going to be tested by Apple in
>the Firmware, it's not a requirement for shipping machines at this
>time. That may change in the future, but for right now, HFS is it.

and as I have said this is very shortsighted, what happens down the 
road when people want a journaled filesystem?  when HFS+ is obsolete 
and you want to replace it? oh darn all your machines won't boot now 
unless you keep an old crufty HFS partition laying around wasting 
space to boot.

the bootstrap process should have NO reliance on a specific filesystem!



Best Regards,
Ethan Benson
To obtain my PGP key: http://www.alaska.net/~erbenson/pgp/

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
