To: "Jakob Jepsen" <JSJ@voxtream.com>
Cc: linuxppc-embedded@lists.linuxppc.org
Subject: Re: MPC8xx INIT_TASK_SIZE 
From: Wolfgang Denk <wd@denx.de>
Mime-version: 1.0
Content-type: text/plain; charset=ISO-8859-1
In-reply-to: Your message of "Thu, 20 Dec 2001 08:47:50 +0100."
             <sc21a5bd.052@mail.pel.dk>
Date: Thu, 20 Dec 2001 09:06:17 +0100
Message-Id: <20011220080622.4178010E18@denx.denx.de>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Dear Jacob,

in message <sc21a5bd.052@mail.pel.dk> you wrote:
>
> Why is it not possibly to increase INIT_TASK_SIZE in schred.c and there by increase the kernel stack size?

In schred.c? Do you mean include/linux/sched.h instead by any chance?
Because that's the only place where INIT_TASK_SIZE is actually used.

Why do you think you can't increase it?

> Im running a heavy loaded RTLinux subsystem and the hole system (2.4.4 from Denx) go's down when I start a big program in Linux user-space.

Um... you don;t want run RTL on a 8xx system; there are a  couple  of
bugs  which  have never been fixed - and we (DENX) will not spend any
further efforts on RTL.

Use RTAI instead, which will continue to  be  supported  on  8xx  and
other PPC systems.

Wolfgang Denk

--
Software Engineering:  Embedded and Realtime Systems,  Embedded Linux
Phone: (+49)-8142-4596-87  Fax: (+49)-8142-4596-88  Email: wd@denx.de
I paid too much for it, but its worth it.

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
