Message-ID: <638AA0336D7ED411928700D0B7B0D75BB323E0@mail2.aiinet.com>
From: "Gessner, Matt" <mattg@aiinet.com>
To: "'Linux PPC'" <linuxppc-embedded@lists.linuxppc.org>
Subject: Oddness: booting and debugging
Date: Fri, 4 Jan 2002 11:28:24 -0500 
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Hi, all,

For a couple of weeks now, my kernel (2.4-15) has been working
fine.  I went away for the holiday (egads), and now things are acting
funny.

In start_kernel, the 'printk(linux_banner)' all of a sudden is not working.

The previous kernel I'd built ran for 14+ days, and in that time I'd
rebooted
it several times w/ no problems, loading and testing modules.

You'll ask: "Well, what did you change?"  In the last 15 days, the only
C files that have changed are my modules, which aren't loaded until I
FTP them over.

The header files have changed lots, because of make deps, when I was
trying to figure all this out.

Now, when I debug this, I have 'MMU XLAT' set in my BDI2000.
But I do get lots of messages from the BDI about "*** MMU: address
translation for 0x------- failed" when I do the debugging.

Why is that?  I set CFLAGS_KERNEL to -g only, not the general CFLAGS.

Can anyone provide any insight as to why this would, all of a sudden,
stop working?

TIA,

Regards,

Matt Gessner

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
