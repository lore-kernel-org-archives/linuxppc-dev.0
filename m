To: "Dr. Craig Hollabaugh" <craig@hollabaugh.com>
Cc: linuxppc-embedded@lists.linuxppc.org
Subject: Re: MPC8xx fpu support and compiling glib. 
From: Wolfgang Denk <wd@denx.de>
Mime-version: 1.0
Content-type: text/plain; charset=ISO-8859-1
In-reply-to: Your message of "Fri, 12 Apr 2002 14:11:29 MDT."
             <3.0.3.32.20020412141129.0070c384@spudcentral.com>
Date: Fri, 12 Apr 2002 22:41:03 +0200
Message-Id: <20020412204108.D674A11258@denx.denx.de>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


In message <3.0.3.32.20020412141129.0070c384@spudcentral.com> you wrote:
>
> At 09:47 PM 4/12/2002 +0200, Wolfgang Denk wrote:
> >Also be awre the the  emulation  code  in  the  kernel  is  far  from
> >complete or perfect.
>
> Does this mean you recommend no emulation code in the kernel and ALL libraries and ALL applications be compiled with -msoft-float?

For FPU-less systems: yes.

Wolfgang Denk

--
Software Engineering:  Embedded and Realtime Systems,  Embedded Linux
Phone: (+49)-8142-4596-87  Fax: (+49)-8142-4596-88  Email: wd@denx.de
Every little picofarad has a nanohenry all its own.      - Don Vonada

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
