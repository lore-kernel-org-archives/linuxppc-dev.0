Return-Path: <wd@denx.de>
Received: from mailout11.sul.t-online.com (mailout11.sul.t-online.com
	[194.25.134.85]) by ozlabs.org (Postfix) with ESMTP id 6699D2BEA0
	for <linuxppc-embedded@ozlabs.org>;
	Sat, 27 Nov 2004 05:24:36 +1100 (EST)
To: ivica@asist-traffic.com
From: Wolfgang Denk <wd@denx.de>
Mime-version: 1.0
Content-type: text/plain; charset=ISO-8859-1
In-reply-to: Your message of "Fri, 26 Nov 2004 11:48:01 +0100."
	<41A709E1.4050608@asist-traffic.com>
Date: Fri, 26 Nov 2004 15:36:56 +0100
Sender: wd@denx.de
Message-Id: <20041126143701.98123C1430@atlas.denx.de>
Cc: linuxppc-embedded@ozlabs.org
Subject: Re: MPC5200 toolchain test 
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Dear Ivica,

in message <41A709E1.4050608@asist-traffic.com> you wrote:
> 
> Educational reasons were my primary motives besides the independence 
> factor. :-)

OK, understood and accepted (that was  the  starting  point  for  the
ELDK, too :-)

> I will have a certain budget to spend.What tools should I use? BDI2000? 
> Any alternatives,
> or is this simply superior tool for debugging purposes?

It is. IMHO the BDI2000 is the de-facto standard tool  for  low-level
Linux debugging.

> >There is some pretty extensive documentation in our DULG about how to
...
> Yes I know of it. It doesn't describe though the process of compiling 
> and linking standalone
> applications to run without OS.

Ummm.. there is. See http://www.denx.de/twiki/bin/view/DULG/UBootStandalone

[I hope you don't call "U-Boot" an OS ;-) ]

Best regards,

Wolfgang Denk

-- 
Software Engineering:  Embedded and Realtime Systems,  Embedded Linux
Phone: (+49)-8142-66989-10 Fax: (+49)-8142-66989-80 Email: wd@denx.de
Commitment, n.:      Commitment can be illustrated by a breakfast
of ham and eggs. The chicken was involved, the pig was committed.
