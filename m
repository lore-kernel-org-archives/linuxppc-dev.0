Message-ID: <3B7AD632.2060601@brocade.com>
Date: Wed, 15 Aug 2001 13:06:10 -0700
From: Amit D Chaudhary <amitc@brocade.com>
MIME-Version: 1.0
To: Mark Pilon <mark.pilon@minolta-qms.com>
Cc: linuxppc-embedded@lists.linuxppc.org
Subject: Re: gcc 3.0 for PPC
References: <3B7ACCD7.BCC0D2AA@minolta-qms.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


I have not built 3.0, but built 2.95.2\3. The following might help. Do
keep us posted.

Use --with-headers and --with-libs to specify the header files and
libraries from the glibc you compiled or have.

Look at following to check all steps,
http://www.borg.umn.edu/~grant/Linux/cross.html

Amit

Mark Pilon wrote:
> if anyone is / has built gcc 3.0 for PPC I'd appreciate a word as
> to how you configured it.
>
> I built it configured:
> ./configure --host=i386-pc-linux-gnu --target=powerpc-linux
> --prefix=/home/mpilon/ppc_tools --with-newlib -enable-languages=c
>
> and got many warnings, mostly comparison between signed and unsigned ...
>
> and it finally dies compiling ./libgcc2.c -o libgcc/./_muldi3.o
> w/:
>
> In file included from tm.h:6,
>                  from config/rs6000/xm-sysv4.h:35,
>                  from tconfig.h:3,
>                  from libgcc2.c:36:
> config/rs6000/linux.h:81:20: signal.h: No such file or directory
> config/rs6000/linux.h:82:26: sys/ucontext.h: No such file or directory
> make[2]: *** [libgcc/./_muldi3.o] Error 1
> make[2]: Leaving directory `/home/mpilon/ppc_tools/gcc-3.0/gcc'
> make[1]: *** [stmp-multilib] Error 2
> make[1]: Leaving directory `/home/mpilon/ppc_tools/gcc-3.0/gcc'
> make: *** [all-gcc] Error 2
>
> thanks,
> Mark
>
>
>
>


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
