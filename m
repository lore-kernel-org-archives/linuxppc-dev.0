To: eric_mariacher@fr.ibm.com
Cc: linuxppc-embedded@lists.linuxppc.org
Subject: Re: Where can I find a glibc-2.1/sysdeps/unix/fork.S working for powerpc?
References: <C125685F.00384643.00@d07mta01.fr.ibm.com>
From: Marcus Sundberg <erammsu@kieraypc01.p.y.ki.era.ericsson.se>
Date: 10 Jan 2000 11:07:05 +0100
In-Reply-To: eric_mariacher@fr.ibm.com's message of "Fri, 7 Jan 2000 10:59:08 +0100"
Message-ID: <kfyg0w69r5i.fsf@kieraypc07.p.y.ki.era.ericsson.se>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


eric_mariacher@fr.ibm.com writes:

> Hi everybody,
> 
>      I am trying to get linux working on a board featuring a MPC860. I am
> currently following instructions given at
> http://members.home.com/mmporter/linux/cross/ to install a cross-compiler for
> powerpc on my PC. There seems to be fork.S files for every platform existing
> except for PowerPC.
> 
> Can anyone help me?

Hi,

Whatever problem you are trying to solve you are completely on the wrong
track. You have no reason to worry about the fork() implementation if you
are using glibc on Linux.

If you are having problems I suggest you start by upgrading to glibc 2.1.2,
and continue by reading:
http://lists.linuxppc.org/listarcs/linuxppc-embedded/199909/msg00000.html

//Marcus
-- 
Signature under construction, please come back later.

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
