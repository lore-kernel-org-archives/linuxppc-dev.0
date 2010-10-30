Return-Path: <christophe.leroy@c-s.fr>
Received: from mailhub1.si.c-s.fr (pegase1.c-s.fr [194.2.40.7])
	by ozlabs.org (Postfix) with ESMTP id 10586B70D1
	for <linuxppc-dev@lists.ozlabs.org>;
	Sat, 30 Oct 2010 23:30:16 +1100 (EST)
Received: from localhost (mailhub1-int [192.168.12.234])
	by localhost (Postfix) with ESMTP id 1A4BD1CABF6
	for <linuxppc-dev@lists.ozlabs.org>;
	Sat, 30 Oct 2010 13:52:20 +0200 (CEST)
Received: from mailhub1.si.c-s.fr ([192.168.12.234])
	by localhost (mailhub1.c-s.fr [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id s8E5YUme8cFJ for <linuxppc-dev@lists.ozlabs.org>;
	Sat, 30 Oct 2010 13:52:20 +0200 (CEST)
Received: from messagerie.si.c-s.fr (messagerie [192.168.25.192])
	by pegase1.c-s.fr (Postfix) with ESMTP id 0516E1CABA8
	for <linuxppc-dev@lists.ozlabs.org>;
	Sat, 30 Oct 2010 13:52:20 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by messagerie.si.c-s.fr (Postfix) with ESMTP id E7535C7392
	for <linuxppc-dev@lists.ozlabs.org>;
	Sat, 30 Oct 2010 13:52:19 +0200 (CEST)
Received: from messagerie.si.c-s.fr ([127.0.0.1])
	by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new,
	port 10023)
	with ESMTP id AQ1uf0E2qAw3 for <linuxppc-dev@lists.ozlabs.org>;
	Sat, 30 Oct 2010 13:52:19 +0200 (CEST)
Received: from [127.0.0.1] (unknown [192.168.4.167])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by messagerie.si.c-s.fr (Postfix) with ESMTP id B0239C7391
	for <linuxppc-dev@lists.ozlabs.org>;
	Sat, 30 Oct 2010 13:52:19 +0200 (CEST)
Message-ID: <4CCC06F8.3020506@c-s.fr>
Date: Sat, 30 Oct 2010 13:52:24 +0200
From: LEROY christophe <christophe.leroy@c-s.fr>
MIME-Version: 1.0
To: linuxppc-dev@lists.ozlabs.org
Subject: [MPC8xx] Initial MMU too low
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hello,

When I build a kernel with DEBUG_LOCK_ALLOC set, I get a kernel which 
has __bss_stop above the C0800000 limit, and then I get a bad page 
exception during the zeroize of the __bss at startup, because the 
initial MMU only maps the first 8Mbytes.

What can I do to fix that ?

Regards
C. Leroy
