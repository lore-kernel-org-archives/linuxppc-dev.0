Subject: Re: Error:glibc-2.1.3 :Question about 'struct sigcontext'
To: icekim@sec.samsung.co.kr (kim sook young)
Date: Wed, 26 Apr 2000 13:27:23 +1000 (EST)
Cc: linuxppc-embedded@lists.linuxppc.org
In-Reply-To: <000d01bfaddd$eef56320$efc5dba8@sec.samsung.co.kr> from "kim sook young" at Apr 24, 2000 08:12:04 PM
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Message-Id: <20000426032723.1F3F93C95E@elph.research.canon.com.au>
From: greyham@research.canon.com.au (Graham Stoney)
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Hi Kim,

kim sook young writes:
> While compiling glibc-2.1.3 with gcc-2.95.2 , I met error like the following
> (as you know, I had already posted this error)
> ---------------------------------------------------------------
> ../sysdeps/unix/sysv/linux/i386/profil-counter.h: In function `profil_counter':
...
> the following is sigcontext.h
> -------------------------------------------------------------
> struct sigcontext {
>         unsigned short gs, __gsh;
>         unsigned short fs, __fsh;
>         unsigned short es, __esh;
>         unsigned short ds, __dsh;
>         unsigned long edi;
>         unsigned long esi;
>         unsigned long ebp;
>         unsigned long esp;
>         unsigned long ebx;
>         unsigned long edx;
>         unsigned long ecx;
>         unsigned long eax;
>         unsigned long trapno;
>         unsigned long err;
>         unsigned long eip;
>         unsigned short cs, __csh;
>         unsigned long eflags;
>         unsigned long esp_at_signal;
>         unsigned short ss, __ssh;
>         struct _fpstate * fpstate;
>         unsigned long oldmask;
>         unsigned long cr2;
> };

This is all i386 stuff. You said you were configuring glibc with
"--host=powerpc-linux" so it shouldn't be trying to use i386 headers during
the build. I suspect something is going wrong when you configure.

Regards,
Graham
--
Graham Stoney
Principal Hardware/Software Engineer
Canon Information Systems Research Australia
Ph: +61 2 9805 2909  Fax: +61 2 9805 2929

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
