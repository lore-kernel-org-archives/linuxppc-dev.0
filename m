Return-Path: <avorontsov@ru.mvista.com>
Received: from buildserver.ru.mvista.com (unknown [85.21.88.6])
	by ozlabs.org (Postfix) with ESMTP id 17E6EDDDE7
	for <linuxppc-dev@ozlabs.org>; Thu,  4 Dec 2008 06:26:46 +1100 (EST)
Date: Wed, 3 Dec 2008 22:26:44 +0300
From: Anton Vorontsov <avorontsov@ru.mvista.com>
To: Kumar Gala <galak@kernel.crashing.org>
Subject: [PATCH 0/5] Few patches for galak/powerpc.git next
Message-ID: <20081203192644.GA6145@oksana.dev.rtsoft.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf8
Cc: linuxppc-dev@ozlabs.org, Timur Tabi <timur@freescale.com>
Reply-To: avorontsov@ru.mvista.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Hi Kumar,

Here are few patches queued for the next branch. The patches are
mostly USB related. Plus a trivial patch that fixes some sparse
warnings.

[PATCH 1/5] powerpc/qe: Implement QE Pin Multiplexing API
[PATCH 2/5] powerpc: Implement GPIO driver for simple memory-mapped banks
[PATCH 3/5] powerpc/83xx: Add USB Host/Gadget support for MPC8360E-MDS boards
[PATCH 4/5] powerpc/83xx: Add USB Host support for MPC8360E-RDK boards
[PATCH 5/5] powerpc/83xx: Fix sparse warnings in mpc836x_mds.c

Thanks,

-- 
Anton Vorontsov
email: cbouatmailru@gmail.com
irc://irc.freenode.net/bd2
