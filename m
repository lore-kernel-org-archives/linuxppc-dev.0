Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id D08F9DDDF9
	for <linuxppc-dev@ozlabs.org>; Tue,  8 Jan 2008 10:33:24 +1100 (EST)
Subject: Re: [PATCH][POWERPC] Workaround for iommu page alignment
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: michael@ellerman.id.au
In-Reply-To: <1199745684.7518.25.camel@concordia>
References: <1199742359.6734.14.camel@pasglop>
	<1199745684.7518.25.camel@concordia>
Content-Type: text/plain
Date: Tue, 08 Jan 2008 10:33:01 +1100
Message-Id: <1199748781.6734.18.camel@pasglop>
Mime-Version: 1.0
Cc: linuxppc-dev list <linuxppc-dev@ozlabs.org>,
	Paul Mackerras <paulus@samba.org>,
	Linux Kernel list <linux-kernel@vger.kernel.org>
Reply-To: benh@kernel.crashing.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


> I don't see in the code where you implement the "size > PAGE_SIZE"
> condition. But I only just got back from holidays .. :)

Indeed ... a "quilt ref" was missing :-(

New patch coming ...

Ben.
