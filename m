To: Wolfgang Denk <wd@denx.de>
Cc: greyham@research.canon.com.au (Graham Stoney),
        alan@packetengines.com (Alan Mimms),
        linuxppc-embedded@lists.linuxppc.org (Linux PPC Embedded)
Subject: Re: Using LinuxPPC executables on 8xx processors
References: <200002030826.JAA27945@denx.local.net>
From: Marcus Sundberg <erammsu@kieray1.p.y.ki.era.ericsson.se>
Date: 03 Feb 2000 12:32:38 +0100
In-Reply-To: Wolfgang Denk's message of "Thu, 03 Feb 2000 09:26:21 +0100"
Message-ID: <kfyu2jq34ix.fsf@kieraypc07.p.y.ki.era.ericsson.se>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Wolfgang Denk <wd@denx.de> writes:

> Well, in fact even the original (for instance LinuxPPC  R4)  binaries
> *and*  libraries run pretty stable on the MPC8xx system once you have
> the FPU emulation working. It seems that the cache line problem  does
> not  show  up most of the time.

IIRC R4 was not based on glibc2, so I'd expect it to never show up.

//Marcus
--
Signature under construction, please come back later.

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
