Return-Path: <vova-ks@yandex.ru>
Received: from dgap-gw.mipt.ru (dgap-gw.mipt.ru [194.85.81.130])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mail.dgap.mipt.ru",
	Issuer "DGAP Root Certificate" (not verified))
	by ozlabs.org (Postfix) with ESMTP id 7C8042BDEB
	for <linuxppc-embedded@ozlabs.org>;
	Wed,  3 Nov 2004 20:41:25 +1100 (EST)
Received: from unknown (HELO localhost) ([127.0.0.1])
	(envelope-sender <vova-ks@yandex.ru>)
	by 127.0.0.1 (qmail-ldap-1.03) with SMTP
	for <linuxppc-embedded@ozlabs.org>; 3 Nov 2004 09:41:15 -0000
Received: from dgap-gw.mipt.ru ([127.0.0.1])
	by localhost (dgap-gw.mipt.ru [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 25819-05 for <linuxppc-embedded@ozlabs.org>;
	Wed,  3 Nov 2004 12:41:15 +0300 (MSK)
From: Vladimir <vova-ks@yandex.ru>
To: linuxppc-embedded@ozlabs.org
Date: Wed, 3 Nov 2004 12:41:40 +0300
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Message-Id: <200411031241.40681.vova-ks@yandex.ru>
Subject: kgdb on 405GP walnut-like board.
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Hello All !
When I'm trying to compile linux-2.6.8.1 kernel on ppc with kgdb support it 
fails with the following error:

arch/ppc/kernel/ppc-stub.c:796: structure has no member named `dbcr0'

Can I just replace regs->dbcr0 with current->thread.dbcr0. Is it sufficient ?
Has this issue already been fixed by someone ?

-- 
         Vladimir
