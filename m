From: Ruedi.Hofer@ascom.ch
Date: Mon, 03 Apr 2000 08:55:29 +0100 (CED)
Subject: PCMCIA support for 860
To: linuxppc-embedded@lists.linuxppc.org
Cc: kernel@linux01.hasler.ascom.ch
Message-id: <0FSF00NFMHXF1M@pmdf-it.hasler.ascom.ch>
MIME-version: 1.0
Content-type: MULTIPART/MIXED; BOUNDARY="Boundary_(ID_lI4iG1vY1SDYhHfrVNXJTQ)"
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


--Boundary_(ID_lI4iG1vY1SDYhHfrVNXJTQ)
Content-type: TEXT/PLAIN
Content-Transfer-Encoding: 7BIT

Hi

In the february mailing list I found the PCMCIA patch from Magnus Damm. It looks
very interesting and useful.
>From reading the 'Kernel modification' list I assume that I need some help.

Extract from Mail http://lists.linuxppc.org/listarcs/linuxppc-embedded/200002/msg00093.html:

> 1. First of all you need to ioremap 64KByte at _IO_BASE.
>    This is for the emulated ISA-bus.
>    VIRT must be PHYS and I don't know how to do that
>    from a module.

> 2. All bus operations that are 16 bit or more should be
>    big endian - no swapping. This is the same as APUS in io.h.
>    We need to figure out how this should co-exist with
>    the swapped ISA.

Did someone already integrate those enhancements into the Kernel. If yes, do you mind
sending the affected files??

Cheers, Ruedi Hofer

--Boundary_(ID_lI4iG1vY1SDYhHfrVNXJTQ)--

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
