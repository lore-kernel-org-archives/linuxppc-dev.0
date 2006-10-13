Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id D7CE867C5F
	for <linuxppc-dev@ozlabs.org>; Fri, 13 Oct 2006 18:04:22 +1000 (EST)
Received: from [127.0.0.1] (localhost [127.0.0.1])
	by gate.crashing.org (8.12.8/8.12.8) with ESMTP id k9D8CkAu017055
	for <linuxppc-dev@ozlabs.org>; Fri, 13 Oct 2006 03:12:47 -0500
Subject: [PATCH 0/5] powerpc: feature fixup updates
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: linuxppc-dev list <linuxppc-dev@ozlabs.org>
Content-Type: text/plain
Date: Fri, 13 Oct 2006 18:04:17 +1000
Message-Id: <1160726657.4792.221.camel@localhost.localdomain>
Mime-Version: 1.0
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Here's a new batch of the feature fixup updates.

Changes since last time:

 - moves identify_cpu() to C code (removes more assembly gunk)
 - works on 32 bits :)
 - invert use of nested in MFTB for the cell fixup
 - adds a patch for fixup in modules support
 - the fixup code does 2 loops as suggested by Olof

The bulk could be merged if you want, except the cell TB fix which still
needs to change to the new workaround method. I haven't had time to
finish that today.
