Return-Path: <imunsie@au1.ibm.com>
Received: from e23smtp08.au.ibm.com (e23smtp08.au.ibm.com [202.81.31.141])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e23smtp08.au.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id D4BDAB7D11
	for <linuxppc-dev@lists.ozlabs.org>;
	Mon, 12 Apr 2010 16:44:48 +1000 (EST)
Received: from d23relay04.au.ibm.com (d23relay04.au.ibm.com [202.81.31.246])
	by e23smtp08.au.ibm.com (8.14.3/8.13.1) with ESMTP id o3C6igGS025213
	for <linuxppc-dev@lists.ozlabs.org>; Mon, 12 Apr 2010 16:44:42 +1000
Received: from d23av04.au.ibm.com (d23av04.au.ibm.com [9.190.235.139])
	by d23relay04.au.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
	o3C6cICY1306668
	for <linuxppc-dev@lists.ozlabs.org>; Mon, 12 Apr 2010 16:38:18 +1000
Received: from d23av04.au.ibm.com (loopback [127.0.0.1])
	by d23av04.au.ibm.com (8.14.3/8.13.1/NCO v10.0 AVout) with ESMTP id
	o3C6igr3025209
	for <linuxppc-dev@lists.ozlabs.org>; Mon, 12 Apr 2010 16:44:42 +1000
From: "Ian Munsie" <imunsie@au1.ibm.com>
To: linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Subject: 
Date: Mon, 12 Apr 2010 16:43:14 +1000
Message-Id: <1271054596-26561-1-git-send-email-imunsie@au.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

These patches add the required mappings to use perf probe on PowerPC.

Functionality wise it requires patch 359e4284a3f37aba7fd06d993863de2509d86f54
from the powerpc-next tree to provide the HAVE_REGS_AND_STACK_ACCESS_API
required for CONFIG_KPROBE_EVENT. The code will still compile cleanly without
it and will fail gracefully at runtime on the missing CONFIG_KPROBE_EVENT
support as before.

Part 1 of the patch series moves the arch dependent x86 32 and 64 bit DWARF
register number mappings out into a separate arch directory and adds the
necessary Makefile foo to use it.

Part 2 of the patch series adds the PowerPC mappings.

Thanks,
-Ian
