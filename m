Message-Id: <v03110700b52c8481fb7e@[209.183.131.177]>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Date: Wed, 26 Apr 2000 07:41:41 -0400
To: <ambrosini@lightning.ch>
From: "Kevin B. Hendricks" <khendricks@ivey.uwo.ca>
Subject: Re: patch: POSIX.1b signals for ppc
Cc: cort@fsmlabs.com, paulus@linuxcare.com, linuxppc-dev@lists.linuxppc.org
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Hi Giovanna,

Thankyou!
I found your POSIX.1b signals patch for ppc that adds in sys_rt_sigreturn
and allows for signal handlers to get all 3 parameters (signo,siginfo, and
uc).

This patch is very important for the proper functioning of both green and
native threads of the JDK 1.3 that Blackdown is currently working on. (try
debugging code that uses SA_SIGINFO and ucontext as one of the
parameters...it will compile on powerpc with glibc 2.1.3 but the other
parameters passed to the signal handlers are just garbage which makes
debugging fun!).

Do you know its status?

Does it work on other ppc platforms outside of the ppc850?

Was it ever incorporated in part or whole into either Paul or Cort's
kernels (stable or development)?

If not, what if anything needs to be done to get the functionality of the
patch added into the ppc linux kernels?

If more work needs to be done to get this in the ppc kernels, please let me
know and I will try to help.

Thanks,

Kevin


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
