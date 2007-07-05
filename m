Return-Path: <olof@lixom.net>
Received: from mail.lixom.net (lixom.net [66.141.50.11])
	by ozlabs.org (Postfix) with ESMTP id 69892DDE2C
	for <linuxppc-dev@ozlabs.org>; Fri,  6 Jul 2007 03:03:46 +1000 (EST)
Message-Id: <20070705170233.258351000@lixom.net>
Date: Thu, 05 Jul 2007 12:02:33 -0500
From: Olof Johansson <olof@lixom.net>
To: linuxppc-dev@ozlabs.org
Subject: [patch 00/35] PA Semi patch set
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

The following series is a snapshot of the in-progress and out-of-tree
errata workarounds that I'm currently maintaining.

The first patches are mostly copies of stuff that has already been sent
out for upstream merge, followed by some patches that are not yet ready
to be merged (need cleanup, more work). Last are some errata workarounds
for various bugs in the sample-level silicon.

Some of the workarounds are quite ugly and touches various parts of the
kernels in not so pretty ways. No need to tell me about it.

They are also not multiplatform-friendly. Since they are all temporary
it hasn't been a priority.

This is not a request for review or merge, just a FYI to "get the patches
out there".

--
