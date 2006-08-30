Return-Path: <HNGUYEN@de.ibm.com>
Received: from mtagate6.de.ibm.com (mtagate6.de.ibm.com [195.212.29.155])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mtagate6.de.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id E4C9C67B22
	for <linuxppc-dev@ozlabs.org>; Wed, 30 Aug 2006 19:09:19 +1000 (EST)
Received: from d12nrmr1607.megacenter.de.ibm.com
	(d12nrmr1607.megacenter.de.ibm.com [9.149.167.49])
	by mtagate6.de.ibm.com (8.13.7/8.13.7) with ESMTP id k7U99Fsn062766
	for <linuxppc-dev@ozlabs.org>; Wed, 30 Aug 2006 09:09:15 GMT
Received: from d12av02.megacenter.de.ibm.com (d12av02.megacenter.de.ibm.com
	[9.149.165.228])
	by d12nrmr1607.megacenter.de.ibm.com (8.13.6/8.13.6/NCO v8.1.1) with
	ESMTP id k7U9DSHZ2895932
	for <linuxppc-dev@ozlabs.org>; Wed, 30 Aug 2006 11:13:28 +0200
Received: from d12av02.megacenter.de.ibm.com (loopback [127.0.0.1])
	by d12av02.megacenter.de.ibm.com (8.12.11.20060308/8.13.3) with ESMTP
	id k7U99EuC030734
	for <linuxppc-dev@ozlabs.org>; Wed, 30 Aug 2006 11:09:15 +0200
In-Reply-To: <OFED0915E4.3CED6795-ONC12571CE.0053ECB8-C12571CE.0055546A@LocalDomain>
Subject: Re: [PATCH 02/13] IB/ehca: includes
To: abergman@de.ibm.com, linux-kernel@vger.kernel.org, linuxppc-dev@ozlabs.org,
	openib-general@openib.org
Message-ID: <OF23CA96AE.C7DBFD52-ONC12571DA.00321849-C12571DA.00324865@de.ibm.com>
From: Hoang-Nam Nguyen <HNGUYEN@de.ibm.com>
Date: Wed, 30 Aug 2006 11:13:26 +0200
MIME-Version: 1.0
Content-type: text/plain; charset=US-ASCII
Cc: Christoph Raisch <RAISCH@de.ibm.com>, Marcus Eder <MEDER@de.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

> Christoph Raisch wrote on 18.08.2006 17:35:54:
> we'll change these EDEBs to a wrapper around dev_err, dev_dbg and
> dev_warn as it's done in the mthca driver.
> All EDEB_EN and EDEB_EX will be removed, that type of tracing can be
> done if needed by kprobes.
> There are a few cases where we won't get to a dev, for these few
> places we'll use a simple wrapper around printk, as done in ipoib.
We incorporated those changes throughout ehca code, which is accessible
from
Roland's git tree:
git://git.kernel.org/pub/scm/linux/kernel/git/roland/infiniband.git
for-2.6.19
Further comments/suggestions are appreciated!
Regards
Hoang-Nam Nguyen
