To: Steven Scholz <steven.scholz@imc-berlin.de>
Cc: linuxppc-embedded@lists.linuxppc.org
Subject: Re: DENX ELDK Kernel 
From: Wolfgang Denk <wd@denx.de>
Mime-version: 1.0
Content-type: text/plain; charset=ISO-8859-1
In-reply-to: Your message of "Tue, 15 Jul 2003 16:01:12 +0200."
             <3F140928.60403@imc-berlin.de>
Date: Tue, 15 Jul 2003 16:16:03 +0200
Message-Id: <20030715141608.A765AC6D82@atlas.denx.de>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


In message <3F140928.60403@imc-berlin.de> you wrote:
>
> If I'd built the ELDK from scratch and used Linux-2.4.20 include files
> to build "glibc (and all the rest of the target ELDK apps)" I should
> build my "applications against the newer Linux kernel"! Shouldn't I?

Yes.

> And in general: shouldn't I used a glibc that "matches" the kernel
> version?

If you want to be absolutely safe, yes. But so far we have  not  seen
any  real  problems when - for example - running the 2.4.4 built libs
and tools on a 2.4.20+ kernel.

Best regards,

Wolfgang Denk

--
Software Engineering:  Embedded and Realtime Systems,  Embedded Linux
Phone: (+49)-8142-4596-87  Fax: (+49)-8142-4596-88  Email: wd@denx.de
God may be subtle, but He isn't plain mean.         - Albert Einstein

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
