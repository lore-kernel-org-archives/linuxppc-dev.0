Return-Path: <wd@denx.de>
Received: from mailout07.sul.t-online.com (mailout07.sul.t-online.com
	[194.25.134.83]) by ozlabs.org (Postfix) with ESMTP id F293667A46
	for <linuxppc-embedded@ozlabs.org>;
	Sat,  5 Feb 2005 06:21:26 +1100 (EST)
To: "Linas Petras" <lpetras@netspace.net.au>
From: Wolfgang Denk <wd@denx.de>
Mime-version: 1.0
Content-type: text/plain; charset=ISO-8859-1
In-reply-to: Your message of "Sat, 05 Feb 2005 04:13:01 +1100."
	<000001c50adc$c814dae0$6401a8c0@supernova>
Date: Fri, 04 Feb 2005 20:21:12 +0100
Sender: wd@denx.de
Message-Id: <20050204192117.4F29CC108D@atlas.denx.de>
Cc: linuxppc-embedded@ozlabs.org
Subject: Re: Problems with Serial Port on IceCube 
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Dear Linas,

in message <000001c50adc$c814dae0$6401a8c0@supernova> you wrote:
> 
> Any ideas of whats going on ????? Is their a problem with the console support in 
> Sylvain's port or something in the "standard" init scripts that come with DENX's ELDK 
> 3.1 when used with a 2.6.xx kernel or have I missed something obvious?

There is nothing in the init scripts that should matter here.

Just out of curiousity: can you try another console cable? Probably a
minimal one (only 3 wires: GND + RxD + TxD) ?

Best regards,

Wolfgang Denk

-- 
Software Engineering:  Embedded and Realtime Systems,  Embedded Linux
Phone: (+49)-8142-66989-10 Fax: (+49)-8142-66989-80 Email: wd@denx.de
"There are things that are so serious that you can  only  joke  about
them"                                                    - Heisenberg
