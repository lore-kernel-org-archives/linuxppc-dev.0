Return-Path: <wd@denx.de>
Received: from mailout10.sul.t-online.com (mailout10.sul.t-online.com
	[194.25.134.21]) by ozlabs.org (Postfix) with ESMTP id 9B5B268351
	for <linuxppc-embedded@ozlabs.org>;
	Tue, 20 Sep 2005 05:55:09 +1000 (EST)
To: shawnxjin@gmail.com
From: Wolfgang Denk <wd@denx.de>
Mime-version: 1.0
Content-type: text/plain; charset=ISO-8859-1
In-reply-to: Your message of "Mon, 19 Sep 2005 11:40:05 PDT."
	<c3d0340b050919114040d0a0fe@mail.gmail.com>
Date: Mon, 19 Sep 2005 21:29:15 +0200
Sender: wd@denx.de
Message-Id: <20050919192915.B482E353BF3@atlas.denx.de>
Cc: linuxppc-embedded@ozlabs.org
Subject: Re: Which way to store log in flash on mpc8xx? 
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

In message <c3d0340b050919114040d0a0fe@mail.gmail.com> you wrote:
>
> What's the trouble caused by log files when using a JFFS2? I'm not
> aware of that. Any pointers to where I should look into are much
> appreciated.

Please see the linux-mtd web site and/or MTD  mailing  list  archives
for  details.  JFFS2 works excellent with files that are written once
(or with only a few write() calls. Logfiles typically  grow  forever,
by  many,  many  small  chunks  of  data  appended  in  many  write()
operations - this is kind of killer application for JFFS2.

Best regards,

Wolfgang Denk

-- 
Software Engineering:  Embedded and Realtime Systems,  Embedded Linux
Phone: (+49)-8142-66989-10 Fax: (+49)-8142-66989-80 Email: wd@denx.de
"I find this a nice feature but it is not according to  the  documen-
tation. Or is it a BUG?"   "Let's call it an accidental feature. :-)"
                       - Larry Wall in <6909@jpl-devvax.JPL.NASA.GOV>
