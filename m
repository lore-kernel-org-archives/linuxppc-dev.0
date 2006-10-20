Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 184D867B7C
	for <linuxppc-dev@ozlabs.org>; Fri, 20 Oct 2006 13:25:33 +1000 (EST)
Subject: Re: Badness in irq_create_mapping at arch/powerpc/kernel/irq.c:527
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Stephen Rothwell <sfr@canb.auug.org.au>
In-Reply-To: <20061020114749.fe7b71d6.sfr@canb.auug.org.au>
References: <20061019122802.GA26637@aepfle.de> <45377ED3.9030001@bplan-gmbh.de>
	<1161308221.10524.92.camel@localhost.localdomain>
	<20061020114749.fe7b71d6.sfr@canb.auug.org.au>
Content-Type: text/plain
Date: Fri, 20 Oct 2006 13:24:45 +1000
Message-Id: <1161314685.10524.122.camel@localhost.localdomain>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org, Olaf Hering <olaf@aepfle.de>,
	linux-kernel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


> Surely it doesn't need exporting is its only caller is in
> arch/powerpc/platforms/chrp/setup.c?

Today... I can see reasons why platform drivers might want to get at
it, but I can remove the export for now.

Ben.
