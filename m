Message-ID: <19990921124008.23835.rocketmail@web601.yahoomail.com>
Date: Tue, 21 Sep 1999 14:40:08 +0200 (CEST)
From: sébastien tadéoni <sebastien_tadeoni@yahoo.fr>
Subject: Re: Cross compilation for MPC860
To: linux ppc embedded <linuxppc-embedded@lists.linuxppc.org>,
        Graham Stoney <greyham@research.canon.com.au>,
        Scott Wood <scott@broadlink.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>



Hi Graham, Hi Scott;

Thanks for your help for cross compiling.

> Any particular reason for using old versions        
> of binutils & egcs?

> My suggestion is that if you're just starting out,  
 > now is the best time to make sure you're using the 
 > latest gcc (2.95.1) and binutils. You have to make
a > tiny mod to the gcc specs file if you use binutils
  > 2.9.1, because the name of the linker emulation
has  > changed since the last binutils release. I'm   
     > currently using the binutils-990809 snapshot.
Haven't > actually run any code it produces yet
though.

I have pgcc-2.91.66 (egcs-1.1.2 release) and I founded
a gcc-2.95 tar file but I have problem with the
./configure command (system can't find any sources in
. or ..).
I see you work on a pentium station and I would have
known how you have configured your machine.
Where can I find the last binutils and gcc release and
how install them (is there specifics command other
than --target=powerpc-linux and --with-newlib)?
Which modif must I make in the spec files?

Graham Stoney wrote:
...
> *** drivers/macintosh/Makefile.dist     Tue Aug 10 >
16:07:44 1999
> --- drivers/macintosh/Makefile  Tue Aug 10 16:25:03
> 1999
> ***************
> *** 15,21 ****
>   L_TARGET := macintosh.a
>   M_OBJS   :=
>   
> ! ifndef CONFIG_MBX
>  L_OBJS   := via-cuda.o macio-adb.o via-pmu.o >
mediabay.o
>  LX_OBJS  := adb.o
>  endif
> --- 15,21 ----
>  L_TARGET := macintosh.a
>  M_OBJS   :=
  
> ! ifdef CONFIG_PMAC
>  L_OBJS   := via-cuda.o macio-adb.o via-pmu.o >
mediabay.o
>  LX_OBJS  := adb.o
>  endif

and Scott Wood wrote:

> Note that the 2.2.5-embedded kernel compiles in ADB 
> support whether you configured for it or not
(correct > me if I'm wrong, but that has been my
experience so
> far), so I commented out L_OBJS and LX_OBJS in >
drivers/macintosh/Makefile and it builds without ADB.

I don't realy understand which role play this makefile
and what is ADB?

Thanks in advance for your help.
Good Day
Sébastien


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
