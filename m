Date: Thu, 27 Jul 2000 21:48:05 +0200 (CEST)
From: Michael Schmitz <schmitz@opal.biophys.uni-duesseldorf.de>
To: Joseph Garcia <jpgarcia@execpc.com>
cc: Benjamin Herrenschmidt <bh40@calva.net>, linuxppc-dev@lists.linuxppc.org
Subject: Re: powerbook hang from post-sleep cdrom access - fix
In-Reply-To: <39805F0A.5CE376C6@execpc.com>
Message-ID: <Pine.LNX.4.10.10007272146140.2350-100000@opal.biophys.uni-duesseldorf.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


> > Aye. Can you be more specific about 'do whatever needs to be done'? Can I
> > just send the disk a read command to wake it up? Send a reset
> > command?? Will a reset command hurt if I always send a drive reset
> > there?
>
> My expirience is that just reading the drive causes a problem, much like
> userspace trying to read it.  there is also the door locking feature that I
> suppose could be done explicitly on wakeup if mounted.  I dont know what else a
> "media change" ctl entails, but it seems to do enough to get the cdrom back to
> where it left off.

OK, that seems to mean wherever we can safely send the drive a reset
command after sleep, we should do that. Now under what conditions will a
reset command mess up things beyond recovery? Is it possible to sleep the
machine while the IDE drive has a request under service?

	Michael


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
