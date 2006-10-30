Return-Path: <jmwoo2@yahoo.com>
Received: from web50313.mail.yahoo.com (web50313.mail.yahoo.com
	[206.190.39.215]) by ozlabs.org (Postfix) with SMTP id 34B0567C1E
	for <linuxppc-embedded@ozlabs.org>;
	Mon, 30 Oct 2006 14:38:48 +1100 (EST)
Message-ID: <20061030033846.1930.qmail@web50313.mail.yahoo.com>
Date: Sun, 29 Oct 2006 19:38:46 -0800 (PST)
From: John W <jmwoo2@yahoo.com>
Subject: Re: Building ELDK 3.0/3.1 from SRPMS 
To: Wolfgang Denk <wd@denx.de>
In-Reply-To: <20061027211942.B7FEB3535FD@atlas.denx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Cc: linuxppc-embedded@ozlabs.org
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Thanks Wolfgang!  Loading RH7.3 and updating
everything with YUM seemed to do the trick to building
ELDK 3.0!

On a another note, I am also trying to build ELDK
2.1.0 from SRPMS on the same RH7.3 machine, and I am
comming across two problems:
1.  The SRPM for mount-2.11g-5a.src.rpm from the
Yellowdog 2.3 release seems to have "bad magic" in
that when trying to install the SRPM, there is some
sort of validation problem.  In remeding this, I am
using mount-2.11g-5a.src.rpm from the Yellowdog 2.2
release.    It probably isn't safe to to so, but I was
wondering how you over came this issue.

2.  I'm pretty sure that not all of my applications
are building in the ELDK2.1.0 release,  for example
when I check out the log for
/build/ppc-2006-10-27/logs/ppc_4xx/build_modutils.log,
it has the following error:
gperf -a -C -E -g -H is_reserved_hash -k 1,3,$ -N
is_reserved_word -p -t keyword
s.gperf > keywords.c.tmp
/bin/sh: gperf: command not found
make[1]: *** [keywords.c] Error 127
make[1]: Leaving directory
`/opt/eldkv2.1.0/build/ppc-2006-10-27/work/usr/src/de
nx/BUILD/modutils-2.4.13/genksyms'
make: *** [all] Error 2
error: Bad exit status from
/opt/eldkv2.1.0/build/ppc-2006-10-27/work/var/tmp/rp
m-tmp.26616 (%build)

Does mean that I need to go get gperf?

Thanks for the help!

John Woo


--- Wolfgang Denk <wd@denx.de> wrote:

> Dear John,
> 
> in message
> <20061027182114.24662.qmail@web50315.mail.yahoo.com>
> you wrote:
> > 
> > I having trouble rebuilding ELDK 3.0 & ELDK 3.1
> from
> > the source RPMS.  I have spent a great deal of
> time on
> > this, and I have a feeling that maybe I=92m just
> not
> > doing something correctly (setting up the build
> > environment, retrieving source/specs from CVS..
> > etc..).  My build machine is Red Hat 9.0 without
> any
> > updates (Kernel 2.4.20-8, the Shrike release).
> 
> This will not work; to build ELDK 3.x from scratch
> you need a  RH-7.3
> box *with* all updates installed.
> 
> Best regards,
> 
> Wolfgang Denk
> 
> -- 
> Software Engineering:  Embedded and Realtime
> Systems,  Embedded Linux
> Phone: (+49)-8142-66989-10 Fax: (+49)-8142-66989-80
> Email: wd@denx.de
> e-credibility: the non-guaranteeable likelihood that
>  the  electronic
> data you're seeing is genuine rather than somebody's
> made-up crap.
> - Karl Lehenbauer
> 



 
____________________________________________________________________________________
Get your email and see which of your friends are online - Right on the New Yahoo.com 
(http://www.yahoo.com/preview) 
