Message-ID: <F1BED55F35F4D3118C0F00E0295CFF4DFF9F93@mail.mediatrix.com>
From: Jean-Denis Boyer <jdboyer@mediatrix.com>
To: "'Ricardo Scop'" <scop@vanet.com.br>
Cc: "'Dan Malek'" <dan@embeddededge.com>,
	linuxppc-embedded@lists.linuxppc.org
Subject: RE: Re[2]: 8260 - Spurious interrupt when calling __sti()
Date: Wed, 10 Apr 2002 13:16:18 -0400
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Ricardo,

> Even harder to explain is why you're having to put those syncs in
> __sti, since both my copies of 2.4.16 and 2.4.18-pre9 kernel sources
> already have them in the code... and with the comment
> "/* Some chip revs have problems here... */" !!!

At the left of the comment is 'SYNC', in uppercase.
According to "include/asm-ppc/ppc_asm.h", which defines the preprocessor
macro 'SYNC', it means something only if CONFIG_PPC601_SYNC_FIX
is defined. The comment seems to be old and imprecise.
After compiling the kernel, I disassembled it, just to be sure... ;-)


--------------------------------------------
 Jean-Denis Boyer, B.Eng., System Architect
 Mediatrix Telecom Inc.
 4229 Garlock Street
 Sherbrooke (Québec)
 J1L 2C8  CANADA
 (819)829-8749 x241
--------------------------------------------


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
