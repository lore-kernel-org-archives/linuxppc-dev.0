Return-Path: <ak@suse.de>
Received: from mx2.suse.de (mx2.suse.de [195.135.220.15])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx2.suse.de",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id B01C867B53
	for <linuxppc-dev@ozlabs.org>; Wed, 30 Aug 2006 17:32:24 +1000 (EST)
From: Andi Kleen <ak@suse.de>
To: Nishanth Aravamudan <nacc@us.ibm.com>
Subject: Re: libnuma interleaving oddness
Date: Wed, 30 Aug 2006 09:32:23 +0200
References: <20060829231545.GY5195@us.ibm.com> <200608300919.13125.ak@suse.de>
	<20060830072948.GE5195@us.ibm.com>
In-Reply-To: <20060830072948.GE5195@us.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200608300932.23746.ak@suse.de>
Cc: linuxppc-dev@ozlabs.org, linux-mm@kvack.org, lnxninja@us.ibm.com,
	Christoph Lameter <clameter@sgi.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Wednesday 30 August 2006 09:29, Nishanth Aravamudan wrote:

> 
> > Hmm, maybe mlock() policy() is broken.
> 
> I took out the mlock() call, and I get the same results, FWIW.

Then it's probably some new problem in hugetlbfs. Does it work with shmfs?

The regression test for hugetlbfs is numactl is unfortunately still disabled.
I need to enable it at some point for hugetlbfs now that it reached mainline.

-Andi
