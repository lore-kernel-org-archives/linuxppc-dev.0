Message-ID: <3A0B390B.94A8BB06@nexus-tech.net>
Date: Thu, 09 Nov 2000 18:53:47 -0500
From: Kyle Harris <kharris@nexus-tech.net>
MIME-Version: 1.0
To: linuxppc-embedded <linuxppc-embedded@lists.linuxppc.org>
Subject: multiple kernel images on TQM823
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Hi,

I have a STK823 kit that I have just started playing with. I've rebuilt
the kernel and also have some canned images that came with the CDK. I'm
using ppcboot for the MPC823. The present kernel lives at 0x40020000
(and boots fine). Can I load another kernel somewhere else in flash and
boot from it? I've tried loading images at 0x40200000, but I get a "Bad
Magic Number" error when booting.

Thanks, Kyle.

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
