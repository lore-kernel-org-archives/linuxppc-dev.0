Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id C10DCB6F0F
	for <linuxppc-dev@ozlabs.org>; Fri, 11 Dec 2009 07:56:53 +1100 (EST)
Subject: Re: Floating point in the kernel
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Sean MacLennan <smaclennan@pikatech.com>
In-Reply-To: <20091210153359.3a480488@lappy.seanm.ca>
References: <20091210131311.78cab78c@lappy.seanm.ca>
	<1260476379.16132.224.camel@pasglop>
	<20091210153359.3a480488@lappy.seanm.ca>
Content-Type: text/plain; charset="UTF-8"
Date: Fri, 11 Dec 2009 07:56:48 +1100
Message-ID: <1260478608.16132.263.camel@pasglop>
Mime-Version: 1.0
Cc: linuxppc-dev <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, 2009-12-10 at 15:33 -0500, Sean MacLennan wrote:
> To be honest, I can't find *why* we are scheduling :( They only way we
> give up the CPU is with locking... and none of the locks where hit
> during the problem. We also never get near our timeslice... the
> longest
> run I saw when the problem happened was 670us. 
> 
> Is there a way to disable scheduling? We currently do not have preempt
> enabled... but may in the future.

Well, that would be interesting to see where you schedule indeed.

Outside of preempt and an explicit lock or memory allocation I don't
see ... Or get/put_user ?

Cheers,
Ben.
