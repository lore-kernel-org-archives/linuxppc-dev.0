In-Reply-To: <20040120223457T.ekato@ees.hokudai.ac.jp>
References: <4824AFEC-4B0A-11D8-A780-00039394E428@ees.hokudai.ac.jp> <Pine.GSO.4.58.0401201102450.18625@waterleaf.sonytel.be> <20040120223457T.ekato@ees.hokudai.ac.jp>
Mime-Version: 1.0 (Apple Message framework v609)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <10F0AFAD-4B61-11D8-8D03-000A95A0560C@us.ibm.com>
Cc: Linux/PPC Development <linuxppc-dev@lists.linuxppc.org>
From: Hollis Blanchard <hollisb@us.ibm.com>
Subject: Re: local_irq_enable() problem...
Date: Tue, 20 Jan 2004 09:55:27 -0600
To: Etsushi Kato <ekato@ees.hokudai.ac.jp>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Jan 20, 2004, at 7:34 AM, Etsushi Kato wrote:
>
> In the early boot sequence, 2.6 kernel freezes just after showing
> 'arch_exit' on the screen, and 'Console: colour dummy device 80x25' on
> the serial console.  Even if I put printk() right after
> local_irq_enable() in init/main.c, this debug print won't show up.  So
> it seems something causes kernel hang while enabling MSR_EE bit, but I
> can't figure out how to detect...  Does anyone have a clue?

Perhaps you have an irq that won't shut up? Or maybe a problem
returning from an exception handler (I'm assuming you have your own
head.S).

--
Hollis Blanchard
IBM Linux Technology Center


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
