Message-ID: <F1BED55F35F4D3118C0F00E0295CFF4DFF9F95@mail.mediatrix.com>
From: Jean-Denis Boyer <jdboyer@mediatrix.com>
To: "'Dan Malek'" <dan@embeddededge.com>
Cc: linuxppc-embedded@lists.linuxppc.org
Subject: RE: 8260 - Spurious interrupt when calling __sti()
Date: Wed, 10 Apr 2002 14:30:39 -0400
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Dan,

> Ahhhh.....I see now.  It took some time to get the _devel
> updates into the stable tree.  The spurious interrupt is
> an artifact of the 8260 code not updated to match Ben's
> generic PPC changes.

Doh! Yes, sorry. I was referring to the stable tree.
As I can see by comparing with the _devel tree,
for the 2.4.18 release,
is that "ppc8260_pic.c" was correctly updated,
but not "irq.c". The 'while' loop is absent.

However, this apparent 'out of sync' has nothing to do
with the fact that the invalid interrupt pops up, right ?


--------------------------------------------
 Jean-Denis Boyer, B.Eng., System Architect
 Mediatrix Telecom Inc.
 4229 Garlock Street
 Sherbrooke (Québec)
 J1L 2C8  CANADA
 (819)829-8749 x241
--------------------------------------------

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
