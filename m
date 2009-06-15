Return-Path: <benh@kernel.crashing.org>
Received: from ozlabs.org (ozlabs.org [203.10.76.45])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.ozlabs.org",
	Issuer "CA Cert Signing Authority" (verified OK))
	by bilbo.ozlabs.org (Postfix) with ESMTPS id A95AAB7130
	for <linuxppc-dev@lists.ozlabs.org>;
	Tue, 16 Jun 2009 07:23:56 +1000 (EST)
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id E628CDDD0B
	for <linuxppc-dev@ozlabs.org>; Tue, 16 Jun 2009 07:23:55 +1000 (EST)
Subject: Re: [PATCH] powerpc: Add configurable -Werror for arch/powerpc
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: michael@ellerman.id.au
In-Reply-To: <1245069362.8735.15.camel@concordia>
References: <adf502e7c85161d77fdcaca24f55ba6b418c7f04.1244616523.git.michael@ellerman.id.au>
	<1245052241.7705.78.camel@concordia> <1245058807.12400.0.camel@pasglop>
	<1245069362.8735.15.camel@concordia>
Content-Type: text/plain
Date: Tue, 16 Jun 2009 07:23:42 +1000
Message-Id: <1245101022.12400.30.camel@pasglop>
Mime-Version: 1.0
Cc: linuxppc-dev list <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


> Yeah that occured to me, someone with a chrp machine would need to test
> it, do we have one?

Yup, I think we do. I'll check that when I'm in the office.

> > We can have a closer look tomorrow. In any case, stack alloc for that is
> > indeed fishy.
> 
> The obvious patch to make it static doesn't fly because it's called on
> every cpu via a timer, so it needs to be a per-cpu at least I think. Or
> borrow the pseries trick of calling it on each cpu in succession, or
> just borrow the pseries code.

Right.

Cheers,
Ben.
