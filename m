Date: Sat, 27 May 2000 21:58:36 -0400
Subject: Re: Debian pmud package available
From: Robert Thompson <rothomp3@vt.edu>
To: Michael Schmitz <schmitz@opal.biophys.uni-duesseldorf.de>
CC: <linuxppc-dev@lists.linuxppc.org>
Message-ID: <B555F58A.7D5%rothomp3@vt.edu>
In-Reply-To: <Pine.LNX.4.10.10005261124590.25198-100000@opal.biophys.uni-duesseldorf.de>
Mime-version: 1.0
Content-type: text/plain; charset="US-ASCII"
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


on 5/26/00 5:25 AM, Michael Schmitz at
schmitz@opal.biophys.uni-duesseldorf.de wrote:

>
>> Sorry to step in this thread, but I am interested in having those
>> power management capabilities on my Pismo too. I use LinuxPPC 2000
>> (2.2.15pre19)
>>
>> Where can I get the RPMS or tar files.
>
> http://www3.jvc.nl/linuxppc/
>
>
OK, so, I got the source, applied the patch I found, and built it. Well, I
tried to... it failed because pmu.h redeclared something that was in some
system header of the same name... I commented out the thing in pmu.h
(something about PMU_TYPE) and it compiled... but I was worried, because the
thing I commented out had a comment saying /* iBook */ and I happen to be
using an iBook SE. But, anything to get it to compile, right? It appears to
report battery status correctly. I'm using the latest rsync kernel. But when
I try to put the machine to sleep, it starts saying "hda: lost interrupt"
and becomes unusable. Also, it should be noted that the iBook's CD-ROM *is*
hdc (I seem to remember that being a question earlier). Any ideas?

Later,
Robbie Thompson


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
