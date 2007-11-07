Return-Path: <RAISCH@de.ibm.com>
Received: from mtagate6.de.ibm.com (mtagate6.de.ibm.com [195.212.29.155])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mtagate6.de.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 7AFC1DDDD8
	for <linuxppc-dev@ozlabs.org>; Wed,  7 Nov 2007 19:35:52 +1100 (EST)
Received: from d12nrmr1607.megacenter.de.ibm.com
	(d12nrmr1607.megacenter.de.ibm.com [9.149.167.49])
	by mtagate6.de.ibm.com (8.13.8/8.13.8) with ESMTP id lA78Zl0d202742
	for <linuxppc-dev@ozlabs.org>; Wed, 7 Nov 2007 08:35:47 GMT
Received: from d12av04.megacenter.de.ibm.com (d12av04.megacenter.de.ibm.com
	[9.149.165.229])
	by d12nrmr1607.megacenter.de.ibm.com (8.13.8/8.13.8/NCO v8.6) with
	ESMTP id lA78ZlcZ1978616
	for <linuxppc-dev@ozlabs.org>; Wed, 7 Nov 2007 09:35:47 +0100
Received: from d12av04.megacenter.de.ibm.com (loopback [127.0.0.1])
	by d12av04.megacenter.de.ibm.com (8.12.11.20060308/8.13.3) with ESMTP
	id lA78Zkxd027445
	for <linuxppc-dev@ozlabs.org>; Wed, 7 Nov 2007 09:35:46 +0100
In-Reply-To: <20071106223119.GC31367@localhost.localdomain>
References: <OF6FC435A0.F59C9AD9-ONC125738B.002A5195-C125738B.002A424A@de.ibm.com>	<200711061606.04402.hnguyen@linux.vnet.ibm.com>
	<20071106223119.GC31367@localhost.localdomain>
Subject: Re: [ofa-general] Re: problem in follow_hugetlb_page on
	ppc64	architecture with get_user_pages
To: David Gibson <dwg@au1.ibm.com>
Message-ID: <OF5896F13F.53CE0380-ONC125738C.002C57D6-C125738C.002CB369@de.ibm.com>
From: Christoph Raisch <RAISCH@de.ibm.com>
Date: Wed, 7 Nov 2007 09:35:44 +0100
MIME-Version: 1.0
Content-type: text/plain; charset=US-ASCII
Cc: Roland Dreier <rdreier@cisco.com>,
	linux-kernel <linux-kernel@vger.kernel.org>,
	linux-ppc <linuxppc-dev@ozlabs.org>, general-bounces@lists.openfabrics.org,
	Hoang-Nam Nguyen <HNGUYEN@de.ibm.com>, general@lists.openfabrics.org,
	Hoang-Nam Nguyen <hnguyen@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


general-bounces@lists.openfabrics.org wrote on 06.11.2007 23:31:19:


> We should cut this down to the bare necessary and fold it into the
> libhugetlbfs testsuite.

Well, this testcase is already pretty close to the bare minimum
what's needed to run IB/RDMA queues.
You can compare this to for example ibv_rc_pingpong in libibverbs...

Maybe it's possible to test this with anything else than IB?

> --
Gruss / Regards
Christoph R
