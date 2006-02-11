Return-Path: <atul.sabharwal@exgate.tek.com>
Received: from igate.tek.com (igate.tek.com [192.65.41.20])
	by ozlabs.org (Postfix) with ESMTP id C18F867B74
	for <linuxppc-embedded@ozlabs.org>;
	Sat, 11 Feb 2006 13:02:52 +1100 (EST)
Received: from tektronix.tek.com (tektronix.tek.com [128.181.6.43])
	by igate.tek.com (8.12.10+Sun/8.12.10) with ESMTP id k1B22ptT014316
	for <linuxppc-embedded@ozlabs.org>;
	Fri, 10 Feb 2006 18:02:51 -0800 (PST)
Received: from us-bv-u16.global.tektronix.net (us-bv-u16.bv.tek.com
	[128.181.2.45])
	by tektronix.tek.com (8.12.10+Sun/8.12.10) with SMTP id k1B22pxW022602
	for <linuxppc-embedded@ozlabs.org>;
	Fri, 10 Feb 2006 18:02:51 -0800 (PST)
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Subject: RE: kernel startup 
Date: Fri, 10 Feb 2006 18:03:33 -0800
Message-ID: <4A062D477D842B4C8FC48EA5AF2D41F201BA209D@us-bv-m23.global.tektronix.net>
From: <atul.sabharwal@exgate.tek.com>
To: <atul.sabharwal@exgate.tek.com>, <wd@denx.de>
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

Actually, it would be great if PPC would allow the exception handlers to
execute from DPRAM.  The handler would run faster than coming from a
RAM/flash or some EEPROM.  Don't know all the implications but should be
a useful speedup.

--
Atul
