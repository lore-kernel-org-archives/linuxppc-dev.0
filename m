Message-ID: <407E7267.305@imc-berlin.de>
Date: Thu, 15 Apr 2004 13:30:47 +0200
From: Steven Scholz <steven.scholz@imc-berlin.de>
MIME-Version: 1.0
To: LinuxPPC <linuxppc-embedded@lists.linuxppc.org>
Subject: Re: problem with queue_task() and mark_bh()...
References: <407BF458.5080408@imc-berlin.de> <407E42F9.1060201@imc-berlin.de>
In-Reply-To: <407E42F9.1060201@imc-berlin.de>
Content-Type: text/plain; charset=us-ascii; format=flowed
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Hi,

>>     queue_task( &( lp->task ), &tq_immediate );
>>     mark_bh( IMMEDIATE_BH );

I've put some printks in my kernel.

Now I can see that the task is successfully queued, that mark_bh() is called
and the tasklet_hi_schedule() calls __tasklet_hi_schedule().

But the function immediate_bh() in kernel/timer.c (which should then call
run_task_queue(&tq_immediate)) is never called.

Any ideas?

Steven

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
