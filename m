From: "Stefano Coluccini" <s.coluccini@caen.it>
To: "Tom Rini" <trini@kernel.crashing.org>
Cc: "Bj?rn Wingman" <bjowi@ida.liu.se>,
	<linuxppc-embedded@lists.linuxppc.org>
Subject: RE: mcpn765
Date: Fri, 16 Mar 2001 09:21:29 +0100
Message-ID: <NDBBIFIMCKPOADMAJOKMIECDDAAA.s.coluccini@caen.it>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
In-Reply-To: <20010315111921.A872@opus.bloom.county>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


> > Check the make file arch/ppc/boot/pp3/Makefile, in the rule for making
> > zImage.initrd there is a typo: you must add the -pbp option to
> the mkprep
> > invocation.
>
> This _should_ be fixed in current 2_5.
>

You are right, it is fixed with last updates, but I had the same symptom
described by Bjorn when the -pbp were missing. Perhaps Bjorn doesn't have
downloaded the last updates ?

Bye.
Stefano.


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
