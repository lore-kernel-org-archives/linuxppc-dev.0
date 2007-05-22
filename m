Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 89F3CDDE3F
	for <linuxppc-dev@ozlabs.org>; Wed, 23 May 2007 09:28:37 +1000 (EST)
Subject: Re: [PATCH/RFC] Rework ptep_set_access_flags and fix sun4c
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Mark Fortescue <mark@mtfhpc.demon.co.uk>
In-Reply-To: <Pine.LNX.4.61.0705222247010.5890@mtfhpc.demon.co.uk>
References: <Pine.LNX.4.61.0705012354290.12808@mtfhpc.demon.co.uk>
	<20070509231937.ea254c26.akpm@linux-foundation.org>
	<1178778583.14928.210.camel@localhost.localdomain>
	<20070510.001234.126579706.davem@davemloft.net>
	<Pine.LNX.4.64.0705142018090.18453@blonde.wat.veritas.com>
	<1179176845.32247.107.camel@localhost.localdomain>
	<1179212184.32247.163.camel@localhost.localdomain>
	<1179757647.6254.235.camel@localhost.localdomain>
	<1179815339.32247.799.camel@localhost.localdomain>
	<Pine.LNX.4.61.0705222247010.5890@mtfhpc.demon.co.uk>
Content-Type: text/plain
Date: Wed, 23 May 2007 09:28:14 +1000
Message-Id: <1179876494.32247.887.camel@localhost.localdomain>
Mime-Version: 1.0
Cc: linux-mm@kvack.org, wli@holomorphy.com, linuxppc-dev@ozlabs.org,
	andrea@suse.de, "Tom \"spot\" Callaway" <tcallawa@redhat.com>,
	sparclinux@vger.kernel.org, Hugh Dickins <hugh@veritas.com>,
	akpm@linux-foundation.org, David Miller <davem@davemloft.net>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Tue, 2007-05-22 at 22:52 +0100, Mark Fortescue wrote:
> Hi Benjamin,
> 
> I have just tested this patch on my Sun4c Sparcstation 1 using my 2.6.20.9 
> test kernel without any problems.
> 
> Thank you for the work.

Wow, there is more than one user of these still ! :-)

Cheers,
Ben.
