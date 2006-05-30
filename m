Return-Path: <wojciech.kromer@dgt.com.pl>
Received: from dgt.com.pl (mail.dgt.com.pl [195.117.141.2])
	(using TLSv1 with cipher EDH-RSA-DES-CBC3-SHA (168/168 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 1E0EC67A44
	for <linuxppc-embedded@ozlabs.org>;
	Tue, 30 May 2006 19:26:20 +1000 (EST)
Received: from mail.dgt.com.pl (localhost [127.0.0.1])
	by dgt.com.pl (Postfix) with SMTP id 246B26C26D
	for <linuxppc-embedded@ozlabs.org>;
	Tue, 30 May 2006 11:04:38 +0200 (CEST)
Received: from [192.168.7.66] (proxy.dgt.com.pl [::ffff:195.117.141.11])
	by dgt.com.pl (Postfix) with ESMTP id A46696C1E3
	for <linuxppc-embedded@ozlabs.org>;
	Tue, 30 May 2006 11:04:37 +0200 (CEST)
Message-ID: <447C0AEF.4070003@dgt.com.pl>
Date: Tue, 30 May 2006 11:05:51 +0200
From: Wojciech Kromer <wojciech.kromer@dgt.com.pl>
MIME-Version: 1.0
To: linuxppc-embedded <linuxppc-embedded@ozlabs.org>
Subject: Re: LXT973 support (dual PHY with single MDIO)
References: <200605301048.01209.laurent.pinchart@tbox.biz>
In-Reply-To: <200605301048.01209.laurent.pinchart@tbox.biz>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>


I'm sucesfully using this chip with denx.de 2.4.25 kernel and single 
MDIO port.
You need to  change auto PHY-addr detection method. By default it 
detects both PHYs on same addr.
