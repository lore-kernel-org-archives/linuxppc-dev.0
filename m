Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 3372C67BC8
	for <linuxppc-dev@ozlabs.org>; Fri, 17 Nov 2006 11:39:58 +1100 (EST)
Subject: Re: [PATCH 7/16] powerpc: add support for ps3 platform
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Christoph Hellwig <hch@lst.de>
In-Reply-To: <20061115180440.GB18856@lst.de>
References: <4554DACB.8060809@am.sony.com>  <20061115180440.GB18856@lst.de>
Content-Type: text/plain
Date: Fri, 17 Nov 2006 11:39:44 +1100
Message-Id: <1163723984.5940.411.camel@localhost.localdomain>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org, Paul Mackerras <paulus@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


> > +
> > +enum page_size {
> > +	page_size_4k = 12U,
> > +	page_size_64k = 16U,
> > +	page_size_16m = 24U,
> > +};
> 
> Please use ALL_CAPS for such constants.

And call them PAGE_SHIFT_* while at it :-)

Ben.
