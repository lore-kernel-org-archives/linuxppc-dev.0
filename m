Message-ID: <007001c1bf2f$21471800$1a11efcb@industrialDiv.hanasys.co.kr>
Reply-To: "Sangmoon Kim" <dogoil@etinsys.com>
From: "Sangmoon Kim" <dogoil@etinsys.com>
To: "Wolfgang Denk" <wd@denx.de>
Cc: "linuxppc-embedded" <linuxppc-embedded@lists.linuxppc.org>
References: <20020226132131.B2A58109E3@denx.denx.de>
Subject: Re: execve system call question 
Date: Wed, 27 Feb 2002 10:36:08 +0900
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Hi Wolfgang Denk.

> You're running with root filesystem over NFS,  so  just  start  up  a
> network  sniffer  (like  ethereal)  and  check  all  NFS requests and
> replys. Probably  something  is  missing  in  your  root  filesystem.
> Something essential, like /dev/console or so.

The root file system is from Hardhat Linux. I think it's correct because so many people use it without complain. and the /dev/console exist.
I tried ramdisk. But the result was same.

Thank you for the reply.

----- Original Message -----
From: "Wolfgang Denk" <wd@denx.de>
To: "Sangmoon Kim" <dogoil@etinsys.com>
Cc: "linuxppc-embedded" <linuxppc-embedded@lists.linuxppc.org>
Sent: Tuesday, February 26, 2002 10:21 PM
Subject: Re: execve system call question


>
> In message <008901c1beb1$409cc7f0$1a11efcb@industrialDiv.hanasys.co.kr> you wrote:
> >
> > I traced the code and the point of stopping is after calling
> > execve("/sbin/init", argv_init, envp_init)
> > in init/main.c
> >
> > I was trying to trace more, but it was impossible
> > because of the complexity of the code.
>
> It's not impossible. In fact, it's quite simple.
>
> You're running with root filesystem over NFS,  so  just  start  up  a
> network  sniffer  (like  ethereal)  and  check  all  NFS requests and
> replys. Probably  something  is  missing  in  your  root  filesystem.
> Something essential, like /dev/console or so.
>
> > Is there any method to debug this?
>
> Yes, attach a BDI2000 and check where you are...
>
> > I'm debugging it for a month.
>
> Urghhh...
>
> Wolfgang Denk
>
> --
> Software Engineering:  Embedded and Realtime Systems,  Embedded Linux
> Phone: (+49)-8142-4596-87  Fax: (+49)-8142-4596-88  Email: wd@denx.de
> Use C++ to confuse your enemies; use C to produce stable code.
>
>
>

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
