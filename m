To: Brad Boyer <flar@cegt201.bradley.edu>
Cc: jpgarcia@execpc.com (Joseph Palani Garcia),
        linuxppc-dev@lists.linuxppc.org
Subject: Re: EM86 port for LinuxPPC?
References: <199906102103.QAA15072@cegt201.bradley.edu>
From: Andreas Bogk <andreas@andreas.org>
Date: 11 Jun 1999 15:29:19 +0200
In-Reply-To: Brad Boyer's message of "Thu, 10 Jun 1999 16:03:00 -0500 (CDT)"
Message-ID: <m3emjivpao.fsf@soma.andreas.org>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Brad Boyer <flar@cegt201.bradley.edu> writes:

> our own x86 emulation library to replace it.  This isn't so much of a
> problem, because there is already a basic x86 emulator in one of the
> bootloaders, to be able to run BIOS code from PCI cards with x86 BIOS
> chips on them.  I started looking at it, but then I went on to

And then there is bochs, which is a complete PC emulator, and which
certainly could be modularized:

http://www.bochs.org

It reaches the speed of a 2 MHz 486 on my 300 MHz G3, so it's not
exactly a viable option for running x86 binaries on PPC.

Andreas

-- 
Reality is two's complement. See:
ftp://ftp.netcom.com/pub/hb/hbaker/hakmem/hacks.html#item154

[[ This message was sent via the linuxppc-dev mailing list.  Replies are ]]
[[ not  forced  back  to the list, so be sure to Cc linuxppc-dev if your ]]
[[ reply is of general interest. Please check http://lists.linuxppc.org/ ]]
[[ and http://www.linuxppc.org/ for useful information before posting.   ]]
