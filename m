Return-Path: <wojciech.kromer@dgt.com.pl>
Received: from dgt.com.pl (mail.dgt.com.pl [195.117.141.2])
	(using TLSv1 with cipher EDH-RSA-DES-CBC3-SHA (168/168 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id D56A067DC5
	for <linuxppc-embedded@ozlabs.org>;
	Thu, 28 Jul 2005 21:25:28 +1000 (EST)
Received: from mail.dgt.com.pl (localhost [127.0.0.1])
	by dgt.com.pl (Postfix) with SMTP id AD5DC59032
	for <linuxppc-embedded@ozlabs.org>;
	Thu, 28 Jul 2005 13:25:16 +0200 (CEST)
Received: from [192.168.7.66] (proxy.dgt.com.pl [::ffff:195.117.141.11])
	by dgt.com.pl (Postfix) with ESMTP id 2AA1E58601
	for <linuxppc-embedded@ozlabs.org>;
	Thu, 28 Jul 2005 13:25:16 +0200 (CEST)
Message-ID: <42E8C0C7.9080408@dgt.com.pl>
Date: Thu, 28 Jul 2005 13:25:59 +0200
From: Wojciech Kromer <wojciech.kromer@dgt.com.pl>
MIME-Version: 1.0
To: linuxppc-embedded@ozlabs.org
References: <42E8BB67.8070407@dgt.com.pl>
In-Reply-To: <42E8BB67.8070407@dgt.com.pl>
Content-Type: text/plain; charset=us-ascii; format=flowed
Subject: Re: burst
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Forgot to say, it's on mpc8250

> How to enable burst acces for external device?
> What i did:
> - program UPMx with correct cycles
> - setup ORx BRx, and not set BI (BurstInhibit)
> - done opremap instead of opremap_nocache
>
> An no burst acces is done.
>
> Do I have to do DMA transfers?
>
>
