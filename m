Return-Path: <hnguyen@linux.vnet.ibm.com>
Received: from mtagate4.de.ibm.com (mtagate4.de.ibm.com [195.212.29.153])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mtagate4.de.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 1ED98DDE07
	for <linuxppc-dev@ozlabs.org>; Wed, 24 Jan 2007 10:13:46 +1100 (EST)
Received: from d12nrmr1607.megacenter.de.ibm.com
	(d12nrmr1607.megacenter.de.ibm.com [9.149.167.49])
	by mtagate4.de.ibm.com (8.13.8/8.13.8) with ESMTP id l0NNDa2l181422
	for <linuxppc-dev@ozlabs.org>; Tue, 23 Jan 2007 23:13:36 GMT
Received: from d12av04.megacenter.de.ibm.com (d12av04.megacenter.de.ibm.com
	[9.149.165.229])
	by d12nrmr1607.megacenter.de.ibm.com (8.13.8/8.13.8/NCO v8.2) with
	ESMTP id l0NNDaaK2691144
	for <linuxppc-dev@ozlabs.org>; Wed, 24 Jan 2007 00:13:36 +0100
Received: from d12av04.megacenter.de.ibm.com (loopback [127.0.0.1])
	by d12av04.megacenter.de.ibm.com (8.12.11.20060308/8.13.3) with ESMTP
	id l0NNDZjr007259
	for <linuxppc-dev@ozlabs.org>; Wed, 24 Jan 2007 00:13:35 +0100
From: Hoang-Nam Nguyen <hnguyen@linux.vnet.ibm.com>
To: Roland Dreier <rdreier@cisco.com>, hch@infradead.org,
	linux-kernel@vger.kernel.org, linuxppc-dev@ozlabs.org,
	openib-general@openib.org, openfabrics-ewg@openib.org
Subject: [PATCH 2.6.21 0/4] ehca: remove do_mmap() and some bug fixes
Date: Wed, 24 Jan 2007 00:09:56 +0100
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Message-Id: <200701240009.57364.hnguyen@linux.vnet.ibm.com>
Cc: raisch@de.ibm.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Hello Roland!
Here is a patch set for ehca as a result of previous disscussions
and comments:
1. fix improper use of yield within spinlock context
2. fix mismatched use of spin_unlock in irq handler
3. remove do_mmap()
4. remove obsolete prototypes
PS: I've sent the first two recently for 2.6.20, but adding here
for completeness for 2.6.21.
Thanks
Nam
