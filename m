From: Paul Mackerras <paulus@samba.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Message-ID: <15337.8185.840818.69643@cargo.ozlabs.ibm.com>
Date: Wed, 7 Nov 2001 22:50:17 +1100 (EST)
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Linux/PPC Development <linuxppc-dev@lists.linuxppc.org>
Subject: Re: The Plan
In-Reply-To: <Pine.GSO.4.21.0111071246050.11631-100000@mullein.sonytel.be>
References: <15337.7275.266062.777161@cargo.ozlabs.ibm.com>
	<Pine.GSO.4.21.0111071246050.11631-100000@mullein.sonytel.be>
Reply-To: paulus@samba.org
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Geert Uytterhoeven writes:

> Why not move platform-specific files to arch/ppc/<platform>/ instead?
>
> Your solution reduces the clutter only by a factor of 2, while creating
> platform-specific directories reduces it by a factor of n.

But adds n extra directories, most of which would only have 2 or 3
files in them, thereby cluttering up arch/ppc.

Paul.

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
