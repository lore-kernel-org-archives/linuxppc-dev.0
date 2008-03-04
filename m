Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 521C8DDE42
	for <linuxppc-dev@ozlabs.org>; Tue,  4 Mar 2008 12:44:06 +1100 (EST)
Subject: Re: Bamboo PCI interrupt issues
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: David Gibson <dwg@au1.ibm.com>
In-Reply-To: <20080304005922.GB1393@localhost.localdomain>
References: <1204588953.7921.13.camel@basalt>
	<20080304005922.GB1393@localhost.localdomain>
Content-Type: text/plain
Date: Tue, 04 Mar 2008 12:42:47 +1100
Message-Id: <1204594967.21545.46.camel@pasglop>
Mime-Version: 1.0
Cc: kvm-ppc-devel <kvm-ppc-devel@lists.sourceforge.net>,
	linuxppc-dev <linuxppc-dev@ozlabs.org>,
	Hollis Blanchard <hollisb@us.ibm.com>
Reply-To: benh@kernel.crashing.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On Tue, 2008-03-04 at 11:59 +1100, David Gibson wrote:
> 
> Uh.. there's no binding written down, it's just encoded into uic.c.
> But UIC doesn't use OpenPIC sensitivity encoding.  Like FSL's IPIC, it
> uses Linux IRQ_TYPE values from include/linux/irq.h which makes 8
> "level sensitive, active-low".

On a related note: aren't we taking a risk here of seeing those values
change in linux ?

Ben.
