Message-ID: <3D187969.F9273A5F@sgi.com>
Date: Tue, 25 Jun 2002 09:08:41 -0500
From: Steven Hein <ssh@sgi.com>
MIME-Version: 1.0
To: "Cameron, Steve" <Steve.Cameron@hp.com>
Cc: David Blythe <blythe@broadon.com>,
	linuxppc-embedded <linuxppc-embedded@lists.linuxppc.org>
Subject: Re: cramfs for root filesystem?
References: <45B36A38D959B44CB032DA427A6E10640167CFE8@cceexc18.americas.cpqcorp.net>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Sorry...  I haven't been living in the development PPC world lately.
These patches should apply against the stock 2.4.18 kernel.
Anyone is welcome to adapt them to the PPC development stuff
and the sourceforge version of mkcramfs   :)

(I'm on a new project involving an ARM processor now, so I'm not
particularly current with the PPC stuff!)

Steve



"Cameron, Steve" wrote:
>
> Steven Hein [mailto:ssh@sgi.com] wrote:
>
> > [...] You do need a kernel patch to add cramfs to the list of
> > filesystems to check for in the initrd, also my patch forces the
> > blocksize of the initrd to 4K if it finds that it contains cramfs. [...]
>
> Hmm, this patch doesn't seem to apply to my fairly recent
> linuxppc_2_4_devel tree.  identify_ramdisk_image() for instance
> is in init/do_mounts.c, not drivers/block/rd.c, and there is a
> #define BUILD_CRAMDISK in there I guess relating to cramfs, though
> I'm not sure what it's doing.
>
> > I have also previously posted a patch to mkcramfs to swap
> > endianness on a cramfs filesystem   [...]
> >     http://lists.linuxppc.org/linuxppc-embedded/200206/msg00128.html
>
> Hmm, this patch doesn't seem to apply to the mkcramfs I got from
> sourceforge yesterday.
>
> Thanks, just the same.
>
> -- steve
>

--
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
Steve Hein (ssh@sgi.com)              Engineering Diagnostics/Software
Silicon Graphics, Inc.
1168 Industrial Blvd.                 Phone: (715) 726-8410
Chippewa Falls, WI 54729              Fax:   (715) 726-6715
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
