Date: Fri, 24 Nov 2000 15:47:25 +0100
From: Olaf Hering <olh@suse.de>
To: Michael Schmitz <schmitz@opal.biophys.uni-duesseldorf.de>
Cc: debian-powerpc@lists.debian.org, linuxppc-dev@lists.linuxppc.org
Subject: Re: apmd and other archs
Message-ID: <20001124154725.A24888@suse.de>
References: <Pine.HPX.4.10.10011231514150.21126-100000@gra-ux1.iram.es> <Pine.LNX.4.10.10011231923001.18630-100000@opal.biophys.uni-duesseldorf.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <Pine.LNX.4.10.10011231923001.18630-100000@opal.biophys.uni-duesseldorf.de>; from schmitz@mail.biophys.uni-duesseldorf.de on Thu, Nov 23, 2000 at 07:40:04PM +0100
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Thu, Nov 23, Michael Schmitz wrote:

> The init scripts of all distributions but SuSE handle this just fine
> (mount -n). At least SuSE seems to mount the root fs rw from the start,
> which causes all sorts of pain if you want to boot into a RedHat system
> using the SuSE rescue disk. No idea how SuSE copes with readonly root fs.

It doesnt work per default, some guys did some hacks to the boot scripts
to have a readonly root fs.
Well, but most users want to story something on their hard drives so it
doesnt work per default. Have a look at support.suse.de, there is (proably)
some info about readonly root.


Gruss Olaf

--
 $ man clone

BUGS
       Main feature not yet implemented...

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
