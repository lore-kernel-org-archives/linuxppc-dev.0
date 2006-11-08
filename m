Return-Path: <rdreier@cisco.com>
Received: from sj-iport-3.cisco.com (sj-iport-3-in.cisco.com [171.71.176.72])
	by ozlabs.org (Postfix) with ESMTP id 5D81167CC4
	for <linuxppc-dev@ozlabs.org>; Thu,  9 Nov 2006 09:06:45 +1100 (EST)
To: Christoph Raisch <RAISCH@de.ibm.com>
Subject: Re: [PATCH 2.6.19 2/4] ehca: hcp_phyp.c: correct page mapping in 64k
	page mode
References: <OF60EFC2CD.F8FB1D23-ONC1257220.00315F90-C1257220.0038B8E3@de.ibm.com>
From: Roland Dreier <rdreier@cisco.com>
Date: Wed, 08 Nov 2006 14:06:42 -0800
In-Reply-To: <OF60EFC2CD.F8FB1D23-ONC1257220.00315F90-C1257220.0038B8E3@de.ibm.com>
	(Christoph Raisch's message of "Wed, 8 Nov 2006 11:22:27 +0100")
Message-ID: <adaejsdfv9p.fsf@cisco.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: linuxppc-dev@ozlabs.org, linux-kernel@vger.kernel.org,
	openib-general@openib.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

 > We plan to change that as soon as the base kernel can handle mixed
 > pagesizes in a more official way.

OK, so this is just a temporary workaround for powerpc's broken ioremap()?

I'll apply for 2.6.19, and I hope we can back this out in 2.6.20.

 - R.
