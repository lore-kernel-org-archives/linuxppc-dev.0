MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Subject: RE: cramfs for root filesystem?
Date: Tue, 25 Jun 2002 08:46:54 -0500
Message-ID: <45B36A38D959B44CB032DA427A6E10640167CFE8@cceexc18.americas.cpqcorp.net>
From: "Cameron, Steve" <Steve.Cameron@hp.com>
To: "Steven Hein" <ssh@sgi.com>, "David Blythe" <blythe@broadon.com>
Cc: "linuxppc-embedded" <linuxppc-embedded@lists.linuxppc.org>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Steven Hein [mailto:ssh@sgi.com] wrote:

> [...] You do need a kernel patch to add cramfs to the list of
> filesystems to check for in the initrd, also my patch forces the
> blocksize of the initrd to 4K if it finds that it contains cramfs. [...]

Hmm, this patch doesn't seem to apply to my fairly recent
linuxppc_2_4_devel tree.  identify_ramdisk_image() for instance
is in init/do_mounts.c, not drivers/block/rd.c, and there is a
#define BUILD_CRAMDISK in there I guess relating to cramfs, though
I'm not sure what it's doing.

> I have also previously posted a patch to mkcramfs to swap
> endianness on a cramfs filesystem   [...]
>     http://lists.linuxppc.org/linuxppc-embedded/200206/msg00128.html

Hmm, this patch doesn't seem to apply to the mkcramfs I got from
sourceforge yesterday.

Thanks, just the same.

-- steve


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
