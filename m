Return-Path: <vova-ks@yandex.ru>
Received: from dgap-gw.mipt.ru (dgap-gw.mipt.ru [194.85.81.130])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mail.dgap.mipt.ru",
	Issuer "DGAP Root Certificate" (not verified))
	by ozlabs.org (Postfix) with ESMTP id 0F8262BDF2
	for <linuxppc-embedded@ozlabs.org>;
	Thu,  4 Nov 2004 09:51:53 +1100 (EST)
Received: from unknown (HELO localhost) ([127.0.0.1])
	(envelope-sender <vova-ks@yandex.ru>)
	by localhost (qmail-ldap-1.03) with SMTP
	for <linuxppc-embedded@ozlabs.org>; 3 Nov 2004 22:51:43 -0000
Received: from dgap-gw.mipt.ru ([127.0.0.1])
	by localhost (dgap-gw.mipt.ru [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 30565-09 for <linuxppc-embedded@ozlabs.org>;
	Thu,  4 Nov 2004 01:51:42 +0300 (MSK)
From: Vladimir <vova-ks@yandex.ru>
To: linuxppc-embedded@ozlabs.org
Date: Thu, 4 Nov 2004 01:34:23 +0300
References: <200411031241.40681.vova-ks@yandex.ru>
	<200411031717.55398.vova-ks@yandex.ru>
	<20041103073630.A3485@home.com>
In-Reply-To: <20041103073630.A3485@home.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200411040134.23806.vova-ks@yandex.ru>
Subject: Re: kgdb on 405GP walnut-like board.
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

On Wednesday 03 November 2004 17:36, Matt Porter wrote:
> The patch is against the current 2.6 BK tree, try patching a recent kernel
> release like 2.6.10-rc1.
I've tried 2.6.10-rc1-bk13 from kernel.org. Is it already include this patch ?
It successfully compiles, but at breakpoint() it fails to connect to host's 
gdb. I've grab /dev/ttyS1 traffic and see that kgdb stub sends to host a lot 
of zeros - nothing more. May be this is bug in serial port initialization ? 
How can I deal with it ?

-- 
         Vladimir
