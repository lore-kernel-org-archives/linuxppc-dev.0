Message-ID: <3BAAF7F9.B4DAB4BA@mvista.com>
Date: Fri, 21 Sep 2001 04:19:06 -0400
From: Dan Malek <dan@mvista.com>
MIME-Version: 1.0
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: "Timothy A. Seufert" <tas@mindspring.com>,
	Mark Salisbury <mbs@mc.com>,
	Holger Bettag <hobold@Informatik.Uni-Bremen.DE>,
	Linux/PPC Development <linuxppc-dev@lists.linuxppc.org>
Subject: Re: ppc LE questions (seeking help hand info pointers)
References: <Pine.GSO.4.21.0109210950130.3006-100000@mullein.sonytel.be>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Geert Uytterhoeven wrote:

> AFAIK they do, for PCI accesses.

They do the same thing we do.  The ULTRASparc has address modifiers on the
load/store instructions to do byte swapping in the io macros, just like us.
The "other" Sparcs do it the hard way with actual byte swap code in the
macros.  There are comments in various files that clearly state Sparc is
big-endian without exception :-).


	-- Dan

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
