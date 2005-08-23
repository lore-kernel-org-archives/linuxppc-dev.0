Return-Path: <rober@opnet.com.tw>
Received: from opnet2.opnet.com.tw (unknown [210.243.240.244])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 50BF868085
	for <linuxppc-embedded@ozlabs.org>;
	Tue, 23 Aug 2005 15:16:27 +1000 (EST)
Received: from [10.0.14.26] (h248-210-243-240.opnet.com.tw [210.243.240.248]
	(may be forged))
	by opnet2.opnet.com.tw (8.13.3/8.13.1) with ESMTP id j7NDAwJg030198
	for <linuxppc-embedded@ozlabs.org>; Tue, 23 Aug 2005 13:10:59 GMT
	(envelope-from rober@opnet.com.tw)
From: =?UTF-8?Q?=E5=BE=90=E5=B0=8F=E5=A8=81=E7=9A=84EMAIL?=
	<rober@opnet.com.tw>
To: linuxppc-embedded@ozlabs.org
Content-Type: text/plain
Date: Tue, 23 Aug 2005 13:16:13 +0800
Message-Id: <1124774174.5945.15.camel@banana>
Mime-Version: 1.0
Subject: How to run ELDK 3.1.1 's snmp ?
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Hi All:

     I want to know how to used ELDK 3.1.1's snmpd at ppc_8xx
environment.I used 2.4.25 Linux  and uRamdisk (from denx's ftp site) at
my MPC852T custom board. When  I mount /opt/eldk/ppc_88x to my linux and
run it,
I got following error message.

 # ./snmpd --version
./snmpd: No such file or directory

The found if i compiler snmp source code with LDFLAGS += --static,
although file is bigger than ELDK's snmpd (almost 3M byte), but it can
run very well. I want to know what's the different between LDFLAGS+=--
static and LDFLAGS=
Best Regards,
Rober Hsu 
