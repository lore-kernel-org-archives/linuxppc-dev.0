Message-ID: <C97ABDA0DC2DD511BA400002A5097413280506@jdry.lanier.com>
From: "Donovan, Chris" <cdonovan@lanier.com>
To: "'linuxppc-embedded@lists.linuxppc.org'" <linuxppc-embedded@lists.linuxppc.org>
Subject: Linux on a NCD Explora 450 Xterm
Date: Tue, 25 Sep 2001 09:46:13 -0400
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


I've got a NCD Explora 450 Xterm which I am trying to load up Linux on. The
Explora has a PowerPC 403CGX processor in it. During normal use the Explora
uses tftp to load an NCDware image from one of our servers.

I have compiled a Linux kernel configured for an Oak board. After I ran
"make zImage" I found vmlinux but I was unable to find vmlinux.img. There
were no errors indicating that there was a problem.

At this point, I'm trying to figure out how to take vmlinux and boot it on
the Explora. Both vmlinux and the NCDware image seem to be ELF executables
but when I try to load the vmlinux file onto the Explora via tftp I get the
following error: "Address out of range. File is bad or too large for
installed memory." The vmlinux file is much smaller then the NCDware file
and I get the same error even if I pad blanks on the end of vmlinux to make
it the same size as the NCDware file. I assume that this is not an
appropriate file to be loading to the Explora. Does anyone have any
suggestions for a way to go about creating an appropriate file? I'm
interested in developing this if someone can provide some guidance on how to
do it. Thanks.

Chris Donovan
Lanier Worldwide

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
