Message-ID: <3BE9B389.7F02F21F@mvista.com>
Date: Wed, 07 Nov 2001 14:19:53 -0800
From: Frank Rowand <frank_rowand@mvista.com>
Reply-To: frowand@mvista.com
MIME-Version: 1.0
To: paulus@samba.org
Cc: Geert Uytterhoeven <geert@linux-m68k.org>,
	Linux/PPC Development <linuxppc-dev@lists.linuxppc.org>
Subject: Re: The Plan
References: <15337.7275.266062.777161@cargo.ozlabs.ibm.com>
		<Pine.GSO.4.21.0111071246050.11631-100000@mullein.sonytel.be> <15337.8185.840818.69643@cargo.ozlabs.ibm.com>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Paul Mackerras wrote:
>
> Geert Uytterhoeven writes:
>
> > Why not move platform-specific files to arch/ppc/<platform>/ instead?
> >
> > Your solution reduces the clutter only by a factor of 2, while creating
> > platform-specific directories reduces it by a factor of n.
>
> But adds n extra directories, most of which would only have 2 or 3
> files in them, thereby cluttering up arch/ppc.

One advantage of having arch/ppc/<platform>/ is that it allows for
the possibility of arch/ppc/platform/, which is a link to the
specific <platform> which is being built.  This would be similar
to the way that include/asm/ is a link to include/asm-<architecture>/

-Frank
--
Frank Rowand <frank_rowand@mvista.com>
MontaVista Software, Inc

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
