Return-Path: <leitao@linux.vnet.ibm.com>
Received: from e24smtp03.br.ibm.com (e24smtp03.br.ibm.com [32.104.18.24])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e24smtp03.br.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 0E5D8B7BCB
	for <linuxppc-dev@lists.ozlabs.org>;
	Tue, 27 Oct 2009 04:01:45 +1100 (EST)
Received: from mailhub3.br.ibm.com (mailhub3.br.ibm.com [9.18.232.110])
	by e24smtp03.br.ibm.com (8.14.3/8.13.1) with ESMTP id n9QGtUK7027425
	for <linuxppc-dev@lists.ozlabs.org>; Mon, 26 Oct 2009 14:55:30 -0200
Received: from d24av05.br.ibm.com (d24av05.br.ibm.com [9.18.232.44])
	by mailhub3.br.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
	n9QH2TY11388558
	for <linuxppc-dev@lists.ozlabs.org>; Mon, 26 Oct 2009 15:02:30 -0200
Received: from d24av05.br.ibm.com (loopback [127.0.0.1])
	by d24av05.br.ibm.com (8.14.3/8.13.1/NCO v10.0 AVout) with ESMTP id
	n9QH1cl1003959
	for <linuxppc-dev@lists.ozlabs.org>; Mon, 26 Oct 2009 15:01:38 -0200
Received: from [9.8.5.147] ([9.8.5.147])
	by d24av05.br.ibm.com (8.14.3/8.13.1/NCO v10.0 AVin) with ESMTP id
	n9QH1btZ003927
	for <linuxppc-dev@lists.ozlabs.org>; Mon, 26 Oct 2009 15:01:37 -0200
Message-ID: <4AE5D5F0.9020805@linux.vnet.ibm.com>
Date: Mon, 26 Oct 2009 15:01:36 -0200
From: Breno Leitao <leitao@linux.vnet.ibm.com>
MIME-Version: 1.0
To: linuxppc-dev@lists.ozlabs.org
Subject: INIT: PANIC: segmentation violation! sleeping for 30 seconds.
Content-Type: text/plain; charset=UTF-8
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi, 

I just put a upstream kernel(rc5) on a specific machine I have (Power5), and I got
the following error: 

INIT: PANIC: segmentation violation! sleeping for 30 seconds.
init has generated signal 11 but has no handler for it
init used greatest stack depth: 6240 bytes left
Kernel panic - not syncing: Attempted to kill init!
Call Trace:
[c0000001c6e7f920] [c000000000012588] .show_stack+0x6c/0x194 (unreliable)
[c0000001c6e7f9d0] [c000000000088bd4] .panic+0x74/0x1c0
[c0000001c6e7fa60] [c00000000008cbdc] .do_exit+0x43c/0x82c
[c0000001c6e7fb20] [c0000000000286f4] ._exception+0x1d4/0x204
[c0000001c6e7fcf0] [c0000000004e7dc8] .do_page_fault+0x4fc/0x634
[c0000001c6e7fe30] [c00000000000560c] handle_page_fault+0x20/0x74


Downgrading to rc2 shows the same result. Interesting enough, this is the only
machine that fails with the upstream kernel.

Have anyone seen anything similar ?

Thanks
