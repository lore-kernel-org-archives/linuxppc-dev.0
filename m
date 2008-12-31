Return-Path: <rdreier@cisco.com>
Received: from sj-iport-4.cisco.com (sj-iport-4.cisco.com [171.68.10.86])
	(using TLSv1 with cipher RC4-SHA (128/128 bits))
	(Client CN "sj-iport-4.cisco.com", Issuer "Cisco SSCA" (not verified))
	by ozlabs.org (Postfix) with ESMTPS id 71506DDE20
	for <linuxppc-dev@ozlabs.org>; Wed, 31 Dec 2008 15:20:35 +1100 (EST)
From: Roland Dreier <rdreier@cisco.com>
To: Stephen Rothwell <sfr@canb.auug.org.au>
Subject: Re: [PATCH] infiniband/ehca: spin_lock_irqsave takes an unsigned long
References: <20081231141257.9bafac41.sfr@canb.auug.org.au>
Date: Tue, 30 Dec 2008 20:20:29 -0800
In-Reply-To: <20081231141257.9bafac41.sfr@canb.auug.org.au> (Stephen
	Rothwell's message of "Wed, 31 Dec 2008 14:12:57 +1100")
Message-ID: <adaiqp1q8ky.fsf@cisco.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Heiko J Schick <schickhj@de.ibm.com>, Joachim Fenkes <fenkes@de.ibm.com>,
	ppc-dev <linuxppc-dev@ozlabs.org>, Christoph Raisch <raisch@de.ibm.com>,
	general@lists.openfabrics.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

are you trying to land the 'typedef unsigned long u64' change for
2.6.28, or can these patches wait for 2.6.29?

 - R.
