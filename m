Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 915FCB7E72
	for <linuxppc-dev@ozlabs.org>; Fri, 14 May 2010 14:19:17 +1000 (EST)
Subject: Re: [PATCH] pte_fsl_booke: fix instruction TLB error permission check
Mime-Version: 1.0 (Apple Message framework v1078)
Content-Type: text/plain; charset=us-ascii
From: Kumar Gala <galak@kernel.crashing.org>
In-Reply-To: <1273808175.21352.481.camel@pasglop>
Date: Thu, 13 May 2010 23:19:03 -0500
Message-Id: <53340213-C85D-41CB-8E25-4DF972985035@kernel.crashing.org>
References: <1273221514-8683-1-git-send-email-leoli@freescale.com>
	<0710E9DF-66DF-4D24-95DE-A04E6D869826@kernel.crashing.org>
	<1273808175.21352.481.camel@pasglop>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: linuxppc-dev@ozlabs.org, Jin Qing <b24347@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


On May 13, 2010, at 10:36 PM, Benjamin Herrenschmidt wrote:

> On Thu, 2010-05-13 at 14:14 -0500, Kumar Gala wrote:
>> On May 7, 2010, at 3:38 AM, Li Yang wrote:
>>=20
>>> Check the user/supervisor execution permission base on the code =
address.
>>> This fixes the following oops on module loading or removing.
>>>=20
>>> Unable to handle kernel paging request for instruction fetch
>>> Faulting instruction address: 0xf938d040
>>> Oops: Kernel access of bad area, sig: 11 [#1]
>>>=20
>>> Signed-off-by: Li Yang <leoli@freescale.com>
>>> Signed-off-by: Jin Qing <b24347@freescale.com>
>>> ---
>>> arch/powerpc/kernel/head_fsl_booke.S |   13 ++++++++++---
>>> 1 files changed, 10 insertions(+), 3 deletions(-)
>>=20
>> applied to merge.
>>=20
>> I've updated the commit message to be a bit more clear on why we need =
to do this.
>>=20
>> Thanks for figuring this out.
>=20
> Should I pull & send to Linus ?

No, I've got another patch to fix a FTRACE issue with SMP CPU bringup.  =
Will post a tree for you here shortly.

- k=
