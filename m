Return-Path: <wd@denx.de>
Received: from mailout03.sul.t-online.com (mailout03.sul.t-online.com
	[194.25.134.81]) by ozlabs.org (Postfix) with ESMTP id 839862BDB5
	for <linuxppc-embedded@ozlabs.org>;
	Sat, 15 Jan 2005 03:08:01 +1100 (EST)
To: annamaya <annamaya@yahoo.com>
From: Wolfgang Denk <wd@denx.de>
Mime-version: 1.0
Content-type: text/plain; charset=ISO-8859-1
In-reply-to: Your message of "Fri, 14 Jan 2005 07:51:31 PST."
	<20050114155131.22836.qmail@web53809.mail.yahoo.com>
Date: Fri, 14 Jan 2005 17:07:38 +0100
Sender: wd@denx.de
Message-Id: <20050114160743.74903C108D@atlas.denx.de>
Cc: linuxppc-embedded@ozlabs.org
Subject: Re: ELDK on a PowerPC host machine? 
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

In message <20050114155131.22836.qmail@web53809.mail.yahoo.com> you wrote:
> I noticed that ELDK from denx does not support running
> on a PowerPC host machine like the Power G4 or G5.
> When I tried rebuilding it on a Power G4 with
> YellowDog installed on it, it complained that the
> PowerPC host machine is not supported. Why is this

Correct. PPC host are not supported yet. Also please  not  that  only
RedHat-7.3 will work as a build host without additional tweaking.

> host architecture not supported? I also found out that

Little demand? We have seen less than 5 requests for this so far.

> MontaVista does not support the PowerPC host
> architecture anymore which they did a while ago. What
> seems to be the real reason for not supporting this?

Probably the same reason: little demand.


Well: the ELDK is free software -  if  you  fix  the  existing  build
problems  and  send  me  a  patch I promise to check it in on the CVS
server (as long as it doesn't break anything). But don't expect  this
to be an easy job.

Best regards,

Wolfgang Denk

-- 
Software Engineering:  Embedded and Realtime Systems,  Embedded Linux
Phone: (+49)-8142-66989-10 Fax: (+49)-8142-66989-80 Email: wd@denx.de
If only God would give me some clear sign! Like making a large  depo-
sit in my name at a Swiss Bank.                         - Woody Allen
