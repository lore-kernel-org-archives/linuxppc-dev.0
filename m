Return-Path: <rober@opnet.com.tw>
Received: from opnet2.opnet.com.tw (unknown [210.243.240.244])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id A116668348
	for <linuxppc-embedded@ozlabs.org>;
	Wed, 21 Sep 2005 12:07:43 +1000 (EST)
Received: from [10.0.14.26] (h248-210-243-240.opnet.com.tw [210.243.240.248]
	(may be forged))
	by opnet2.opnet.com.tw (8.13.3/8.13.1) with ESMTP id j8L9vL4o011173
	for <linuxppc-embedded@ozlabs.org>; Wed, 21 Sep 2005 09:57:23 GMT
	(envelope-from rober@opnet.com.tw)
From: =?UTF-8?Q?=E5=BE=90=E5=B0=8F=E5=A8=81=E7=9A=84EMAIL?=
	<rober@opnet.com.tw>
To: linuxppc-embedded@ozlabs.org
Content-Type: text/plain
Date: Wed, 21 Sep 2005 10:07:25 +0800
Message-Id: <1127268445.7865.4.camel@banana>
Mime-Version: 1.0
Subject: How to add user at linux 2.4.25 with eldk 3.1.1
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Hi all:

     I used 2.4.25 linux at my custom 852T board, I can telnet into
linux with root user and password is empty. But can't login ftp with
same id and password. 

     How to add a new user at 2.4.25 linux. I used nfs as filesystem
(/opt/eldk/ppc_8xx).

bash-2.05b# ftp 10.0.14.120
Connected to 10.0.14.120 (10.0.14.120).
220 10.0.14.120 FTP server (Version wu-2.6.1(1) Tue Jun 7 14:51:02 MEST
2005) ready.
Name (10.0.14.120:root): root
331 Password required for root.
Password:
530 Login incorrect.
Login failed.

 
Best Regards,
Rober Hsu
