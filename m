Message-ID: <4063ED30.2020807@imc-berlin.de>
Date: Fri, 26 Mar 2004 09:43:28 +0100
From: Steven Scholz <steven.scholz@imc-berlin.de>
MIME-Version: 1.0
To: LinuxPPC <linuxppc-embedded@lists.linuxppc.org>,
	kernel@plumlocosoft.com
Subject: Re: O(1) scheduler for PPC?
References: <Pine.LNX.4.44.0403260858030.25458-100000@linpc003.aimsys.nl>
In-Reply-To: <Pine.LNX.4.44.0403260858030.25458-100000@linpc003.aimsys.nl>
Content-Type: text/plain; charset=us-ascii; format=flowed
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Jaap-Jan Boor wrote:

> On Thu, 25 Mar 2004, Steven Scholz wrote:
>>
>>is the backport of Ingo Molnar's O(1) scheduler in the official linux-2.4.2x
>>tree and is it available for the PPC?
>
> an up-to-date patch together with the preemptible kernel and low-latency
> patches for 2.4.25 are available here:
>
> http://www.plumlocosoft.com/kernel

Thanks a lot.

But it looks like the recent "full patch against 2.4.25" found at

http://www.plumlocosoft.com/kernel/patches/2.4/2.4.25/2.4.25-lck1/patch-2.4.25-lck1.bz2

still got the problems mentioned ages ago in

http://lists.linuxppc.org/linuxppc-dev/200212/msg00032.html

Maybe Eric Hustvedt could merge these trivials into his patch set.

Thanks a million,

Steven


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
