Date: Thu, 10 Oct 2002 19:00:43 -0400
From: Patrick Mahoney <pmahoney@8d.com>
To: Conn Clark <clark@esteem.com>
Cc: linuxppc-embedded@lists.linuxppc.org
Subject: Re: mpc8xx - power save modes - PIT
Message-ID: <20021010230042.GA8690@segfault.usine.8d.com>
References: <20021010183502.GA843@segfault.usine.8d.com> <3DA5F5EC.2844DE06@esteem.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <3DA5F5EC.2844DE06@esteem.com>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Conn,

Thanks a lot for your reply.

> 	I have played with some of the power saving modes on our custom
> 850 board and have had no problems. I have toyed with the Doze High and
> Doze Low modes in the idle loop. Attached is a hacked up idle loop for
> kernel 2.4.19 that works for me.

I recompiled and booted... it crashed on me! :( Maybe some differences
with the platform... I'll look into that tomorrow.

>
> Do you have the SCCR[PRQEN] bit set?

Have tried with and without sccr[prqen] bit set.

> Is there any particular reason you want to wake up the processor with
> the PIT instead of just letting any old interrupt wake it up?

Well i'd just like to be able to say : "im going to sleep. please wake
me in 5 seconds". If theres an easier way, please enlighten me! :)


> You should be able to drop my idle.c in place of the old one. To disable
> my hack just comment out the #define MPC8XX_POWERSAVE . My comments
> shouldn't be to hard to understand. Also I have the SCCR[PRQEN] and the
> SCCR[CRQEN] bits set.

Yep, i'll dig into it tomorrow. I'm kind of allergic to inline
assembly, but it's allright... ill have some pills! ;)

Once again, thanks a lot for your help.
Best regards,


Pat Mahoney

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
