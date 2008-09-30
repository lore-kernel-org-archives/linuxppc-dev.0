Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 746E7DDE07
	for <linuxppc-dev@ozlabs.org>; Tue, 30 Sep 2008 17:21:38 +1000 (EST)
Subject: Re: New dma-noncoherent code, looking for comment and people to test
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Kumar Gala <galak@kernel.crashing.org>
In-Reply-To: <77D91812-7338-462D-8361-A9A55869D515@kernel.crashing.org>
References: <1222709165.8628.4.camel@pcds-ts102.slac.stanford.edu>
	<77D91812-7338-462D-8361-A9A55869D515@kernel.crashing.org>
Content-Type: text/plain
Date: Tue, 30 Sep 2008 17:21:30 +1000
Message-Id: <1222759290.9006.47.camel@pasglop>
Mime-Version: 1.0
Cc: Linux PPC <linuxppc-dev@ozlabs.org>,
	Remi Machet <rmachet@slac.stanford.edu>
Reply-To: benh@kernel.crashing.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Mon, 2008-09-29 at 13:03 -0500, Kumar Gala wrote:
> 
> We really should change this code over to the new dma changes Becky's  
> introduced so we just have a non-coherent set of DMA ops (thus we can  
> do both non-coherent and coherent in the same system).

Yes :-)

Ben.
