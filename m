Date: Sat, 4 Nov 2000 10:59:23 -0500
From: Simon Piette <spiette@generation.net>
To: linuxppc-dev@lists.linuxppc.org
Subject: Re: Please bang on GNU Parted ;-)
Message-ID: <20001104105922.B23753@xim.dyndns.org>
Reply-To: spiette@generation.net
References: <3A025FFD.EC6CB84A@gnu.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <3A025FFD.EC6CB84A@gnu.org>; from clausen@gnu.org on Fri, Nov 03, 2000 at 05:49:33PM +1100
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Hi,

The backend seems to be rock-solid. I've tried to resize a mounted
partitions and parted refuse. I've also tried to resize a partition
filled with 96M to 64M and parted refuse. Is there a test suite for
parted so it could be more systematic?

I am some concerns about the interface, though. At this stage, parted is
like a very sharp knife, without handle. It slices, it dices, but watch
your fingers! :-)

- parted execute right away each command. IMHO, a "commit" command would
  be much more safe. At least for 1.4.0 final, parted should print a
  warning, such as "CAUTION: Commands are executed right away!".

- It should have a read-only switch, so the user could be sure to not
  mess its partition table.

- It would be nice to have the "print" command to display sizes of each
  partitions.

- parted needed to be started with a device. Why not start parted in
  interactive mode anymway, so then the user will ba able to select a
  device?

I really liked the "mkpartfs" and "cp" command, and I expect parted to be
the disk partitioning tool of choice among the PPC Linux community. Good
work!

Simon Piette

* Andrew Clausen (clausen@gnu.org) [001103 17:00]:
>
> Hi all,
>
> I think GNU Parted is pretty stable now, but I'd be more than
> happy to be proven wrong ;-)
>
> 	ftp.gnu.org/gnu/parted/devel/parted-1.4.0-pre8.tar.gz
>
> (GNU Parted is allows you to manipulate partition tables, and resize
> ext2 partitions, and other things...)
>
> Thanks,
> Andrew Clausen
>
>
>

--
PGP key ID: 1024D/99290743 	Simon Piette <spiette@generation.net>
PGP Key fingerprint: 9AF9 33F9 A900 E153 9DF3  0625 8928 CB52 9929 0743

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
