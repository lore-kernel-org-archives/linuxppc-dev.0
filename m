Message-ID: <20020910135353.77955.qmail@web9505.mail.yahoo.com>
Date: Tue, 10 Sep 2002 06:53:53 -0700 (PDT)
From: Pete McCormick <pete261@yahoo.com>
Subject: Re: MPC8260 - missing functions
To: Hans.Feldt@uab.ericsson.se, linuxppc-embedded@lists.linuxppc.org
In-Reply-To: <200209101342.g8ADgXH06019@wnaw252.uab.ericsson.se>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Hans,

I am currently working on a port of a port of the 860esar atm driver for the
8260.  Once I am satisfied that it is working pretty well I will post the code
to the http://atm8260.sourceforge.net project.

If you want the code in the meantime, I can send it to you, but it might not
work.

Pete

--- "Hans dot Feldt at uab.ericsson.se" <"Hans dot Feldt at
uab.ericsson.se"@uab.ericsson.se> wrote:
>
> Could someone please briefly describe the status of the following
> functions that all are included in the 860 port. I can't find them in a
> patched 2.4.18 kernel.
>
> - KGDB
> - Watchdog
> - IDE disk support
> - ATM driver
>
> I have read the 8260 comments in the archive from Jon Diekema ("Current
> state of MPC8260 Linux") but that was 2,5 years ago. What has happened
> since then?
>
> I did a quick hack to get the watchdog working. I also ported the 8xx
> KGDB stuff in uart.c but it fails badly with a "kernel stack overflow in
> process c00d4420". That address is init_task_union. I am over my head
> here so I leave this unless someone has a clue.
>
>
> Regards,
> Hans
>
>
>

__________________________________________________
Yahoo! - We Remember
9-11: A tribute to the more than 3,000 lives lost
http://dir.remember.yahoo.com/tribute

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
