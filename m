Date: Sun, 23 Sep 2001 13:33:54 -0400 (EDT)
From: patrick <tendim@tendim.cjb.net>
To: Ethan Benson <erbenson@alaska.net>
Cc: linuxppc-dev@lists.linuxppc.org
Subject: Re: More problems with Kernel 2.4.10-pre12 and mounting
In-Reply-To: <20010922234424.X14835@plato.local.lan>
Message-ID: <Pine.LNX.4.21.0109231331340.11517-100000@cr242184-a.etob1.on.wave.home.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Sat, 22 Sep 2001, Ethan Benson wrote:

> what happens if you run the following:
>
> dd if=/dev/sdb of=/dev/null bs=512 count=1
>
> i am betting you will get a `No such device' error which means the
> kernel thinks there is no second scsi device.

Nope, I get:

1+0 records in
1+0 records out

Related, my partition map for /dev/sdb is:

Partition   Dec
0           Apple driver
1           ??
2           ??
3           HFS
4           e2fs

I can mount /dev/sdb4.

This all points to a problem with Apple Partition Support..?

--
patrick m pritchard
disposable hero.


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
