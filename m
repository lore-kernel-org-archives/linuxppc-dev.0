To: Conn Clark <clark@esteem.com>
Cc: May Ling List <linuxppc-embedded@lists.linuxppc.org>
Subject: Re: MPC8xx fpu support and compiling glib. 
From: Wolfgang Denk <wd@denx.de>
Mime-version: 1.0
Content-type: text/plain; charset=ISO-8859-1
In-reply-to: Your message of "Fri, 12 Apr 2002 10:11:00 PDT."
             <3CB71524.46DC9F87@esteem.com>
Date: Fri, 12 Apr 2002 21:47:18 +0200
Message-Id: <20020412194723.7EACA11258@denx.denx.de>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


In message <3CB71524.46DC9F87@esteem.com> you wrote:
>
> > You cannot mix FPU-code and  soft-float  in  one  application/library
> > setup.
...
> If my kernel has fpu-emulation, do I need to compile soft-float into my
> glibc?

You can compile either ALL libraries and ALL  applications  with,  or
ALL without FP.

> Does putting fpu-emulation in the kernel and not using soft-float in
> glibc
> save me RAM?

Not any significant amount, I think.

Also be awre the the  emulation  code  in  the  kernel  is  far  from
complete or perfect.

Wolfgang Denk

--
Software Engineering:  Embedded and Realtime Systems,  Embedded Linux
Phone: (+49)-8142-4596-87  Fax: (+49)-8142-4596-88  Email: wd@denx.de
The IQ of the group is the lowest IQ of a member of the group divided
by the number of people in the group.

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
