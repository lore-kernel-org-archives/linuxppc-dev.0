Mime-Version: 1.0
Message-Id: <p04330103b64042f6fa28@[206.6.156.5]>
In-Reply-To: <20001121081013.G552@opus.bloom.county>
References: <p04330100b63f9bce42dd@[192.168.0.1]>
 <20001121081013.G552@opus.bloom.county>
Date: Tue, 21 Nov 2000 10:25:45 -0500
To: Tom Rini <trini@kernel.crashing.org>
From: Stefan Jeglinski <jeglin@4pi.com>
Subject: Re: whacked out 2.2.18preX - last gasp
Cc: linuxppc-dev@lists.linuxppc.org
Content-Type: text/plain; charset="us-ascii" ; format="flowed"
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


>  >	ERROR - Attempting to write value for
>>	unconfigured variable (CONFIG_SERIAL_CONSOLE).
>>
>>  when using make xconfig. I can't see how this could be related,
>>but it is true.
>
>xconfig is buggy sometimes.  Try make oldconfig afterwards, it'll prompt for
>anything which didn't get set by xconfig.

Yeah, that's why I don't see that my observations can be related to
this. I also tried make oldconfig and it lead to the same results.


>  > It's frankly hard at this point to buy that one of my PCI devices is
>>  walking over the kernel. Or if it is, it looks like the end of the
>>  Linux line for my PowerTowerPro with the 2940 card. I think this is
>>  either a bug in the aic7xxx driver that has been exposed by 2.2.18
>>  changes (highly doubtful, there are too many 2940s out there for it
>>  to have been missed), or a linux-pmac bug. I just don't know enough
>>  yet to prove it, much less find it.
>
>Hmm.  2.2.18pre21 from linuxppc_2_2 bk works on my G4/Yikes! with a 2940UW
>in it.  What compiler are you using?

dmesg:

	gcc version 2.95.2 19991024 (release/franzo) #1

rpm -qa |grep gcc:

	gcc-2.95.2-1i
	gcc-c++-2.95.2-1i
	gcc-objc-2.95.2-1i


What I'm worried about mainly is the 6 slots and the PCI bridge
structure in the PowerTowerPro (akin to PowerMac 9500). It is more
"complex" than G4, no? From my previous discussion with you and
others, I gather that there are a lot of problems with the PCI stuff,
that may not be cleared up for quite a while?


Stefan Jeglinski

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
