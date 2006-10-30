Return-Path: <wd@denx.de>
Received: from mail-out.m-online.net (mail-out.m-online.net [212.18.0.9])
	by ozlabs.org (Postfix) with ESMTP id 95C7067EB1
	for <linuxppc-embedded@ozlabs.org>;
	Tue, 31 Oct 2006 10:53:17 +1100 (EST)
To: John W <jmwoo2@yahoo.com>
From: Wolfgang Denk <wd@denx.de>
Subject: Re: Building ELDK 3.0/3.1 from SRPMS 
Mime-version: 1.0
Content-type: text/plain; charset=ISO-8859-1
In-reply-to: Your message of "Sun, 29 Oct 2006 19:38:46 PST."
	<20061030033846.1930.qmail@web50313.mail.yahoo.com>
Date: Tue, 31 Oct 2006 00:53:15 +0100
Sender: wd@denx.de
Message-Id: <20061030235315.7BC2B352658@atlas.denx.de>
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

Dear John,

in message <20061030033846.1930.qmail@web50313.mail.yahoo.com> you wrote:
> Thanks Wolfgang!  Loading RH7.3 and updating
> everything with YUM seemed to do the trick to building
> ELDK 3.0!

Out of curiosity: may I ask why you invest efforts in this old
version?

> On a another note, I am also trying to build ELDK
> 2.1.0 from SRPMS on the same RH7.3 machine, and I am
> comming across two problems:
> 1.  The SRPM for mount-2.11g-5a.src.rpm from the
> Yellowdog 2.3 release seems to have "bad magic" in
> that when trying to install the SRPM, there is some
> sort of validation problem.  In remeding this, I am
> using mount-2.11g-5a.src.rpm from the Yellowdog 2.2
> release.    It probably isn't safe to to so, but I was
> wondering how you over came this issue.

Exactly the same way you did :-)

> 2.  I'm pretty sure that not all of my applications
> are building in the ELDK2.1.0 release,  for example
...
> /bin/sh: gperf: command not found
> make[1]: *** [keywords.c] Error 127
> make[1]: Leaving directory
> `/opt/eldkv2.1.0/build/ppc-2006-10-27/work/usr/src/de
> nx/BUILD/modutils-2.4.13/genksyms'
> make: *** [all] Error 2
> error: Bad exit status from
> /opt/eldkv2.1.0/build/ppc-2006-10-27/work/var/tmp/rp
> m-tmp.26616 (%build)
> 
> Does mean that I need to go get gperf?

Sorry, I don't have these old logs online any more. Please drop me  a
note if you really want to see these, so I can restore the files from
tape.

Best regards,

Wolfgang Denk

-- 
Software Engineering:  Embedded and Realtime Systems,  Embedded Linux
Phone: (+49)-8142-66989-10 Fax: (+49)-8142-66989-80 Email: wd@denx.de
How many Unix hacks does it take to change a light bulb?  Let's  see,
   can you use a shell script for that or does it need a C program?
