Message-ID: <3D18F153.50104@broadon.com>
Date: Tue, 25 Jun 2002 15:40:19 -0700
From: David Blythe <blythe@broadon.com>
MIME-Version: 1.0
To: steve.cameron@hp.com
Cc: linuxppc-embedded@lists.linuxppc.org
Subject: Re: cramfs for root filesystem?
References: <20020625110421.A6712@zuul.cca.cpqcorp.net>
Content-Type: text/plain; charset=us-ascii; format=flowed
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Stephen Cameron wrote:
> I have tried to fix up the endian-swapping patch for
> the mkcramfs from sourceforge CVS, circa Mon Jun 24, 2002
> :pserver:anonymous@cvs.cramfs.sourceforge.net:/cvsroot/cramfs
>
>


If you are going to take that version of mkcramfs, you could just as
well take the corresponding version of the cramfs fs implemention since
it hardwires conversion to *little endian* into the kernel
implementation, or if you really still want a big endian cramfs, just
usurp all of the endianness macros (e.g., CRAMFS_32(), CRAMFS_16(), etc)
that were added to the header.

	david


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
