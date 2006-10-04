Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 7693567CB9
	for <linuxppc-dev@ozlabs.org>; Wed,  4 Oct 2006 15:52:41 +1000 (EST)
Subject: Re: [PATCH 10/11] Add MPC8360EMDS board support
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Dan Malek <dan@embeddedalley.com>
In-Reply-To: <CE624A83-809E-4180-800E-660A578FFCFC@embeddedalley.com>
References: <20060927155626.4d5ca19c@vitb.ru.mvista.com>
	<4879B0C6C249214CBE7AB04453F84E4D19D865@zch01exm20.fsl.freescale.net>
	<20060927165556.04c8d5d7@vitb.ru.mvista.com>
	<CE624A83-809E-4180-800E-660A578FFCFC@embeddedalley.com>
Content-Type: text/plain
Date: Wed, 04 Oct 2006 15:52:27 +1000
Message-Id: <1159941148.13323.6.camel@localhost.localdomain>
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


> I still think an embedded_feature_call() support in a
> board port would be the best solution to many of these
> complex things we are trying to define in this device
> tree information.  In the places where we need some
> kind of board specific support, like hardware set up for
> some peripheral, just do the feature_call, passing enough
> information to indicate what is needed, and let the
> board support do what is necessary.  This could be
> setting bits in a BCSR, setting up the processor IO
> ports, enabling power to external logic, etc.  This has
> been proven to work well on the PMAC, just extend it
> to be used on embedded boards.

I don't see how a mecanism of feature call at the board support level is
in any way incompatible with the device-tree thing. I'm happy mixing
both on powermac :)

Ben.
