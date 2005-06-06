Return-Path: <wd@denx.de>
Received: from mailout03.sul.t-online.com (mailout03.sul.t-online.com
	[194.25.134.81]) by ozlabs.org (Postfix) with ESMTP id 4FC91679FB
	for <linuxppc-embedded@ozlabs.org>;
	Mon,  6 Jun 2005 18:03:52 +1000 (EST)
To: Edward Hong <edward.qin.hong@gmail.com>
From: Wolfgang Denk <wd@denx.de>
Mime-version: 1.0
Content-type: text/plain; charset=ISO-8859-1
In-reply-to: Your message of "Sun, 05 Jun 2005 23:33:09 MDT."
	<21fb73bc050605223311af6408@mail.gmail.com>
Date: Mon, 06 Jun 2005 10:03:21 +0200
Sender: wd@denx.de
Message-Id: <20050606080326.0E6B0C1512@atlas.denx.de>
Cc: linuxppc-embedded@ozlabs.org
Subject: Re: kernel ported from ELDK 3.0 hangs (loops in idled()) on my
	custom MPC870 Board
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

In message <21fb73bc050605223311af6408@mail.gmail.com> you wrote:
>
> I have a BDI2000. But I am not sure how to further debug in my
> situation since I know the kernel execution was looping inside
> idled().

Set a breakpoint earlier in the code and single step?

Best regards,

Wolfgang Denk

-- 
Software Engineering:  Embedded and Realtime Systems,  Embedded Linux
Phone: (+49)-8142-66989-10 Fax: (+49)-8142-66989-80 Email: wd@denx.de
The C-shell doesn't parse. It adhoculates.
    - Casper.Dik@Holland.Sun.COM in <3ol96k$b2j@engnews2.Eng.Sun.COM>
