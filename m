Return-Path: <vova-ks@yandex.ru>
Received: from dgap-gw.mipt.ru (dgap-gw.mipt.ru [194.85.81.130])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mail.dgap.mipt.ru",
	Issuer "DGAP Root Certificate" (not verified))
	by ozlabs.org (Postfix) with ESMTP id 7BD112BDF2
	for <linuxppc-embedded@ozlabs.org>;
	Thu,  4 Nov 2004 01:17:32 +1100 (EST)
Received: from unknown (HELO localhost) ([127.0.0.1])
	(envelope-sender <vova-ks@yandex.ru>)
	by localhost (qmail-ldap-1.03) with SMTP
	for <linuxppc-embedded@ozlabs.org>; 3 Nov 2004 14:17:21 -0000
Received: from dgap-gw.mipt.ru ([127.0.0.1])
	by localhost (dgap-gw.mipt.ru [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 14319-04 for <linuxppc-embedded@ozlabs.org>;
	Wed,  3 Nov 2004 17:17:20 +0300 (MSK)
From: Vladimir <vova-ks@yandex.ru>
To: linuxppc-embedded@ozlabs.org
Date: Wed, 3 Nov 2004 17:17:55 +0300
References: <200411031241.40681.vova-ks@yandex.ru>
	<20041103065645.A3357@home.com>
In-Reply-To: <20041103065645.A3357@home.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200411031717.55398.vova-ks@yandex.ru>
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

On Wednesday 03 November 2004 16:56, Matt Porter wrote:
> No, it's not sufficient.  It helps to check the archives first.
>
> http://ozlabs.org/pipermail/linuxppc-embedded/2004-October/000417.html
> http://ozlabs.org/pipermail/linuxppc-embedded/2004-October/000418.html
I've tried this patch but it fails to apply (at least to 2.6.8.1 from 
kernel.org). Am I to use another kernel version to apply this patch ?

> These are now in the 2.6 mainline (BK current).

-- 
         Vladimir
