To: bharat <bharat@coraltele.com>
Cc: PPC_LINUX <linuxppc-embedded@lists.linuxppc.org>
Subject: Re: task utility 
From: Wolfgang Denk <wd@denx.de>
Mime-version: 1.0
Content-type: text/plain; charset=ISO-8859-1
In-reply-to: Your message of "08 Jul 2004 14:05:41 +0530."
             <10524037.1089275683984.JavaMail.administrator@RnDserver>
Date: Thu, 08 Jul 2004 11:59:41 +0200
Message-Id: <20040708095947.0FA3DC109F@atlas.denx.de>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


In message <10524037.1089275683984.JavaMail.administrator@RnDserver> you wrote:
>
> i want to know whether there exist  any utility in hardhat-linux which
> can tell  me the status of all processes running on my embedded system

man ps ?

man top ?

> actually i am facing a strange problem of losing my task the kernel
> starts its threads but does not show the execution of task
> any other idea?

Use a debugger?


Wolfgang Denk

--
Software Engineering:  Embedded and Realtime Systems,  Embedded Linux
Phone: (+49)-8142-4596-87  Fax: (+49)-8142-4596-88  Email: wd@denx.de
"Everything should be made as simple as possible, but not simpler."
                                                    - Albert Einstein

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
