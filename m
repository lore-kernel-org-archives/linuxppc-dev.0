MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Subject: RE: cramfs for root filesystem?
Date: Wed, 26 Jun 2002 08:28:17 -0500
Message-ID: <45B36A38D959B44CB032DA427A6E10640167CFEC@cceexc18.americas.cpqcorp.net>
From: "Cameron, Steve" <Steve.Cameron@hp.com>
To: "David Blythe" <blythe@broadon.com>
Cc: <linuxppc-embedded@lists.linuxppc.org>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


>
> Stephen Cameron wrote:
> > I have tried to fix up the endian-swapping patch for
> > the mkcramfs from sourceforge CVS, circa Mon Jun 24, 2002
> > :pserver:anonymous@cvs.cramfs.sourceforge.net:/cvsroot/cramfs

> If you are going to take that version of mkcramfs, you could just as
> well take the corresponding version of the cramfs fs
> implemention since
> it hardwires conversion to *little endian* into the kernel

Yes, this would be the preferable solution, and is what I looked
for first, but I didn't know it was done already. Where can I
get that?

Oh! Duh!  Now I see it!  (knocking self on head :-)

I hadn't noticed that I got it up when I did the
"cvs co ." to check out mkcramfs from sourceforge.
I wasn't expecting kernel parts in there.

I just tried it out, and it works great!  Thanks
for saving me some effort.

-- steve


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
