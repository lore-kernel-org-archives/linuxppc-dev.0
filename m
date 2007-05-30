Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 3D89FDDFD7
	for <linuxppc-dev@ozlabs.org>; Wed, 30 May 2007 21:18:29 +1000 (EST)
Subject: Re: [PATCH 5/5] Set IDE in ULI1575 to not native mode.
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Kumar Gala <galak@kernel.crashing.org>
In-Reply-To: <A5691757-8218-489B-B809-DE44F81EA5C8@kernel.crashing.org>
References: <11798051102658-git-send-email-wei.zhang@freescale.com>
	<11798051101543-git-send-email-wei.zhang@freescale.com>
	<1179805110272-git-send-email-wei.zhang@freescale.com>
	<1179805110278-git-send-email-wei.zhang@freescale.com>
	<11798051102051-git-send-email-wei.zhang@freescale.com>
	<1179805110284-git-send-email-wei.zhang@freescale.com>
	<A5691757-8218-489B-B809-DE44F81EA5C8@kernel.crashing.org>
Content-Type: text/plain
Date: Wed, 30 May 2007 21:18:16 +1000
Message-Id: <1180523896.19517.248.camel@localhost.localdomain>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org, paulus@samba.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Tue, 2007-05-29 at 15:50 -0500, Kumar Gala wrote:
> 
> > Set IDE in ULI1575 to not 100% native mode, which forces
> > the IDE driver to probe the irq itself.
> >
> > Signed-off-by: Zhang Wei <wei.zhang@freescale.com>
> 
> What causes this to be needed?

Yeah, that looks dodgy. Native mode should generally work better

Ben.
