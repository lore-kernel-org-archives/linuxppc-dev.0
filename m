Date: Fri, 24 Nov 2000 16:23:39 +0100 (CET)
From: Michael Schmitz <schmitz@zirkon.biophys.uni-duesseldorf.de>
To: Olaf Hering <olh@suse.de>
cc: Michael Schmitz <schmitz@opal.biophys.uni-duesseldorf.de>,
        debian-powerpc@lists.debian.org, linuxppc-dev@lists.linuxppc.org
Subject: Re: apmd and other archs
In-Reply-To: <20001124154725.A24888@suse.de>
Message-ID: <Pine.LNX.4.10.10011241618210.30022-100000@zirkon.biophys.uni-duesseldorf.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


> > using the SuSE rescue disk. No idea how SuSE copes with readonly root fs.
>
> It doesnt work per default, some guys did some hacks to the boot scripts
> to have a readonly root fs.
> Well, but most users want to story something on their hard drives so it

Everybody seems to use hard disks for storage these days, but some sort of
agreement to have the kernel initially mount root readonly evolved
nonetheless (at least four years ago the kernel default mount option was
changed). It's just about convenience and checking the root fs every time
on boot.

> doesnt work per default. Have a look at support.suse.de, there is (proably)
> some info about readonly root.

I'll take a look there.

	Michael


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
