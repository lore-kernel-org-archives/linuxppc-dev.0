Date: Mon, 24 Sep 2001 00:22:22 -0400 (EDT)
From: patrick <tendim@tendim.cjb.net>
To: Ethan Benson <erbenson@alaska.net>
Cc: linuxppc-dev@lists.linuxppc.org
Subject: Re: More problems with Kernel 2.4.10-pre12 and mounting
In-Reply-To: <20010923191713.E14835@plato.local.lan>
Message-ID: <Pine.LNX.4.21.0109232320480.13300-100000@cr242184-a.etob1.on.wave.home.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Sun, 23 Sep 2001, Ethan Benson wrote:

> the dd trick shows you can read the device without problems, are you
> sure the filesystem is not corrupt? or that the disk is not failing?

But the problem isn't limited to /dev/sdb, since /dev/sda also has
problems.  (I can't do any of the tricks, i.e., dd or pdisk -l /dev/sda
with it either.  Again, this is all under 2.4.10-pre12, 2.2.18 works
fine.)

> badblocks -sv /dev/sdb

Nothing bad happened, and no error messages came out (I checked
the entire /dev/sdb drive), so I'm assuming my drive is ok.

--
patrick m pritchard
disposable hero.


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
