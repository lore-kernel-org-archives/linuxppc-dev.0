Return-Path: <wd@denx.de>
Received: from mailout02.sul.t-online.com (mailout02.sul.t-online.com
	[194.25.134.17]) by ozlabs.org (Postfix) with ESMTP id E80FB67B6E
	for <linuxppc-embedded@ozlabs.org>;
	Wed,  6 Jul 2005 19:31:28 +1000 (EST)
To: Tom Rini <trini@kernel.crashing.org>
From: Wolfgang Denk <wd@denx.de>
Mime-version: 1.0
Content-type: text/plain; charset=ISO-8859-1
In-reply-to: Your message of "Tue, 05 Jul 2005 22:11:39 PDT."
	<20050706051139.GB8358@smtp.west.cox.net>
Date: Wed, 06 Jul 2005 11:12:00 +0200
Sender: wd@denx.de
Message-Id: <20050706091200.5E060353A6A@atlas.denx.de>
Cc: linuxppc-embedded@ozlabs.org
Subject: Re: 2.6.12-rc2 netconsole problem 
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

In message <20050706051139.GB8358@smtp.west.cox.net> you wrote:
>
> may want to look into a syslogd that does network.  I don't know how
> netconsole support in u-boot works, but it sounds like it's a network
> aware application that you can telnet into, rather than Linux's
> netconsole.

It's an implementation which is compatible with  (and  derived  from)
Linux'  netconsole,  but  with  an  added  input  channel so you have
interactive control over ethernet.

Best regards,

Wolfgang Denk

-- 
Software Engineering:  Embedded and Realtime Systems,  Embedded Linux
Phone: (+49)-8142-66989-10 Fax: (+49)-8142-66989-80 Email: wd@denx.de
You got to learn three things. What's  real,  what's  not  real,  and
what's the difference."           - Terry Pratchett, _Witches Abroad_
