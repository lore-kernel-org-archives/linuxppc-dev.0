Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 9E41DDDF1C
	for <linuxppc-dev@ozlabs.org>; Tue,  2 Oct 2007 18:37:11 +1000 (EST)
Subject: Re: [PATCH 3/4] Simplify rtas_change_msi() error semantics
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: michael@ellerman.id.au
In-Reply-To: <1191310825.6593.21.camel@concordia>
References: <3034ec8fd939bd5cfcdb7ac65206ae2771dc9b2c.1190270165.git.michael@ellerman.id.au>
	<fbd88f287ba9d9ca41b5c8da734afd595ae25922.1190270165.git.michael@ellerman.id.au>
	<1191302603.6310.88.camel@pasglop> <1191304690.6593.8.camel@concordia>
	<1191306253.6310.106.camel@pasglop>
	<1191310825.6593.21.camel@concordia>
Content-Type: text/plain
Date: Tue, 02 Oct 2007 18:37:01 +1000
Message-Id: <1191314221.22572.7.camel@pasglop>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org
Reply-To: benh@kernel.crashing.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On Tue, 2007-10-02 at 17:40 +1000, Michael Ellerman wrote:
> 
> rtas_disable_msi() asks firmware to configure 0 MSIs on the device,
> that
> hopefully succeeds. AFAIK configuring 0 MSIs is as close as we can get
> to disabling MSI via RTAS.
> 
> Perhaps that should also (re)enable INTX?

Not sure... maybe. RTAS doesn't do it ? Then there,s the question of
what happens on machines that don't support INTx ...

Cheers.
Ben.
