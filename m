Return-Path: <wd@denx.de>
Received: from mailout05.sul.t-online.com (mailout05.sul.t-online.com
	[194.25.134.82]) by ozlabs.org (Postfix) with ESMTP id E25722BEA0
	for <linuxppc-embedded@ozlabs.org>;
	Fri, 26 Nov 2004 10:58:49 +1100 (EST)
To: ivica@asist-traffic.com
From: Wolfgang Denk <wd@denx.de>
Mime-version: 1.0
Content-type: text/plain; charset=ISO-8859-1
In-reply-to: Your message of "Thu, 25 Nov 2004 16:24:32 +0100."
	<41A5F930.3080104@asist-traffic.com>
Date: Thu, 25 Nov 2004 23:58:05 +0100
Sender: wd@denx.de
Message-Id: <20041125225810.A5B02C1430@atlas.denx.de>
Cc: linuxppc-embedded@ozlabs.org
Subject: Re: MPC5200 toolchain test 
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Dear Ivica,

in message <41A5F930.3080104@asist-traffic.com> you wrote:
> 
> I have a MPC5200 based custom board with preloaded u-boot.
> My job is to create some sort of development environment, build
> linux kernel and userland environment and in the end test the hardware
> before larger series are built.

May I ask why you want to start from scratch? Is it  for  educational
purposes?  Otherwise  you  could  just  use  existing and well-tested
toolchains  like  our  ELDK   which   isavailable   for   free   (see
http://www.denx.de/ELDK.html);  of course you can also use the ELDK's
build environment to rebuild everything from scratch  if  you  really
want  to  be  sure  that you can recompile everything without need to
rely on any external resources.

> So far I managed to create GNU toolchain for it with crostool from
> Dan Kegel. Everything was built without any problems. Of course,
> I wanted to test this toolchain so I wanted to compile a simple
> hello_world program load it into the memory of my MPC5200 board
> and run it. So far I've failed. I admit. I don't know how to compile
> a program to run without the OS. But I have some clues. I think it

There is some pretty extensive documentation in our DULG about how to
use U-Boot and Linux in Embedded systems; have a look at
http://www.denx.de/twiki/bin/view/DULG/Manual

> Anyhow I want to do this before I compile kernel. Since I'm talking
> about the kernel let me ask you what kernel you suggest for MPC5200?
> The latest 2.6.10-rc or the one Sylvain Munaut is maintaining?

Alternatively, you could  use  the  stable  2.4.25  kernel  from  the
linuxppc_2_4_devel tree on our CVS server; for details see the DULG.

> Next ... I would like to create a development environment that is totally
> "closed" from my system and I want all the crosstools in it. This way
> I could ensure none of my native tools are conflicting with cross 
> development.

The ELDK installs all files and tools in  a  single  directory.  This
should  be  an  excellent  base  for  crating a sandboxed environment
(although I have to admit that I don't understand which benefits this
might give you).


Best regards,

Wolfgang Denk

-- 
Software Engineering:  Embedded and Realtime Systems,  Embedded Linux
Phone: (+49)-8142-66989-10 Fax: (+49)-8142-66989-80 Email: wd@denx.de
There is a biblical analogy I'd like to draw here.   Casts are to C++
Programmers what the apple was to Eve.         - Scott Douglas Meyers
