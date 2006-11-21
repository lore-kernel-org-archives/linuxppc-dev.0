Return-Path: <kou.ishizaki@toshiba.co.jp>
Received: from imx12.toshiba.co.jp (imx12.toshiba.co.jp [61.202.160.132])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 44EE767CA0
	for <linuxppc-dev@ozlabs.org>; Wed, 22 Nov 2006 00:43:03 +1100 (EST)
Date: Tue, 21 Nov 2006 22:42:49 +0900 (JST)
Message-Id: <200611211342.kALDgoL3001797@toshiba.co.jp>
To: arnd@arndb.de
Subject: Re: [PATCH 2/16] add hypervisor support for SPU
In-Reply-To: <200611172228.02576.arnd@arndb.de>
From: Ishizaki Kou <kou.ishizaki@toshiba.co.jp>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Arnd-san,

> On Friday 17 November 2006 11:33, Ishizaki Kou wrote:
> > We don't think that standard binding for SPE exists. Do you have any
> > proposal? If you have, please send us your binding.
> >
> > On our device tree, property "reg" has unit number. Addresses are in
> > property "priv2", "problem" and "local-store". Because of LPAR
> > environment, property "priv1" does not exist.
> 
> Unfortunately, we don't have any official binding documents for this,
> but you can look at how both methods are used in the source code now.
> 
> There should not be any priv2, problem or local-store properties
> any more. We have chosen the order of these register areas in the
> "reg" property to be "local-store", "problem", "priv2", "priv1",
> where the last one is optional so you don't need to provide one
> in a hypervisor.
> 
> Similarly, there should no longer be a single "isrc" property,
> but rather a standard "interrupts" property with three values
> that can be mapped to an interrupt number each, for class
> 0, 1 and 2 interrupts.

Please tell us a little more.

Where is unit number on your device-tree?
What encoding is used for it?
How many cells does it use?


Thank you,
Kou Ishizaki
Toshiba
