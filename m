From: benh@kernel.crashing.org
To: "David A. Gatwood" <dgatwood@gatwood.net>
Cc: <linuxppc-dev@lists.linuxppc.org>
Subject: Re: G4 boot crash problems with 2.4 "stable"
Date: Wed, 13 Feb 2002 20:07:44 +0100
Message-Id: <20020213190744.31608@mailhost.mipsys.com>
In-Reply-To: <Pine.LNX.3.96.1020213104616.6305C-100000@gatwood.net>
References: <Pine.LNX.3.96.1020213104616.6305C-100000@gatwood.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


>> A workaround for pmac or openpic ppc32 is to use the keylargo or the
>> openpic timer instead of the DEC. That could be a "kernel hacking" option
>
>Speaking of OpenPIC....  I tried to build a kernel from BK TOT last night
>for a PowerMac G4, and it hung about a half screen into booting after some
>yammering about OpenPIC.
>
>openpic enter
>openpic timer
>openpic ext
>(hang)
>
>
>Is there a 2.4 kernel source tarball around that is known to boot on
>Sawtooth (using BootX)?  Is there a way to yank the OpenPIC support?

BootX isn't supported on any newworld mac. You should boot from OF,
using yaboot.

Ben.


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
