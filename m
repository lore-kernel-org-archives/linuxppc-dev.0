Date: Wed, 18 Dec 2002 14:07:45 +0600 (GMT-6)
From: Claudia Salzberg <sentinel@jump.net>
To: <linuxppc-embedded@lists.linuxppc.org>
Subject: mapping back to 36 bit physical 
Message-ID: <Pine.LNX.4.33.0212181358270.23138-100000@grandmaster.protagonist.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=ISO-8859-1
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Greetings.
How does one go about aquiring the 36-bit physical address on a 440XX if
you have the corresponding va from an ioremap (when your driver is not
the one that did the ioremap so that you don't have the pa saved)?  I see
that ioremap does support 36-bit I/O mapping but _va and _pa only play
with unsigned long's.  So does iopa.  So do the virt_to_* 's I was able
to find.  Also, does anyone have plans for incorporating memory access
hooks above 4GB address space?

Thanks,

Claudia Salzberg


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
