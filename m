Message-ID: <3CEBD3A2.8090200@pacbell.net>
Date: Wed, 22 May 2002 10:21:38 -0700
From: Armin <akuster@pacbell.net>
MIME-Version: 1.0
To: acurtis@onz.com
Cc: linuxppc-embedded@lists.linuxppc.org
Subject: Re: Stable BK for 405GP Walnut?
References: <NCBBIINEHIPFGJPLBEIFAEGJDHAA.acurtis@onz.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Allen Curtis wrote:
> I retrieved the latest linuxppc_2_4 source code with the intentions of
> building a Walnut kernel. We are looking to build the next shippable kernel
> ASAP so we thought it would be best to use the "stable" version.
> Unfortunately when I tried to configure and compile we encountered several
> surprises:
>
> 1. All the 405GP stuff is missing from the non-development tree. (PCI, DMA,
> all the OCP support such as Ethernet)
> 2. Compile errors in ppc4xx_pic.c, invalid relocation type messages. (This
> is something that I can solve with a little time.)
>
> What should I use to build a Walnut kernel?
>
>
>
>
>

Allen,


you will find all that in linuxppc_2_4_devel

armin


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
