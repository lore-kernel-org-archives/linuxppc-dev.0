Return-Path: <HNGUYEN@de.ibm.com>
Received: from mtagate1.de.ibm.com (mtagate1.de.ibm.com [195.212.29.150])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mtagate1.de.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id A7F32DDE3A
	for <linuxppc-dev@ozlabs.org>; Fri, 17 Aug 2007 02:48:26 +1000 (EST)
Received: from d12nrmr1607.megacenter.de.ibm.com
	(d12nrmr1607.megacenter.de.ibm.com [9.149.167.49])
	by mtagate1.de.ibm.com (8.13.8/8.13.8) with ESMTP id l7GGmKYD552532
	for <linuxppc-dev@ozlabs.org>; Thu, 16 Aug 2007 16:48:20 GMT
Received: from d12av02.megacenter.de.ibm.com (d12av02.megacenter.de.ibm.com
	[9.149.165.228])
	by d12nrmr1607.megacenter.de.ibm.com (8.13.8/8.13.8/NCO v8.5) with
	ESMTP id l7GGmK4s1560652
	for <linuxppc-dev@ozlabs.org>; Thu, 16 Aug 2007 18:48:20 +0200
Received: from d12av02.megacenter.de.ibm.com (loopback [127.0.0.1])
	by d12av02.megacenter.de.ibm.com (8.12.11.20060308/8.13.3) with ESMTP
	id l7GGmJYJ012345
	for <linuxppc-dev@ozlabs.org>; Thu, 16 Aug 2007 18:48:20 +0200
In-Reply-To: <adatzqz1mjx.fsf@cisco.com>
Subject: Re: [ofa-general] [PATCH 7/7] IB/ehca: Prevent overwriting QP init
	attributes given by caller
To: Roland Dreier <rdreier@cisco.com>
Message-ID: <OF50DCEF62.940E3D7F-ONC1257339.005C150A-C1257339.005C4CA8@de.ibm.com>
From: Hoang-Nam Nguyen <HNGUYEN@de.ibm.com>
Date: Thu, 16 Aug 2007 18:48:18 +0200
MIME-Version: 1.0
Content-type: text/plain; charset=US-ASCII
Cc: Joachim Fenkes <fenkes@de.ibm.com>, linux-kernel@vger.kernel.org,
	openib-general@openib.org, Stefan Roscher <ossrosch@linux.vnet.ibm.com>,
	linuxppc-dev@ozlabs.org, general-bounces@lists.openfabrics.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

general-bounces@lists.openfabrics.org wrote on 16.08.2007 18:17:22:

> I don't understand this patch.  <rdma/ib_verbs.h> says this about
> ib_create_qp():
>
>  * @qp_init_attr: A list of initial attributes required to create the
>  *   QP.  If QP creation succeeds, then the attributes are updated to
>  *   the actual capabilities of the created QP.
>
> So it seems the current code is actually correct and your patch breaks
> it??
Yes. That's absolutely true. Please ignore it.
Thanks!
Nam
