Date: Wed, 13 Feb 2002 11:01:09 -0800 (PST)
From: "David A. Gatwood" <dgatwood@gatwood.net>
To: benh@kernel.crashing.org
Cc: linuxppc-dev@lists.linuxppc.org
Subject: G4 boot crash problems with 2.4 "stable"
In-Reply-To: <20020213124811.28885@mailhost.mipsys.com>
Message-ID: <Pine.LNX.3.96.1020213104616.6305C-100000@gatwood.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Wed, 13 Feb 2002 benh@kernel.crashing.org wrote:

> A workaround for pmac or openpic ppc32 is to use the keylargo or the
> openpic timer instead of the DEC. That could be a "kernel hacking" option

Speaking of OpenPIC....  I tried to build a kernel from BK TOT last night
for a PowerMac G4, and it hung about a half screen into booting after some
yammering about OpenPIC.

openpic enter
openpic timer
openpic ext
(hang)


Is there a 2.4 kernel source tarball around that is known to boot on
Sawtooth (using BootX)?  Is there a way to yank the OpenPIC support?


David

---------------------------------------------------------------------
                    Check out my weekly web comic:
                     http://www.techmagazine.org


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
