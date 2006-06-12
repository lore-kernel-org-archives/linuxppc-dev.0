Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id ECD6F67B28
	for <linuxppc-dev@ozlabs.org>; Mon, 12 Jun 2006 14:22:54 +1000 (EST)
Subject: RE: [PATCH 2/10 v2] Add the MPC8641 HPCN platform files.
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Zhang Wei-r63237 <Wei.Zhang@freescale.com>
In-Reply-To: <9FCDBA58F226D911B202000BDBAD4673069759E4@zch01exm40.ap.freescale.net>
References: <9FCDBA58F226D911B202000BDBAD4673069759E4@zch01exm40.ap.freescale.net>
Content-Type: text/plain
Date: Mon, 12 Jun 2006 14:22:36 +1000
Message-Id: <1150086156.11798.0.camel@localhost.localdomain>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org, Jon Loeliger <jdl@jdl.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


> Re-ordering the interrupt is just fit for the practice from MPC85xx platform 
> and legacy OpenPIC interrupts order. We put 16 i8259 interrupts to first 0-15
> Position, 48 MPC86xx processor internel interrupts to 16-63 and 16 MPC86xx 
> External interrupts to 64-79.

I'd rather keep the openpic sources in a single row then... with the new
stuff that I'm trying to finish in time for 2.6.18 (well... maybe),
re-numbering will be handled for you by the core and 8259 will always
have 0...15 reserved.

Ben.
