Date: Fri, 24 Nov 2000 15:23:56 +0100 (MET)
From: Gabriel Paubert <paubert@iram.es>
To: Michael Schmitz <schmitz@opal.biophys.uni-duesseldorf.de>
cc: Avery Pennarun <apenwarr@worldvisions.ca>,
        Michael Schmitz <schmitz@zirkon.biophys.uni-duesseldorf.de>,
        daenzerm@student.ethz.ch, Hadess <hadess@writeme.com>,
        debian-powerpc@lists.debian.org, linuxppc-dev@lists.linuxppc.org
Subject: Re: apmd and other archs
In-Reply-To: <Pine.LNX.4.10.10011231923001.18630-100000@opal.biophys.uni-duesseldorf.de>
Message-ID: <Pine.HPX.4.10.10011241514240.14737-100000@gra-ux1.iram.es>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Thu, 23 Nov 2000, Michael Schmitz wrote:

> The init scripts of all distributions but SuSE handle this just fine
> (mount -n). At least SuSE seems to mount the root fs rw from the start,
> which causes all sorts of pain if you want to boot into a RedHat system
> using the SuSE rescue disk. No idea how SuSE copes with readonly root fs.

Yes, but read my previous posts. I consider the -n and -f mount options to
be a kludge. There is a chicken and egg problem and the workaround is a
kludge. The list of mounted file systems should be maintained by the
kernel IMHO, since the kernel has to know them in any case.

Mouting root read/write too early is even worse. That's no problem
since Suse waits for root fs to be checked before remounting rw. But Suse
has otehr problems when you want to maximize sharing on diskless systems
(init scripts in /sbin for one).

> > non-clean shutdown which you would have to erase before the first mount is
> > done (adding another funky option to mount). Unless you make some kind of
> > ramdisk compulsory, which might not be bad idea after all with current
> > memory sizes.
>
> Yeah, like Linux will never run on my old 4 MB Mac anyway.

BTW: what is the minimum RAM to run Liunx/PPC these days ? My smallest
(quasi embedded) machines have 16Mb and I hope to keep these running for
at least 5 to 7 more years.


	Gabriel.


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
