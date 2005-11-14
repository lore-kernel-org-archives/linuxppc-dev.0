Return-Path: <galak@gate.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 5440C68754
	for <linuxppc-dev@ozlabs.org>; Tue, 15 Nov 2005 10:04:00 +1100 (EST)
Date: Mon, 14 Nov 2005 17:01:43 -0600 (CST)
From: Kumar Gala <galak@gate.crashing.org>
To: Paul Mackerras <paulus@samba.org>
Message-ID: <Pine.LNX.4.44.0511141655560.8331-100000@gate.crashing.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: michael@ellerman.id.au, linuxppc-dev@ozlabs.org,
	linuxppc64@gate.crashing.org
Subject: asm-ppc/page.h vs asm-powerpc/page.h
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Guys, what's going on here.

Why haven't we removed asm-ppc/page.h?

When I build ARCH=powerpc I get asm-powerpc/page.h, which doesn't build on 
85xx since page_to_virt is missing.

Any reason we are keeping around asm-ppc/page.h and causing this 
confusion?

- kumar
