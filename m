Date: Mon, 24 Sep 2001 17:39:59 -0400 (EDT)
From: patrick <tendim@vex.net>
To: Ethan Benson <erbenson@alaska.net>
Cc: <linuxppc-dev@lists.linuxppc.org>
Subject: Re: More problems with Kernel 2.4.10-pre12 and mounting
In-Reply-To: <20010923221839.G14835@plato.local.lan>
Message-ID: <Pine.NEB.4.33.0109241732420.19824-100000@vex.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Sun, 23 Sep 2001, Ethan Benson wrote:

> well sounds to me like your scsi driver is hosed then.

Well if the SCSI driver is hosed, then shouldn't I *not* be able to do
anything else then?  My setup is as follows:

SCSI0 - Adaptec 2940 UW Card   /dev/sda
SCSI1 - Mesh Internal SCSI     /dev/sdb

And all of the drivers have been compiled into the kernel (no modules).

> well if badblocks has no problem reading the entire device why should
> anything else.  this clearly has nothing to do with partition table
> support.

Then that leaves it to the program I'm using to read the partition map.
I've seen you reference "mac-fdisk".  Is this the same as pdisk?  Or
is an entirely different beast?

Perhaps it is pdisk that doesn't like the new kernel.

patrick@tendim.cjb.net
http://www.tendim.cjb.net/
Like anime?   Got hotline?
hotline://twoaday.cjb.net/


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
