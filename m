Message-ID: <3A65E51B.50FC28EC@tei.ericsson.se>
Date: Wed, 17 Jan 2001 19:31:55 +0100
From: Borlizzi Giacomo <giacomo.borlizzi@tei.ericsson.se>
MIME-Version: 1.0
To: Dan Malek <dan@mvista.com>
CC: "linuxppc-embedded@lists.linuxppc.org"
 <linuxppc-embedded@lists.linuxppc.org>,
        "Giacomo Borlizzi (TEI)" <giacomo.borlizzi@tei.ericsson.se>
Subject: Re: KERNELBASE and MMU
References: <3A648564.671DDDD5@tei.ericsson.se> <3A64C847.D2414D1D@mvista.com>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Does you say that linux code is not PIC? (position indipendent code)
Why such constraint on physical memory area? It don't make some
limitation on portability of code?
/Giacomo Borlizzi



Dan Malek wrote:

> Borlizzi Giacomo wrote:
>
> > My configuration foreseen  KERNELBASE set to 0x00000000 instead of
> > 0xC0000000
>
> I don't really understand, but you should not be changing anything
> in the source code or Makefiles or configuration files that affect
> the MMU or virtual address mapping.
>
>         -- Dan


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
