Message-Id: <200101100818.f0A8InO32368@denx.local.net>
To: Micael balow <micaelbalow@yahoo.com.cn>
cc: linuxppc-embedded@lists.linuxppc.org
Subject: Re: New ppcboot Questions 
From: Wolfgang Denk <wd@denx.de>
Mime-version: 1.0
Content-type: text/plain; charset=ISO-8859-1
In-reply-to: Your message of "Wed, 10 Jan 2001 14:06:52 +0800."
             <20010110060652.49687.qmail@web11702.mail.yahoo.com>
Date: Wed, 10 Jan 2001 09:18:49 +0100
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Dear Micael,

in message <20010110060652.49687.qmail@web11702.mail.yahoo.com> you wrote:
>
>   I'd like to ask you which compiler you used to
> compile ppcboot-0.4.4-pre1 package in order to get a

I have sent you SEVERAL messages (Tue, 02 Jan 2001; Sat, 06 Jan 2001;
Mon, 08 Jan 2001) telling you (among other things) to  upgrade  to  a
current version of PPCBoot.

If you are ignoring all attempts to help you I will find a better use
for my time instead of answering your questions.

> working ppcboot.srec file.Some one advise me to use
> CDK 1.2.
>   But after I finished reading the manual of CDK 1.2,
> I found that, CDK 1.2 is a Cross Development Kit for
> Host-Target systems. What I really need is a just a
> Compiling Environment, since I my goal is to make a
> zImage for my PBX823 board with a MPC823 CPU on it.

Any cross-compiler that can be used to compile the Linux kernel  will
also be usable to compile PPCboot.

>   I think, you must have the experiences in compiling
> the ppcboot-0.4.4-pre1 package, so I¡¯d like to
> discuss with you the error messages I met when I used

I have explained you these problems several times  before,  and  told
you how to solve the problems.

> Judging from this message, there is three
> possibilities, first, ppc_8xx-gcc can not compile

Your main problem is that you ignore all advice you get.

I tell you one final time: Upgrade PPCBoot. Get 0.7.2  from  the  CVS
server.

All further messages referring to old versions  of  PPCBoot  will  be
gnored.

and  while  we  are  at  it:  please  move  such  discussion  to  the
ppcboot-users mailing list. And don't use full-quotes.

Wolfgang Denk

--
Software Engineering:  Embedded and Realtime Systems,  Embedded Linux
Phone: (+49)-8142-4596-87  Fax: (+49)-8142-4596-88  Email: wd@denx.de
Premature optimization is the root of all evil.         -- D.E. Knuth

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
