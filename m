Date: Thu, 26 Apr 2001 15:00:44 -0400 (EDT)
From: Hollis R Blanchard <hollis+@andrew.cmu.edu>
To: Michel Lanners <mlan@cpu.lu>
Cc: rcook@ntlug.org, linuxppc-dev@lists.linuxppc.org
Subject: Re: 9.1 Gbyte SCSI Drive
In-Reply-To: <200104260559.HAA00741@piglet.grunz.lu>
Message-ID: <Pine.LNX.4.21L.0104261458530.1089-100000@naproxen.weh.andrew.cmu.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Thu, 26 Apr 2001, Michel Lanners wrote:
>
> Anyway, the point was make sure you erase the PC partition map
> _completely_, with something like this:
>
> dd if=/dev/null of=/dev/sd<drive> bs=512 count=10
>
> This should scratch the first few blocks on disk, some of which are not
> touched by Mac-style partition maps, and make it possible to do a
> _clean_ Mac partition map.

As long as you don't try to make it with pdisk, which claims all disks
without an existing valid Apple partition map are 512.0 GB.

parted (or Drive Setup) should work fine.

-Hollis


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
