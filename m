Content-Type: text/plain;
  charset="us-ascii"
From: Florian Schirmer <jolt@tuxbox.org>
To: linuxppc-dev@lists.linuxppc.org
Subject: Kernel 2.5.x on mpc8xx
Date: Fri, 15 Nov 2002 15:57:25 +0100
MIME-Version: 1.0
Message-Id: <200211151557.25779.jolt@tuxbox.org>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Hi,

here is a forwarded mail from a conversation between Tom Rini and myself. Hope
somebody can help me and any other 8xx users out there.

----------  Forwarded Message  ----------

Subject: Re: Kernel 2.5.x on MPC8XX
Date: Tue, 29 Oct 2002 11:44:11 -0700
From: Tom Rini <trini@kernel.crashing.org>
To: Florian Schirmer <jolt@tuxbox.org>

On Tue, Oct 29, 2002 at 08:38:07AM +0100, Florian Schirmer wrote:
> current 2.5.x version do not compile on 8XX boards, due to the changes in
> task_queues and (at least i think) the preempt changes. There might be a
> serial change problem also, but this is unconfirmed.
>
> head8xx.s has some strange unresolved symbols problems due to the removal
> of ret_from_interfecpt from entry.s.

head_8xx.S also needs some updating for MM changes.

> Sadly i was unable to fix them myself. I would like to ask you to give me
>  some assistance. It would be very very helpfull if you could fix the
>  problems in entry.s/head8xx.s.

Please bring this up on the linuxppc-embedded and linuxppc-dev lists,
thanks.

----------  Forwarded Message  end ----------

Regards,
    Florian

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
