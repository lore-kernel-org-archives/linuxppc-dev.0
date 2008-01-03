Return-Path: <bounces@nabble.com>
Received: from kuber.nabble.com (kuber.nabble.com [216.139.236.158])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 2520BDDE29
	for <linuxppc-embedded@ozlabs.org>;
	Thu,  3 Jan 2008 16:03:22 +1100 (EST)
Received: from isper.nabble.com ([192.168.236.156])
	by kuber.nabble.com with esmtp (Exim 4.63)
	(envelope-from <bounces@nabble.com>) id 1JAIEi-0004w7-2j
	for linuxppc-embedded@ozlabs.org; Wed, 02 Jan 2008 21:03:20 -0800
Message-ID: <14591717.post@talk.nabble.com>
Date: Wed, 2 Jan 2008 21:03:20 -0800 (PST)
From: Misbah khan <misbah_khan@engineer.com>
To: linuxppc-embedded@ozlabs.org
Subject: Reading a config file in a driver ....
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>


Hi all ....

I am writing a LCD driver in which the default configuration for LCD would
be loded at the Init . This default configuration if keep in the driver then
for a change in default configuration we need to compile the driver which we
never want . Hence we want a .config file in /etc/lcd.config dir which could
be changed and the next boot will take this configuration as the default
configuration. 

I need to know How to read from the config file in the driver form the dir
/etc/lcd.config. The driver would be installed at boot up 

Please if any of you have an experience in this or could suggest something
,I would really appriciate ...


----Misbah <><
-- 
View this message in context: http://www.nabble.com/Reading-a-config-file-in-a-driver-....-tp14591717p14591717.html
Sent from the linuxppc-embedded mailing list archive at Nabble.com.
