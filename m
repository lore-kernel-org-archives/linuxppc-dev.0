Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id A8A46DDDD8
	for <linuxppc-dev@ozlabs.org>; Wed, 22 Oct 2008 07:50:04 +1100 (EST)
Subject: Re: hugetlbfs for ppc440 - kernel BUG
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Satya <satyakiran@gmail.com>, edi@linux.vnet.ibm.com
In-Reply-To: <acbcf3840707101138t24597799s6511f9326ed2243e@mail.gmail.com>
References: <acbcf3840707101138t24597799s6511f9326ed2243e@mail.gmail.com>
Content-Type: text/plain
Date: Wed, 22 Oct 2008 07:47:43 +1100
Message-Id: <1224622063.7654.265.camel@pasglop>
Mime-Version: 1.0
Cc: kazutomo@mcs.anl.gov, linuxppc-dev@ozlabs.org, david@gibson.dropbear.id.au
Reply-To: benh@kernel.crashing.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Tue, 2007-07-10 at 13:38 -0500, Satya wrote:
> hello,
> I am trying to implement hugetlbfs on the IBM Bluegene/L IO node
> (ppc440) and I have a big problem as well as a few questions to ask
> the group. I patched a 2.6.21.6 linux kernel (manually) with Edi
> Shmueli's hugetlbfs implementation (found here:
> http://patchwork.ozlabs.org/linuxppc/patch?id=8427) for this. I did
> have to make slight changes (described at the end) to make it work.
> My test program is a shortened version of a sys v shared memory
> example described in Documentation/vm/hugetlbpage.txt

Hi !

The patchwork link unfortunately didn't survive the transition to
patchwork 2.

Do you know what's the status of Hugetlb support for 44x ? Is there any
plan to release that for upstream inclusion ?

Cheers,
Ben.
