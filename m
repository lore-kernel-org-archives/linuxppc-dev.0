Message-ID: <F1BD619B2A58D41197990050DA2C08E41A5E2C@SLINK12>
From: Steve Ferri <sferri@ss7-link.com>
To: "Linuxppc-Embedded (E-mail)" <linuxppc-embedded@lists.linuxppc.org>
Subject: Cache Inhibit on 860?
Date: Mon, 26 Feb 2001 11:12:32 -0500
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


All:

I am having problems running on an 860 based card when reading and writing
buffers
for drivers and for user space applications.  Currently I am using the
invalidate
and flush cache calls when READING and WRITING from/to the alloc'd memory
during
these situations.

Is there a way to alloc memory and mark it as cache inhibited ?

This would eliminating the need for the invalidate and flush calls.  I am
currently
running a 2.2.14 version of the kernel on an 860 processor.

I've already tried using the m8xx_cpm_hostalloc() function in the
arch/ppc/8xx_io/commproc.c file.  This does not seem to work, as the memory
returned does not seem to be cache inhibited.  I still need to flush
and invalidate these regions.

Any ideas ?

Regards,
Steve


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
