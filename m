Return-Path: <kou.ishizaki@toshiba.co.jp>
Received: from imx12.toshiba.co.jp (imx12.toshiba.co.jp [61.202.160.132])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 615D467BE6
	for <linuxppc-dev@ozlabs.org>; Fri, 17 Nov 2006 21:42:56 +1100 (EST)
Date: Fri, 17 Nov 2006 19:42:46 +0900 (JST)
Message-Id: <200611171042.kAHAglOl000686@toshiba.co.jp>
To: arnd@arndb.de
Subject: Re: [PATCH 16/16] Supporting spidernet on Celleb
In-Reply-To: <200611161115.49183.arnd@arndb.de>
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

Hi Arnd-san,

Thank you for commenting.

>This should not be required. If you PCI bus is set up
>correctly, pci_device_to_OF_node() will do the right thing.
>What problem are you trying to solve here?

Now we have no problem about that. We'll remove this change.

>You should not need a cast here. It's better to cast the data value
>in the function itself than casting the function pointer. This makes
>sure we notice when the prototype of the function pointer changes.

We'll change the code as you commented.

>   Arnd <><


Thank you,
Kou Ishizaki
Toshiba
