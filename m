Return-Path: <st@iss.tu-darmstadt.de>
Received: from lnx130.hrz.tu-darmstadt.de (lnx130.hrz.tu-darmstadt.de
	[130.83.174.24])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 4E178DDDE4
	for <linuxppc-embedded@ozlabs.org>;
	Tue, 30 Jan 2007 20:38:46 +1100 (EST)
Received: from mailserver3.hrz.tu-darmstadt.de (lnx116.hrz.tu-darmstadt.de
	[130.83.174.28])
	by lnx130.hrz.tu-darmstadt.de (8.13.4/8.12.10) with ESMTP id
	l0U9cecZ001772
	for <linuxppc-embedded@ozlabs.org>; Tue, 30 Jan 2007 10:38:40 +0100
Received: from [130.83.164.10] (helo=iss10.vlsi.informatik.tu-darmstadt.de)
	by mailserver3.hrz.tu-darmstadt.de with esmtpsa
	(TLS-1.0:DHE_RSA_AES_128_CBC_SHA:16) (Exim 4.50) id 1HBpRo-0000BY-Pc
	for linuxppc-embedded@ozlabs.org; Tue, 30 Jan 2007 10:38:40 +0100
From: ST <st@iss.tu-darmstadt.de>
To: linuxppc-embedded@ozlabs.org
Subject: Re: MVME3100 and linux-2.6.10
Date: Tue, 30 Jan 2007 10:38:36 +0100
References: <6386542.1169804641943.SLOX.WebMail.wwwrun@mailserver.gemrad.com>
	<45BA5635.2000001@badgateway.de>
In-Reply-To: <45BA5635.2000001@badgateway.de>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200701301038.37207.st@iss.tu-darmstadt.de>
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Hi
> That is where my kernel stops to boot too!!!
> Is there someone out there who can tell us, what we did wrong?
Magnus Hjorth told us that "Early serial boot msgs" lead to a kernel crash.
Probably switch these of and give it a try?
ST
