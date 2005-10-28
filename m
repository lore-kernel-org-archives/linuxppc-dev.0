Return-Path: <wd@denx.de>
Received: from mailout09.sul.t-online.com (mailout09.sul.t-online.com
	[194.25.134.84]) by ozlabs.org (Postfix) with ESMTP id 53C7D685CF
	for <linuxppc-embedded@ozlabs.org>;
	Sat, 29 Oct 2005 06:51:29 +1000 (EST)
To: Jeff Stevens <jsteve17@yahoo.com>
From: Wolfgang Denk <wd@denx.de>
Mime-version: 1.0
Content-type: text/plain; charset=ISO-8859-1
In-reply-to: Your message of "Fri, 28 Oct 2005 08:55:09 PDT."
	<20051028155510.17662.qmail@web33413.mail.mud.yahoo.com>
Date: Fri, 28 Oct 2005 22:51:24 +0200
Sender: wd@denx.de
Message-Id: <20051028205124.17147353E3E@atlas.denx.de>
Cc: linuxppc-embedded@ozlabs.org
Subject: Re: Howto Cross Compile GCC to run on PPC Platform 
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

In message <20051028155510.17662.qmail@web33413.mail.mud.yahoo.com> you wrote:
>    I am trying to compile GCC on an x86 platform to
> run natively on an embedded PPC platform.  I am able
> to compile gcc as a cross compiler (to run on x86),
> but can't seem to get it to cross compile gcc (to run
> on ppc).  Does anyone know of a good HowTo to do this?
>  I'm currently downloading the source distro of ELDK,
> so if it's already in there I'll find it, but if there

It is.

> is one elsewhere online please let me know.

Note that released versions of the ELDK (up  to  and  including  ELDK
3.1.1)  require  a  RedHat-7.3  build  host. Don't waste your time on
trying later Linux distros ;-)

Current top-of-tree in CVS should build under Fedora Core 4; but this
code has not been released yet - it is beta quality only.

Best regards,

Wolfgang Denk

-- 
Software Engineering:  Embedded and Realtime Systems,  Embedded Linux
Phone: (+49)-8142-66989-10 Fax: (+49)-8142-66989-80 Email: wd@denx.de
"Any excuse will serve a tyrant."                             - Aesop
