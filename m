Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id F055DDDF1F
	for <linuxppc-dev@ozlabs.org>; Wed, 30 Jul 2008 07:33:32 +1000 (EST)
Subject: Re: 2.6.27-rc1 problems
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Sean MacLennan <smaclennan@pikatech.com>
In-Reply-To: <20080729140617.7bf16aeb@lappy.seanm.ca>
References: <20080729140617.7bf16aeb@lappy.seanm.ca>
Content-Type: text/plain
Date: Wed, 30 Jul 2008 07:33:05 +1000
Message-Id: <1217367185.11188.260.camel@pasglop>
Mime-Version: 1.0
Cc: linuxppc-dev <linuxppc-dev@ozlabs.org>
Reply-To: benh@kernel.crashing.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Tue, 2008-07-29 at 14:06 -0400, Sean MacLennan wrote:
> I am seeing a lot of problems with 2.6.27-rc1.
> 
> Merge conflicts that make no sense.

Ugh ? Have you done a clean pull ?

> Files missing (tracehook.h).

Looks like your repo isn't sane

> Lots of compile errors.

There's one known due to a PCI patch that went in and broke ppc64 but
that's it I think. I'll a new batch of fixes today.

> Anybody else seeing problems, or is it just me? I am starting
> to wonder if my git repository has gotten corrupted.

Yeah, sounds like it.

Ben.
