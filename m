Return-Path: <vova-ks@yandex.ru>
Received: from dgap-gw.mipt.ru (dgap-gw.mipt.ru [194.85.81.130])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mail.dgap.mipt.ru",
	Issuer "DGAP Root Certificate" (not verified))
	by ozlabs.org (Postfix) with ESMTP id 24C202BDEB
	for <linuxppc-embedded@ozlabs.org>;
	Wed,  3 Nov 2004 22:09:11 +1100 (EST)
Received: from unknown (HELO localhost) ([127.0.0.1])
	(envelope-sender <vova-ks@yandex.ru>)
	by localhost (qmail-ldap-1.03) with SMTP
	for <linuxppc-embedded@ozlabs.org>; 3 Nov 2004 11:09:06 -0000
Received: from dgap-gw.mipt.ru ([127.0.0.1])
	by localhost (dgap-gw.mipt.ru [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 10154-04 for <linuxppc-embedded@ozlabs.org>;
	Wed,  3 Nov 2004 14:09:06 +0300 (MSK)
From: Vladimir <vova-ks@yandex.ru>
To: linuxppc-embedded@ozlabs.org
Date: Wed, 3 Nov 2004 14:09:34 +0300
References: <200411020354.39610.vova-ks@yandex.ru>
	<41879A89.5020104@rossvideo.com>
In-Reply-To: <41879A89.5020104@rossvideo.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200411031409.34917.vova-ks@yandex.ru>
Subject: Re: Problem with user-space programs on 405GP
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

On Tuesday 02 November 2004 17:32, Ralph Siemsen wrote:
> Vladimir wrote:
> > I've tried to replace /sbin/init by my own executable - it's definitely
> > have not been executed.
>
> Try enabling CONFIG_MATH_EMULATION=y in your kernel .config file.
I've tried this. It steel doesn't work. Now I've switched to 2.6 kernel - it 
doesn't have this problem.
Anyway, thanks for reply.

-- 
         Vladimir
