Return-Path: <frankvm@frankvm.com>
Received: from janus.localdomain (frankvm.xs4all.nl [80.126.170.174])
	by ozlabs.org (Postfix) with ESMTP id B468067C36
	for <linuxppc-dev@ozlabs.org>; Sat, 16 Jul 2005 02:27:42 +1000 (EST)
Date: Fri, 15 Jul 2005 18:27:41 +0200
From: Frank van Maarseveen <frankvm@frankvm.com>
To: linuxppc-dev@ozlabs.org
Message-ID: <20050715162741.GA23228@janus>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Subject: arch/ppc/kernel/misc.S: .align 5?
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

At least in 2.6.12.2 I see this in arch/ppc/kernel/misc.S:

	.text

	.align  5
_GLOBAL(__delay)
	cmpwi   0,r3,0


-- 
Frank
