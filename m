Return-Path: <wd@denx.de>
Received: from mailout08.sul.t-online.com (mailout08.sul.t-online.com
	[194.25.134.20]) by ozlabs.org (Postfix) with ESMTP id 7B68867DB7
	for <linuxppc-embedded@ozlabs.org>;
	Fri, 29 Jul 2005 09:08:59 +1000 (EST)
To: Igor Marnat <marny@rambler.ru>
From: Wolfgang Denk <wd@denx.de>
Mime-version: 1.0
Content-type: text/plain; charset=ISO-8859-1
In-reply-to: Your message of "Thu, 28 Jul 2005 20:18:17 +0400."
	<200507282018.17849.marny@rambler.ru>
Date: Fri, 29 Jul 2005 01:08:53 +0200
Sender: wd@denx.de
Message-Id: <20050728230853.B4C29352675@atlas.denx.de>
Cc: linuxppc-embedded@ozlabs.org
Subject: Re: eth1 on linux 2.4.25 from ELDK 3.1.1 becomes slowly when is
	pinged by great packets
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

In message <200507282018.17849.marny@rambler.ru> you wrote:
>
> Wolfgang, thank you! 

You are welcome.

> I've renewed the kernel from CVS and it works much better now. 

Fine.

> By the way, the driver for PPChameleonEVB is presented in linuxppc_2_4_devel 
> module only and is not presented in linux-2.4 module of CVS (there miss the

Yes, this is intentional. The linux-2.4 module  is  a  more  or  less
frozen  version  of  linux  kernel  version 2.4.4 which we keep alife
because some of our customers continue to use this in their projects.

Best regards,

Wolfgang Denk

-- 
Software Engineering:  Embedded and Realtime Systems,  Embedded Linux
Phone: (+49)-8142-66989-10 Fax: (+49)-8142-66989-80 Email: wd@denx.de
"In Christianity neither morality nor religion come into contact with
reality at any point."                          - Friedrich Nietzsche
