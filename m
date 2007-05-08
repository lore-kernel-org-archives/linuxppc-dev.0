Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 409C3DDE36
	for <linuxppc-dev@ozlabs.org>; Wed,  9 May 2007 09:18:04 +1000 (EST)
Subject: Re: [PATCH 1/4] Add support for 750CL Holly board
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Josh Boyer <jwboyer@linux.vnet.ibm.com>
In-Reply-To: <1178306304.3026.231.camel@zod.rchland.ibm.com>
References: <1178302414.3026.202.camel@zod.rchland.ibm.com>
	<1178302469.3026.204.camel@zod.rchland.ibm.com>
	<20070504190140.GA13067@lixom.net>
	<1178306304.3026.231.camel@zod.rchland.ibm.com>
Content-Type: text/plain
Date: Wed, 09 May 2007 09:17:54 +1000
Message-Id: <1178666275.14928.116.camel@localhost.localdomain>
Mime-Version: 1.0
Cc: Olof Johansson <olof@lixom.net>, linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

> > This won't work well if you ever want to build a multiplatform kernel.
> 
> I know.  What do you suggest?  TSI doesn't use phylib, and adding a
> property to specify PHY type in the DT seems like a hack too...

Fix the TSI network driver. PHYs can be probed.

> As a "reg" property perhaps?  I'm not a DT guru, so I was a bit lost as
> to how to fix that up.

Yes, it's common to get the config space address of the "reg" property
of the bridge.

Ben.
