Date: Thu, 6 Sep 2001 11:26:13 -0700
From: Tom Rini <trini@kernel.crashing.org>
To: linuxppc-commit@source.mvista.com,
	linuxppc-dev@lists.linuxppc.org
Subject: egcs vs gcc-2.95.x
Message-ID: <20010906112613.M21172@cpe-24-221-152-185.az.sprintbbd.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Hello all.  I happened to be skimming asm/byteorder.h for some reason, and
noticed that we have ___arch__swab16/___arch__swab32 written, but #if 0'ed
because of an egcs bug.  A bit of grep'ing showed that set_bit (asm/bitops.h)
used to be #if 0'ed because of another egcs bug but isn't now.  So the
question is, is anyone still using egcs to compile a kernel?  If, so
what version (1.0.x or 1.1.x) and does anyone remember what version of
egcs produced the bug?

If nothing else, perhaps in 2.5 this should go away..

--
Tom Rini (TR1265)
http://gate.crashing.org/~trini/

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
