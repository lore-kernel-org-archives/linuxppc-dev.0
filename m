Return-Path: <segher@kernel.crashing.org>
Received: from mail-in-05.arcor-online.net (mail-in-05.arcor-online.net
	[151.189.21.45])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.arcor.de",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 2EB3ADDEC1
	for <linuxppc-dev@ozlabs.org>; Sat, 20 Jan 2007 03:50:55 +1100 (EST)
In-Reply-To: <9696D7A991D0824DBA8DFAC74A9C5FA3023612F8@az33exm25.fsl.freescale.net>
References: <9696D7A991D0824DBA8DFAC74A9C5FA3023612F8@az33exm25.fsl.freescale.net>
Mime-Version: 1.0 (Apple Message framework v752.2)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <FE40A29F-24D1-4DDA-81F0-3F87AF30F4F9@kernel.crashing.org>
From: Segher Boessenkool <segher@kernel.crashing.org>
Subject: Re: Discussion on SOC device tree bindings
Date: Fri, 19 Jan 2007 17:50:32 +0100
To: "Yoder Stuart-B08248" <stuart.yoder@freescale.com>
Cc: linuxppc-dev Development <linuxppc-dev@ozlabs.org>,
	Sven Luther <sven@genesi-usa.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

> How about linking in _both_ directions?
>
> -The SOC node describes the shared register with links to the
>  the device nodes it is associated with

This provides all the information you need.

> -The device nodes link to the SOC parent shared register node
> (_but_ don't necessarily specify the device index, since that
>  could be determined by looking at the SOC node)

This information, if handy for the kernel to have, can
be trivially constructed at initialisation time by the
kernel itself.

> Doing both provides flexibility in the way the device tree
> is used.

That flexibility is already there if you describe
everything in the controller node.

> The SOC node in a single place describes the
> shared register which conceptually makes sense.

Exactly.


Segher
