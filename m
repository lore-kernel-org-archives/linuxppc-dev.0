Return-Path: <wojciech.kromer@dgt.com.pl>
Received: from dgt.com.pl (mail.dgt.com.pl [195.117.141.2])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 8D9D1DE1ED
	for <linuxppc-embedded@ozlabs.org>;
	Fri, 28 Mar 2008 02:32:48 +1100 (EST)
Received: from localhost (localhost [127.0.0.1])
	by dgt.com.pl (Postfix) with ESMTP id 26FD325ADA6
	for <linuxppc-embedded@ozlabs.org>;
	Thu, 27 Mar 2008 15:51:21 +0100 (CET)
Received: from dgt.com.pl ([127.0.0.1])
	by localhost (mail.dgt.com.pl [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id qdDuNquFJtVi for <linuxppc-embedded@ozlabs.org>;
	Thu, 27 Mar 2008 15:51:21 +0100 (CET)
Received: from krom.bkir.dgt (unknown [192.168.7.66])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by dgt.com.pl (Postfix) with ESMTP id 035F425AD8F
	for <linuxppc-embedded@ozlabs.org>;
	Thu, 27 Mar 2008 15:51:21 +0100 (CET)
Message-ID: <47EBB44E.2000407@dgt.com.pl>
Date: Thu, 27 Mar 2008 15:50:54 +0100
From: Wojciech Kromer <wojciech.kromer@dgt.com.pl>
MIME-Version: 1.0
To: linuxppc-embedded@ozlabs.org
Subject: ksoftirqd_CPU0  uses 100% CPU
Content-Type: text/plain; charset=ISO-8859-2; format=flowed
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Hello.

When I plug off ethernet cable ksoftirqd_CPU0 starts using 100% od CPU.
After pluging it back or downing eth0 interface it comes back to normal load.

Any sollution?
I'm using 2.4.25 on ppc 8250.

Regards.
