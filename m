Return-Path: <segher@kernel.crashing.org>
Received: from mail-in-03.arcor-online.net (mail-in-03.arcor-online.net
	[151.189.21.43])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.arcor.de",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id C25FADDD0D
	for <linuxppc-dev@ozlabs.org>; Thu, 22 Feb 2007 17:50:12 +1100 (EST)
In-Reply-To: <ee2e907ab59d7aa9b7bf026437419914@kernel.crashing.org>
References: <20070220020837.GF17818@localhost.localdomain>
	<20070220021235.DC02DDDD06@ozlabs.org>
	<9696D7A991D0824DBA8DFAC74A9C5FA302A58C89@az33exm25.fsl.freescale.net>
	<ee2e907ab59d7aa9b7bf026437419914@kernel.crashing.org>
Mime-Version: 1.0 (Apple Message framework v623)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <2b8d25463127d2c665da879c0ec234e2@kernel.crashing.org>
From: Segher Boessenkool <segher@kernel.crashing.org>
Subject: Re: [PATCH 12/14] Add device tree for Ebony
Date: Thu, 22 Feb 2007 07:49:53 +0100
To: Segher Boessenkool <segher@kernel.crashing.org>
Cc: linuxppc-dev@ozlabs.org, Yoder Stuart-B08248 <stuart.yoder@freescale.com>,
	David Gibson <david@gibson.dropbear.id.au>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

>> Since UIC1 is cascaded off UIC0 in the interrupt tree,
>> UIC1 should have an interrupt-parent pointing to UIC0
>> so the interrupt tree can be traversed to the root.
>
> Not necessary if UIC0 is the device tree parent of UIC1.

For the archives: this is wrong, all interrupt controllers
(except the root one) are required to have an "interrupt-parent"
property -- this is how the root interrupt controller is
determined.


Segher
