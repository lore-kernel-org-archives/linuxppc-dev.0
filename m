From: Paul Mackerras <paulus@samba.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Message-ID: <15863.44615.245438.78166@argo.ozlabs.ibm.com>
Date: Thu, 12 Dec 2002 08:29:43 +1100
To: "Xiaogeng (Shawn) Jin" <xjin@redswitch.com>
Cc: linuxppc-embedded@lists.linuxppc.org
Subject: Re: usage of disarm_decr[]
In-Reply-To: <3DF7AA61.9020205@redswitch.com>
References: <3DF7AA61.9020205@redswitch.com>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Xiaogeng (Shawn) Jin writes:

> What's the purpose of using disarm_decr? I read the timer_interrupt()
> code and found the only place where it's referenced.

RT-Linux (www.fsmlabs.com) uses it.  RT-Linux takes over all interrupt
handling, including decrementer interrupts, and the disarm_decr thing
is there to give RT-Linux a way to take control of the decrementer
register.

Paul.

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
