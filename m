To: "Sangmoon Kim" <dogoil@etinsys.com>
Cc: "linuxppc-embedded" <linuxppc-embedded@lists.linuxppc.org>
Subject: Re: execve system call question 
From: Wolfgang Denk <wd@denx.de>
Mime-version: 1.0
Content-type: text/plain; charset=ISO-8859-1
In-reply-to: Your message of "Tue, 26 Feb 2002 19:35:04 +0900."
             <008901c1beb1$409cc7f0$1a11efcb@industrialDiv.hanasys.co.kr>
Date: Tue, 26 Feb 2002 14:21:26 +0100
Message-Id: <20020226132131.B2A58109E3@denx.denx.de>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


In message <008901c1beb1$409cc7f0$1a11efcb@industrialDiv.hanasys.co.kr> you wrote:
>
> I traced the code and the point of stopping is after calling
> execve("/sbin/init", argv_init, envp_init)
> in init/main.c
>
> I was trying to trace more, but it was impossible
> because of the complexity of the code.

It's not impossible. In fact, it's quite simple.

You're running with root filesystem over NFS,  so  just  start  up  a
network  sniffer  (like  ethereal)  and  check  all  NFS requests and
replys. Probably  something  is  missing  in  your  root  filesystem.
Something essential, like /dev/console or so.

> Is there any method to debug this?

Yes, attach a BDI2000 and check where you are...

> I'm debugging it for a month.

Urghhh...

Wolfgang Denk

--
Software Engineering:  Embedded and Realtime Systems,  Embedded Linux
Phone: (+49)-8142-4596-87  Fax: (+49)-8142-4596-88  Email: wd@denx.de
Use C++ to confuse your enemies; use C to produce stable code.

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
