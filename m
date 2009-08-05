Return-Path: <galak@kernel.crashing.org>
Received: from ozlabs.org (ozlabs.org [203.10.76.45])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.ozlabs.org",
	Issuer "CA Cert Signing Authority" (verified OK))
	by bilbo.ozlabs.org (Postfix) with ESMTPS id DF04DB70AD
	for <linuxppc-dev@lists.ozlabs.org>;
	Thu,  6 Aug 2009 00:35:47 +1000 (EST)
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 353D1DDD04
	for <linuxppc-dev@ozlabs.org>; Thu,  6 Aug 2009 00:35:46 +1000 (EST)
Message-Id: <E0A64FA0-C835-4361-A203-E9CB5377599C@kernel.crashing.org>
From: Kumar Gala <galak@kernel.crashing.org>
To: Sachin Sant <sachinp@in.ibm.com>
In-Reply-To: <4A706504.6040704@in.ibm.com>
Content-Type: text/plain; charset=US-ASCII; format=flowed
Mime-Version: 1.0 (Apple Message framework v935.3)
Subject: Re: Next July 29 : Hugetlb test failure (OOPS free_hugepte_range)
Date: Wed, 5 Aug 2009 09:35:20 -0500
References: <20090729173611.b82478cd.sfr@canb.auug.org.au>
	<4A706504.6040704@in.ibm.com>
Cc: Stephen Rothwell <sfr@canb.auug.org.au>, linux-next@vger.kernel.org,
	linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


On Jul 29, 2009, at 10:04 AM, Sachin Sant wrote:

> While executing hugetlb tests against today's Next tree on
> a Power 6 box came across following OOPS.

out of interest what tests are you running for hugetlb?

- k
