MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Subject: RE: Unrecognized opcode: `mtdcr'
Date: Wed, 29 May 2002 14:30:16 -0500
Message-ID: <45B36A38D959B44CB032DA427A6E10640167CFD8@cceexc18.americas.cpqcorp.net>
From: "Cameron, Steve" <Steve.Cameron@hp.com>
To: "Tom Rini" <trini@kernel.crashing.org>
Cc: <linuxppc-embedded@lists.linuxppc.org>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


[..snip...]
>
> I think we need to change arch/ppc/Makefile from:
> ifdef CONFIG_40x
> CFLAGS := $(CFLAGS) -Wa,-m405
> endif
>
> To:
> ifdef CONFIG_4xx
> CFLAGS := $(CFLAGS) -Wa,-m405
> endif

Ok, this worked for me.  Thanks!  (I guess I wasn't so
far off track after all.)

> For the moment.  Until there's some 440-specific opcodes we use (are
> there any?) which means we'll need to do -Wa,-m440.

When I had tried "-Wa,-m440" before, it wasn't recognized as an option.
(but perhaps by "do -Wa,-m440", you mean enhance the C compiler and/or
assembler.)

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
