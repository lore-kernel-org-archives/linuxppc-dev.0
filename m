Return-Path: <wojciech.kromer@dgt.com.pl>
Received: from dgt.com.pl (mail.dgt.com.pl [195.117.141.2])
	(using TLSv1 with cipher EDH-RSA-DES-CBC3-SHA (168/168 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 0AA2B67A59
	for <linuxppc-embedded@ozlabs.org>;
	Fri, 13 May 2005 16:32:41 +1000 (EST)
Message-ID: <4284456B.4080602@dgt.com.pl>
Date: Fri, 13 May 2005 08:12:59 +0200
From: Wojciech Kromer <wojciech.kromer@dgt.com.pl>
MIME-Version: 1.0
To: linuxppc-embedded@ozlabs.org
Content-Type: text/plain; charset=us-ascii; format=flowed
Subject: IDMA
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Do I need any hardware changes in order to use IDMA for PCI transactions 
on 8250?
Should it be faster?
Maybe less cpu usage?

I have the same questions about using idma for connecting external 
device (ie DSP) on 8xx processors ?
