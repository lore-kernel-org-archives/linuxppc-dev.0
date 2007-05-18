Return-Path: <sshtylyov@ru.mvista.com>
Received: from imap.sh.mvista.com (unknown [63.81.120.155])
	by ozlabs.org (Postfix) with ESMTP id 1CF36DDEE0
	for <linuxppc-dev@ozlabs.org>; Sat, 19 May 2007 00:51:12 +1000 (EST)
Message-ID: <464DBDBA.3060801@ru.mvista.com>
Date: Fri, 18 May 2007 18:52:42 +0400
From: Sergei Shtylyov <sshtylyov@ru.mvista.com>
MIME-Version: 1.0
To: Albert Cahalan <acahalan@gmail.com>
Subject: Re: [PATCH 2.6.21-rt2] PowerPC: decrementer clockevent driver
References: <787b0d920705172024g723412b4n8f82d3cd78e0f702@mail.gmail.com>
In-Reply-To: <787b0d920705172024g723412b4n8f82d3cd78e0f702@mail.gmail.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Cc: linuxppc-dev@ozlabs.org, tglx@linutronix.de, linux-kernel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Hello.

Albert Cahalan wrote:

>>>>> I haven't looked at all the new clock/timer code, is there any
>>>>> utility in having support for more than one clock source?

>>>> Of course, you may register as many as you like.

>>> Sure, but is there any utility in registering more than the
>>> decrementer on PPC?

>> Not yet. I'm not sure I know any other PPC CPU facility fitting
>> for clockevents. In theory, FIT could be used -- but its period
>> is measured in powers of 2, IIRC.

> I'd really like to have that as an option. It would allow oprofile
> to safely use hardware events on the MPC74xx "G4" processors.
> Alternately it would allow thermal events. It is safe to use at
> most one of the three (decrementer,profiling,thermal) interrupts.
> If two were to hit at the same time, badness happens.

    Unfortunately, FIT exists only on Book E CPUs and MPC74xx aren't Book E, IIUC.

> It's possible to wrapper the interrupt in something that divides
> down, calling the normal code only some of the time. I think one
> of the FIT choices is about 4 kHz on my system, which would be OK.

    Erm, are you sure you have FIT (or is your system not MPC74xx based)?

> Full oprofile functionality would be wonderful.

WBR, Sergei
