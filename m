From: Paul Mackerras <paulus@samba.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Message-ID: <16031.22226.295030.685058@nanango.paulus.ozlabs.org>
Date: Fri, 18 Apr 2003 11:37:22 +1000 (EST)
To: Takeharu KATO <tkato@cs.fujitsu.co.jp>
Cc: linuxppc-dev@lists.linuxppc.org
Subject: Re: Task tsruct relevant question
In-Reply-To: <3E9F440A.52FE7459@cs.fujitsu.co.jp>
References: <3E9F440A.52FE7459@cs.fujitsu.co.jp>
Reply-To: paulus@samba.org
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Takeharu KATO writes:

> I have a queestion about task_struct relevant issue.
> As far as I know, task_structs in kernel 2.5.X are placed in
> slab cache. But they are placed on kernel stack on linux-2.4.67
> for PPC4xx.
> Is it correct in linuxppc branch?
> Does any one have a plan to move them into slab cache down the line?

Separating the task_struct from the kernel stack is a change that was
made to all architectures earlier on in 2.5 development.  There is no
plan to do something similar in the 2.4 series since the 2.4 series is
now officially in maintenance mode.  (The OCP framework for PPC is
still being worked on in 2.4 but most other stuff should be pretty
much stabilized by now.)

Paul.


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
