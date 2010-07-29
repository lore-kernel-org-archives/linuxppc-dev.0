Return-Path: <glppd-linuxppc64-dev@m.gmane.org>
Received: from lo.gmane.org (lo.gmane.org [80.91.229.12])
	by ozlabs.org (Postfix) with ESMTP id B1439B70C2
	for <linuxppc-dev@ozlabs.org>; Thu, 29 Jul 2010 21:55:30 +1000 (EST)
Received: from list by lo.gmane.org with local (Exim 4.69)
	(envelope-from <glppd-linuxppc64-dev@m.gmane.org>)
	id 1OeRhv-0000oV-89
	for linuxppc-dev@ozlabs.org; Thu, 29 Jul 2010 13:55:27 +0200
Received: from p4ff06573.dip.t-dialin.net ([79.240.101.115])
	by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
	id 1AlnuQ-0007hv-00
	for <linuxppc-dev@ozlabs.org>; Thu, 29 Jul 2010 13:55:27 +0200
Received: from dzu by p4ff06573.dip.t-dialin.net with local (Gmexim 0.1
	(Debian)) id 1AlnuQ-0007hv-00
	for <linuxppc-dev@ozlabs.org>; Thu, 29 Jul 2010 13:55:27 +0200
To: linuxppc-dev@ozlabs.org
From: Detlev Zundel <dzu@denx.de>
Subject: Re: Problems using UART on MPC5200
Date: Thu, 29 Jul 2010 13:55:18 +0200
Message-ID: <m2bp9qfqop.fsf@ohwell.denx.de>
References: <59976.84.175.96.30.1280309170.squirrel__2764.8760042668$1280309549$gmane$org@batzer-biz.prossl.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi Sven,

> I am using a PowerPC MPC5200 from Freescale (with STK5200-Board), ELDK 4.2
> from DENX and the Kernel 2.6.34-rc5.
>
> My Kernel is running fine. The console output is coming over the device
> ttyPSC0.
>
> In future I want to login over telnet. So I deactivated the Kerneloption
> to output the console over the UART device.

It would help if you were more precise in describing what you did and
what you try to achieve.  What exact option did you change?

> Now I want to read and write to the RS232 interface from a program.
> But when I try to open the device ttyPSC* I get the following error:
> "unable to read portsettings : Inappropriate ioctl for device"

The message means what it says - whatever device driver is connected to
the device file you open does not support the ioctl you call on it.
Now to better understand this, it would help if you tell us what device
file you open, what major and minor number this has, what /proc/devices
shows this hooks to and what ioctl you do in your application.

> What does this mean ? How can I send and receive Data from/to the UART ?

This should all work with standard procedures.

Cheers
  Detlev

--
DENX Software Engineering GmbH,      MD: Wolfgang Denk & Detlev Zundel
HRB 165235 Munich,  Office: Kirchenstr.5, D-82194 Groebenzell, Germany
Phone: (+49)-8142-66989-40 Fax: (+49)-8142-66989-80 Email: dzu@denx.de
