Message-Id: <200002031219.NAA07401@denx.local.net>
To: Marcus Sundberg <erammsu@kieray1.p.y.ki.era.ericsson.se>
cc: greyham@research.canon.com.au (Graham Stoney),
        alan@packetengines.com (Alan Mimms),
        linuxppc-embedded@lists.linuxppc.org (Linux PPC Embedded)
Subject: Re: Using LinuxPPC executables on 8xx processors
From: Wolfgang Denk <wd@denx.de>
Mime-version: 1.0
Content-type: text/plain; charset=ISO-8859-1
In-reply-to: Your message of "03 Feb 2000 12:32:38 +0100."
             <kfyu2jq34ix.fsf@kieraypc07.p.y.ki.era.ericsson.se>
Date: Thu, 03 Feb 2000 13:19:05 +0100
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


In message <kfyu2jq34ix.fsf@kieraypc07.p.y.ki.era.ericsson.se>
Marcus Sundberg wrote:
>
> > Well, in fact even the original (for instance LinuxPPC  R4)  binaries
> > *and*  libraries run pretty stable on the MPC8xx system once you have
> > the FPU emulation working. It seems that the cache line problem  does
> > not  show  up most of the time.
>
> IIRC R4 was not based on glibc2, so I'd expect it to never show up.

Of course you are right. I know there was another reason why I  stick
with R4 for the native test environment.

Wolfgang Denk

--
Software Engineering:  Embedded and Realtime Systems,  Embedded Linux
Phone: (+49)-8142-4596-87  Fax: (+49)-8142-4596-88  Email: wd@denx.de
When you die, the first thing you lose is your life. The  next  thing
is the illusions.                       - Terry Pratchett, _Pyramids_

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
