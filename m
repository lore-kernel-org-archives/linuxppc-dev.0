Date: Thu, 7 Aug 2003 11:01:44 -0400
Message-Id: <200308071501.h77F1iL19883@hyper.wm.sps.mot.com>
From: Peter Barada <pbarada@mail.wm.sps.mot.com>
To: zjhzou@newrocktech.com
Cc: linuxppc-embedded@lists.linuxppc.org
In-reply-to: <OOEJKGLHOBHLNAIEBLEFAEMFKJAA.zjhzou@newrocktech.com>
Subject: Re: kernel memory mapping problem
References: <OOEJKGLHOBHLNAIEBLEFAEMFKJAA.zjhzou@newrocktech.com>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


>when run this module( lsmod mymodule.o ), kernel is always dead. Are
>there any errors of this function ?
>
>Any help is appreciated!

What are you doing with the physical address of a varaible that is on
the *stack*?  If you let some hardware modify that value, then you can
easily trash your stack if the hardware modifies this value *after*
this function exits since tmp will go out of scope.

I'd suggest that you move tmp outside of func for starters.

--
Peter Barada                             Peter.Barada@motorola.com
Wizard                                   781-852-2768 (direct)
WaveMark Solutions(A Motorola Company)   781-270-0193 (fax)

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
