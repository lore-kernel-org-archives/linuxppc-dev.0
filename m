Return-Path: <benh@kernel.crashing.org>
Received: from ozlabs.org (ozlabs.org [203.10.76.45])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.ozlabs.org",
	Issuer "CA Cert Signing Authority" (verified OK))
	by bilbo.ozlabs.org (Postfix) with ESMTPS id 07282B7080
	for <linuxppc-dev@lists.ozlabs.org>;
	Thu, 16 Jul 2009 13:41:32 +1000 (EST)
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 56123DDD1C
	for <linuxppc-dev@ozlabs.org>; Thu, 16 Jul 2009 13:41:31 +1000 (EST)
Subject: Re: [PATCH 04/15] swiotlb: remove unnecessary swiotlb_bus_to_virt
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Becky Bruce <beckyb@kernel.crashing.org>
In-Reply-To: <5E909C02-3FA2-4BEB-8C73-F4E4A5A404BF@kernel.crashing.org>
References: <1247187904-31999-1-git-send-email-fujita.tomonori@lab.ntt.co.jp>
	<1247187904-31999-5-git-send-email-fujita.tomonori@lab.ntt.co.jp>
	<5E909C02-3FA2-4BEB-8C73-F4E4A5A404BF@kernel.crashing.org>
Content-Type: text/plain
Date: Thu, 16 Jul 2009 13:40:18 +1000
Message-Id: <1247715618.27937.36.camel@pasglop>
Mime-Version: 1.0
Cc: tony.luck@intel.com, linux-ia64@vger.kernel.org, x86@kernel.org,
	linux-kernel@vger.kernel.org,
	FUJITA Tomonori <fujita.tomonori@lab.ntt.co.jp>, linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, 2009-07-13 at 21:17 -0500, Becky Bruce wrote:
> 
> phys_to_virt (also, virt_to_phys) is invalid for highmem addresses on  
> ppc. 

I would be surprised if x86 was any different here. Most of our highmem
implementation comes straight from x86 :-)

Cheers,
Ben.
