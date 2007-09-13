Return-Path: <RAISCH@de.ibm.com>
Received: from mtagate4.de.ibm.com (mtagate4.de.ibm.com [195.212.29.153])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mtagate4.de.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 55224DDDF3
	for <linuxppc-dev@ozlabs.org>; Thu, 13 Sep 2007 19:49:39 +1000 (EST)
Received: from d12nrmr1607.megacenter.de.ibm.com
	(d12nrmr1607.megacenter.de.ibm.com [9.149.167.49])
	by mtagate4.de.ibm.com (8.13.8/8.13.8) with ESMTP id l8D9nYYF110902
	for <linuxppc-dev@ozlabs.org>; Thu, 13 Sep 2007 09:49:34 GMT
Received: from d12av04.megacenter.de.ibm.com (d12av04.megacenter.de.ibm.com
	[9.149.165.229])
	by d12nrmr1607.megacenter.de.ibm.com (8.13.8/8.13.8/NCO v8.5) with
	ESMTP id l8D9nXm22326610
	for <linuxppc-dev@ozlabs.org>; Thu, 13 Sep 2007 11:49:33 +0200
Received: from d12av04.megacenter.de.ibm.com (loopback [127.0.0.1])
	by d12av04.megacenter.de.ibm.com (8.12.11.20060308/8.13.3) with ESMTP
	id l8D9nXkx030634
	for <linuxppc-dev@ozlabs.org>; Thu, 13 Sep 2007 11:49:33 +0200
In-Reply-To: <adaps0nmbfa.fsf@cisco.com>
References: <200709121439.32641.fenkes@de.ibm.com> <adaps0nmbfa.fsf@cisco.com>
Subject: Re: [PATCH] IB/ehca: Make sure user pages are from hugetlb before
	using MR large pages
To: Roland Dreier <rdreier@cisco.com>
Message-ID: <OF2700619C.27B6141C-ONC1257355.00353BC8-C1257355.0035DE00@de.ibm.com>
From: Christoph Raisch <RAISCH@de.ibm.com>
Date: Thu, 13 Sep 2007 11:49:19 +0200
MIME-Version: 1.0
Content-type: text/plain; charset=US-ASCII
Cc: Joachim Fenkes <FENKES@de.ibm.com>, OF-EWG <ewg@lists.openfabrics.org>,
	LKML <linux-kernel@vger.kernel.org>,
	LinuxPPC-Dev <linuxppc-dev@ozlabs.org>,
	Hoang-Nam Nguyen <HNGUYEN@de.ibm.com>,
	OF-General <general@lists.openfabrics.org>,
	Stefan Roscher <stefan.roscher@de.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Roland Dreier wrote on 13.09.2007 06:33:45:

>
> Also if someone runs a kernel with 64K pages on a machine where they
> end up being simulated from 4K pages, do you have the same issue with
> the hypervisor ganging together non-contiguous pages?
With todays hypervisor and todays pagesizes and todays MMUs
we don't have this problem if eHCA is enabled.

It is difficult to make predictions about the future,
but that's not specific to driver development. ;-)

>
>  - R.

 - Christoph R.
