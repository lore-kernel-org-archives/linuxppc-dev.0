Date: Thu, 23 Nov 2000 19:40:04 +0100 (CET)
From: Michael Schmitz <schmitz@opal.biophys.uni-duesseldorf.de>
To: Gabriel Paubert <paubert@iram.es>
cc: Avery Pennarun <apenwarr@worldvisions.ca>,
        Michael Schmitz <schmitz@zirkon.biophys.uni-duesseldorf.de>,
        daenzerm@student.ethz.ch, Hadess <hadess@writeme.com>,
        debian-powerpc@lists.debian.org, linuxppc-dev@lists.linuxppc.org
Subject: Re: apmd and other archs
In-Reply-To: <Pine.HPX.4.10.10011231514150.21126-100000@gra-ux1.iram.es>
Message-ID: <Pine.LNX.4.10.10011231923001.18630-100000@opal.biophys.uni-duesseldorf.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


> > Good answer. I'd have used a symlink to some writeable directory on the
> > root fs, mainly because using /proc all over the place tends to confuse
> > Unix admins with no Linux experience. Let's not fall into the Solaris trap
> > (you are in a maze of twisty little config files, all different from the
> > rest of Unix').
>
> At boot, before the first mount command executes, there may be _no_
> writable directory and there may be none for a while, and you have the
> problem of having an existing non-empty /etc/mtab (or equivalent) from a

The init scripts of all distributions but SuSE handle this just fine
(mount -n). At least SuSE seems to mount the root fs rw from the start,
which causes all sorts of pain if you want to boot into a RedHat system
using the SuSE rescue disk. No idea how SuSE copes with readonly root fs.

Anyway, this wasn't the issue initially. It seems /proc/apm should be
doable on PPC for programs that don't use apmlib, and the apmlib glue code
takes care of the others.

> non-clean shutdown which you would have to erase before the first mount is
> done (adding another funky option to mount). Unless you make some kind of
> ramdisk compulsory, which might not be bad idea after all with current
> memory sizes.

Yeah, like Linux will never run on my old 4 MB Mac anyway.

	Michael


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
