To: Borracini Evandro-R45188 <Evandro.Borracini@motorola.com>
Cc: linuxppc-embedded@lists.linuxppc.org
Subject: Re: dynamically linked Init hanging 
From: Wolfgang Denk <wd@denx.de>
Mime-version: 1.0
Content-type: text/plain; charset=ISO-8859-1
In-reply-to: Your message of "Tue, 16 Oct 2001 16:59:44 -0300."
             <69AB2E42243FD511920200805FE64EAD0E3616@ZBR01EXM01>
Date: Tue, 16 Oct 2001 23:12:58 +0200
Message-Id: <20011016211303.BB67E10889@denx.denx.de>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


In message <69AB2E42243FD511920200805FE64EAD0E3616@ZBR01EXM01> you wrote:
>
> That means that I need to rebuild all my glibc and gcc for the MPC8xx, right ?

You need to rebuild all libraries and target applications for the 8xx
(patching glibc for the cache line size, forcing soft-float  for  all
libs  and  apps);  there is no need to rebuild a native PowerPC GCC -
but make sure you use the correct options when compiling 8xx files.

> And if I rebuild only the libraries of my /opt/target/lib directory
> and keep my hosts gcc/glibc configured for FPU and 32 cache line
> size. Do you think that I would be able to compile applications on
> host and run on target? I am asking that because I would like to have
> only one gcc/libc tools set on my host.

You will need a target version of the C library.

BTW: see also the Embedded PPC HOWTO.

Wolfgang Denk

--
Software Engineering:  Embedded and Realtime Systems,  Embedded Linux
Phone: (+49)-8142-4596-87  Fax: (+49)-8142-4596-88  Email: wd@denx.de
The use of Microsoft crippleware systems is a sin that  carries  with
it its own punishment.
         -- Tom Christiansen in <6bo3fr$pj8$5@csnews.cs.colorado.edu>

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
