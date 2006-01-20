Return-Path: <atul.sabharwal@exgate.tek.com>
Received: from igate.tek.com (igate.tek.com [192.65.41.20])
	by ozlabs.org (Postfix) with ESMTP id F0CFF689F9
	for <linuxppc-embedded@ozlabs.org>;
	Sat, 21 Jan 2006 08:13:03 +1100 (EST)
Received: from tektronix.tek.com (tektronix.tek.com [128.181.6.43])
	by igate.tek.com (8.12.10+Sun/8.12.10) with ESMTP id k0KLD2tT001014
	for <linuxppc-embedded@ozlabs.org>;
	Fri, 20 Jan 2006 13:13:02 -0800 (PST)
Received: from us-bv-u16.global.tektronix.net (us-bv-u16.bv.tek.com
	[128.181.2.45])
	by tektronix.tek.com (8.12.10+Sun/8.12.10) with SMTP id k0KLD1SA002696
	for <linuxppc-embedded@ozlabs.org>;
	Fri, 20 Jan 2006 13:13:02 -0800 (PST)
MIME-Version: 1.0
Content-Type: text/plain;
	charset="US-ASCII"
Subject: RE: u-boot debugging 
Date: Fri, 20 Jan 2006 13:13:41 -0800
Message-ID: <4A062D477D842B4C8FC48EA5AF2D41F201AC2CF4@us-bv-m23.global.tektronix.net>
From: <atul.sabharwal@exgate.tek.com>
To: <wd@denx.de>
Cc: linuxppc-embedded@ozlabs.org
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

First learn to communicate in English. I can give you 25 Us cents as I
cannot afford 1 Mark. You are not work even a Mark.

On a public network where there is lots of multicast/broadcast network,
10Mbps network would not scale.  Only on a isolated network with a
switch
It would work. If people are using a 100Mbps hub, the entire hub will
get
Scaled down to 10Mbps speed.

So, now mail me a Mark:)

~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
Atul Sabharwal
c/o Azad. Inc.
503-962-9395
=20
P.S:  Our destiny is in our hands... And yes, necessity is mother of
invention!!
-----Original Message-----
From: wd@denx.de [mailto:wd@denx.de]=20
Sent: Friday, January 20, 2006 11:48 AM
To: Sabharwal, Atul
Cc: mustafa.cayir@bte.mam.gov.tr; linuxppc-embedded@ozlabs.org
Subject: Re: u-boot debugging=20

In message
<4A062D477D842B4C8FC48EA5AF2D41F201AC2CC8@us-bv-m23.global.tektronix.net
> you wrote:
>
> Besides, the BDI has only a 10Mbps Ethernet interface.  It might be
> enough for simple debug operation but they should
> Have put a 100Mbps link to put it on a shared network.  For an
isolated
> network configuration, it should suffice...

You should really get a clue. Or can you please explain what  is  the
maximum  transfer rate you can get over the BDM / JTAG interface, and
how is this limited by the 10Mbps Ethernet interface?


Best regards,

Wolfgang Denk

--=20
Software Engineering:  Embedded and Realtime Systems,  Embedded Linux
Phone: (+49)-8142-66989-10 Fax: (+49)-8142-66989-80 Email: wd@denx.de
Of all the things I've lost, I miss my mind the most.
