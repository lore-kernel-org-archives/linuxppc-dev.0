Date: Thu, 16 Sep 1999 10:01:30 -0700 (PDT)
From: "David A. Gatwood" <dgatwood@mvista.com>
To: Geert Uytterhoeven <geert@sonycom.com>
cc: Linux/PPC Development <linuxppc-dev@lists.linuxppc.org>
Subject: Re: New booter 
In-Reply-To: <Pine.GSO.4.10.9909160957530.21133-100000@ivy.sonytel.be>
Message-ID: <Pine.LNX.3.96.990916100017.2585D-100000@mvista.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Thu, 16 Sep 1999, Geert Uytterhoeven wrote:

> IMHO the best thing would be something like MILO on the Alpha. MILO is a
> small binary that contains device drivers and filesystems taken from the
> standard Linux kernel sources. Hence MILO knows about e.g. your ext2fs
> partition and fancy U2W-SCSI adapter. On Alpha the MILO binary is put on a
> MSDOS formatted partition. On PPC, you could store it on either a HFS or MSDOS
> formatted partition, or use a LILO-alike scheme (raw-blocks). Even BootX could
> load MILO under MacOS, if you want that.

Kind of like syslinux or loadlin... somewhere in between.


> Combined, you would have a shared `high-level' booter, which is called
> by different `low-level' booters (FS (HFS/MSDOS), raw-blocks, BootX),
> depending on your taste and architecture: 

That's kind of cool.


David


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
