Mime-Version: 1.0
Message-Id: <v04210105b4061a65c789@[192.168.0.1]>
In-Reply-To: <Pine.LNX.4.10.9909151639120.31363-100000@opus.bloom.county>
References: <Pine.LNX.4.10.9909151639120.31363-100000@opus.bloom.county>
Date: Wed, 15 Sep 1999 19:59:58 -0800
To: Tom Rini <trini@kernel.crashing.org>
From: Ethan Benson <erbenson@alaska.net>
Subject: Re: New booter
Cc: Peter Bierman <bierman@apple.com>, linuxppc-dev@lists.linuxppc.org
Content-Type: text/plain; charset="us-ascii" ; format="flowed"
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On 15/9/99 Tom Rini wrote:

>
>That's not a problem, that's helpful.  As Kevyn pointed out (maybe just on
>IRC) is if you nuke the NVRAM on a SPARC, yer dead.  If you do that on a
>Mac, you're fine.  Lots of other archs have the same problem.  re-write
>your bootblock, you're dead on x86.  Macs have the "Can't shoot my foot
>off" feature.   This isn't bad.

if you overwrite the bootblock on macos your disk will NOT boot, I 
know I have done it many time.

>
>But a good loader knows how to deal w/ FSes.  The FreeBSD loader is
>wonderful, and can boot any kernel on the disk, unlike lilo.

thats fine the problem is relying on using a specific filesystem, 
that is why we are stuck on linux OF does not know about ext2, this 
is why support for arbitrary bootblock loading is needed so if your 
filesystem is unknown to the firmware you are not stuck, you are also 
not stuck using the same fs format forever.

>
>Why do you need a filesystem independant boot process?  That limits us to
>something tiny, rather useless and ugly.

fine have both, we need a fs independant boot process so linux will 
work on this hardware, as it is we are stuck with kludges. (or maybe 
not and we just don't and its just quik thats broken)

the problem with relying on filesystem support in the hardware is its 
difficult to change and for linux developers its effectively 
IMPOSSIBLE to change, you want it thier fine, but do not RELY on that 
EXCLUSIVELY.



Best Regards,
Ethan Benson
To obtain my PGP key: http://www.alaska.net/~erbenson/pgp/

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
