Return-Path: <bounces@nabble.com>
Received: from kuber.nabble.com (kuber.nabble.com [216.139.236.158])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 1F4DCDDDD8
	for <linuxppc-embedded@ozlabs.org>;
	Sat,  4 Aug 2007 06:49:44 +1000 (EST)
Received: from isper.nabble.com ([192.168.236.156])
	by kuber.nabble.com with esmtp (Exim 4.63)
	(envelope-from <bounces@nabble.com>) id 1IH45d-0007YL-51
	for linuxppc-embedded@ozlabs.org; Fri, 03 Aug 2007 13:49:41 -0700
Message-ID: <11990563.post@talk.nabble.com>
Date: Fri, 3 Aug 2007 13:49:41 -0700 (PDT)
From: khollan <khollan@daktronics.com>
To: linuxppc-embedded@ozlabs.org
Subject: BusyBox passwd requires root privileges
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


I log on as a user and I want to use passwd to change that users password but
it gives me the 
passwd: applet requires root privileges!
I can login as root and change all user passwords, but I want individual
owners to be able to update their passwords.  Any ideas?
Thanks
khollan
-- 
View this message in context: http://www.nabble.com/BusyBox-passwd-requires-root-privileges-tf4214675.html#a11990563
Sent from the linuxppc-embedded mailing list archive at Nabble.com.
