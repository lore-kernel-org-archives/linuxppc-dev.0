Return-Path: <owner-linuxppc-embedded@lists.linuxppc.org>
Date: 5 Jun 2002 11:21:13 -0000
Message-ID: <20020605112113.25323.qmail@webmail3.rediffmail.com>
MIME-Version: 1.0
From: "vandana  mehtani" <vandana_mehtani123@rediffmail.com>
Reply-To: "vandana  mehtani" <vandana_mehtani123@rediffmail.com>
To: linuxppc-embedded@lists.linuxppc.org
Subject: Re: Re: problem when compiling gcc for pwerpc
Content-type: text/plain;
	format=flowed
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


ya i can do this ..
but the error if can be solved wld be nice...
it is looking for ppc-linux-ar..
which is made in the binutils in the bin diretory..
why it is not taking in the path ..
i donot understand..
bye
vandana


On Wed, 05 Jun 2002 Wolfgang Denk wrote :
>Dear Vandana,
>
>in message <20020605091527.20240.qmail@webmail9.rediffmail.com>
>you wrote:
> >
> > i am trying to make a crosscompiler for powerpc using the
>option
> > powerpc-linux...
>
>Why don't you just use existing, working tools?  Our  Embedded
>Linux
>Development  Kit  is  free for download, just us it. It also
>includes
>instructions how to rebuild  from  prstine  source  files  if
>you're
>really in the mood to do so. See http://www.denx.de/ELDK/
>
> > when i was trying to configure gcc for powerpc with the
>following
> > command
> > usr/src/gcc/gcc-2.96-20000731/configure --target=ppc-linux
>
>You're heading for trouble anyway.  GCC  2.96  was  never
>officially
>released.  It  is a known fact that it cannot be used for
>instance to
>compile a Linux kernel. Even if you manage to build it, you will
>not
>have much fun using it.
>
>Wolfgang Denk
>
>--
>Software Engineering:  Embedded and Realtime Systems,  Embedded
>Linux
>Phone: (+49)-8142-4596-87  Fax: (+49)-8142-4596-88  Email:
>wd@denx.de
>Real programmers don't comment their code. It was hard to  write,
>it
>should be hard to understand.


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
