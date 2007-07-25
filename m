Return-Path: <bounces@nabble.com>
Received: from kuber.nabble.com (kuber.nabble.com [216.139.236.158])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 589D7DDE02
	for <linuxppc-embedded@ozlabs.org>;
	Wed, 25 Jul 2007 19:29:14 +1000 (EST)
Received: from isper.nabble.com ([192.168.236.156])
	by kuber.nabble.com with esmtp (Exim 4.63)
	(envelope-from <bounces@nabble.com>) id 1IDdB7-0002Hb-Fo
	for linuxppc-embedded@ozlabs.org; Wed, 25 Jul 2007 02:29:09 -0700
Message-ID: <11779249.post@talk.nabble.com>
Date: Wed, 25 Jul 2007 02:29:09 -0700 (PDT)
From: Nethra <nethra_gmit@yahoo.co.in>
To: linuxppc-embedded@ozlabs.org
Subject: ping command
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


hi,

I m using custom board same as eval board MPC8272ADS board.

IP assigned for both ethernets are...

              ifconfig eth1 192.168.33.135 up
	 ifconfig eth1 netmask 255.255.248.0
 	 route add default gw 192.168.32.47 eth1
 
 
	 ifconfig eth0 192.168.178.89 up
	 ifconfig eth0netmask 255.255.255.0
	 route add default gw 192.168.178.47 eth0

but if i try for ping 192.168.33.135 command pails by the server of 178
series
similarly ping 192.168.178.89 command pails by the server of 33 series..

what is the problem..and whre i m going wrong..?

thanks in advance..

Nethra

-- 
View this message in context: http://www.nabble.com/ping-command-tf4141032.html#a11779249
Sent from the linuxppc-embedded mailing list archive at Nabble.com.
