To: Robert Schwebel <robert@schwebel.de>
Cc: linuxppc-dev@lists.linuxppc.org
Subject: Re: init does not run on 405GP system 
From: Wolfgang Denk <wd@denx.de>
Mime-version: 1.0
Content-type: text/plain; charset=ISO-8859-1
In-reply-to: Your message of "Tue, 10 Jun 2003 17:12:18 +0200."
             <20030610151217.GV9379@pengutronix.de>
Date: Tue, 10 Jun 2003 18:52:51 +0200
Message-Id: <20030610165256.F21EDC5FD7@atlas.denx.de>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


In message <20030610151217.GV9379@pengutronix.de> you wrote:
>
> But that cannot be the reason why a hello_world does not work and why I

Show us your "hello_world" code. Does it actually open "/dev/console" ?

> do not see the sys_write() syscall being called at all. Btw, init on my
> other rootfs is busybox init. I suppose I should always see someting
> useful when init is starting.

Why do you assume that?


Best regards,

Wolfgang Denk

--
Software Engineering:  Embedded and Realtime Systems,  Embedded Linux
Phone: (+49)-8142-4596-87  Fax: (+49)-8142-4596-88  Email: wd@denx.de
"Though a program be but three lines long,
someday it will have to be maintained."
- The Tao of Programming

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
