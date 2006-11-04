Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 594E467BB4
	for <linuxppc-dev@ozlabs.org>; Sat,  4 Nov 2006 20:21:59 +1100 (EST)
Subject: FSL vs. IBM BookE
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: linuxppc-dev list <linuxppc-dev@ozlabs.org>
Content-Type: text/plain
Date: Sat, 04 Nov 2006 20:21:54 +1100
Message-Id: <1162632114.28571.33.camel@localhost.localdomain>
Mime-Version: 1.0
Cc: Kumar Gala <galak@gate.crashing.org>, Paul Mackerras <paulus@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Out of curiosity... I noticed we have both head_44x.S and
head_fsl_booke.S, the later being a fork of the former with changed from
Kumar (and possibly others) to support E200 and E500.

How bad are the differences between those cores ? Would it be possible
to reconcile those and IBM 44x into a single processor family ? Or are
there some fundamental differences making that impossible ? (even with a
bit of CPU feature patching).

Also, I suppose we should rename head_4xx.S to head_40x.S no ?

Cheers,
Ben.
