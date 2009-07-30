Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by bilbo.ozlabs.org (Postfix) with ESMTPS id 5B272B7B7D
	for <linuxppc-dev@lists.ozlabs.org>;
	Thu, 30 Jul 2009 10:52:38 +1000 (EST)
Subject: Re: BUG in dma-mapping.h:218 // MESH SCSI driver not working
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Stef Simoens <stef.simoens@scarlet.be>
In-Reply-To: <4A70DE54.5090406@scarlet.be>
References: <4A68E1CE.4040307@scarlet.be>
	<1248425553.25467.20.camel@pasglop>  <4A70937B.7040201@scarlet.be>
	<1248910358.1509.27.camel@pasglop>  <4A70DE54.5090406@scarlet.be>
Content-Type: text/plain
Date: Thu, 30 Jul 2009 10:52:29 +1000
Message-Id: <1248915149.1509.29.camel@pasglop>
Mime-Version: 1.0
Cc: linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, 2009-07-30 at 01:42 +0200, Stef Simoens wrote:
> What would be the best approach?
> - if the kernel boots, it's obviously 'good'
> - but what if the kernel hits the 'BUG', should I apply your patch
> then? If it doesn't work with your patch, would it be 'bad' then? 

Yes.

> > One thing I know is that the MESH HW has "issues" that make it very
> > sensitive to alignment DMA buffers, it's possible that the SCSI stack no
> > longer aligns some stuff ?
> >   
> Hmm, great... how can I verify this? 

I will once we get a closer idea of where the bug started to happen.

Thanks !

Cheers,
Ben.
