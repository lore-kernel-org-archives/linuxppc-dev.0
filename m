Return-Path: <wd@denx.de>
Received: from mailout01.sul.t-online.com (mailout01.sul.t-online.com
	[194.25.134.80]) by ozlabs.org (Postfix) with ESMTP id E3A8167EB8
	for <linuxppc-embedded@ozlabs.org>;
	Mon, 15 Aug 2005 19:15:43 +1000 (EST)
To: =?UTF-8?Q?=E5=BE=90=E5=B0=8F?= =?UTF-8?Q?=E5=A8=81?= <rober@opnet.com.tw>
From: Wolfgang Denk <wd@denx.de>
Mime-version: 1.0
Content-type: text/plain; charset=ISO-8859-1
In-reply-to: Your message of "Mon, 15 Aug 2005 16:22:33 +0800."
	<1124094153.13556.3.camel@banana>
Date: Mon, 15 Aug 2005 11:15:18 +0200
Sender: wd@denx.de
Message-Id: <20050815091518.C3339352B73@atlas.denx.de>
Cc: linuxppc-embedded@ozlabs.org
Subject: Re: how to run iptables-1.2.9 at Kernel 2.4.25 
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

In message <1124094153.13556.3.camel@banana> you wrote:
> 
>     I got some problem at compiler iptables 1.2.9 at my 2.4.25 Linux,
> anybody know how to solve it?

Please provide a correct subject. It seems your problem is  not  with
running but with building iptables, right?

> PS:I used eldk 3.1.1 and 2.4.25 kernel at my custom MPC852T board.
> 
> extensions/libipt_ULOG.c: In function `init':
> extensions/libipt_ULOG.c:58: error: `NFLOG_DEFAULT_NLGROUP' undeclared
...
> extensions/libipt_ULOG.c:59: error: `NFLOG_DEFAULT_QTHRESHOLD'
...

Seems you misconfigured it. Check your Makefiles.

Best regards,

Wolfgang Denk

-- 
Software Engineering:  Embedded and Realtime Systems,  Embedded Linux
Phone: (+49)-8142-66989-10 Fax: (+49)-8142-66989-80 Email: wd@denx.de
To program is to be.
