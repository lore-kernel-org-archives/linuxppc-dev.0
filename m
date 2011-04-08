Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 4C10FB6F7C
	for <linuxppc-dev@ozlabs.org>; Fri,  8 Apr 2011 19:12:18 +1000 (EST)
From: Kumar Gala <galak@kernel.crashing.org>
Content-Type: text/plain; charset=us-ascii
Subject: platform_driver/of_platform_driver compile warning in fsldma.c
Date: Fri, 8 Apr 2011 04:12:13 -0500
Message-Id: <D4BE3D54-805B-4D4F-B8BC-EC1A860C8E84@kernel.crashing.org>
To: Grant Likely <grant.likely@secretlab.ca>
Mime-Version: 1.0 (Apple Message framework v1084)
Cc: Linuxppc-dev list <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Grant,

I'm being lazy, can you give any quick insight on the following compile =
warning:

drivers/dma/fsldma.c:1457:2: warning: initialization from incompatible =
pointer type
drivers/dma/fsldma.c: In function 'fsldma_init':
drivers/dma/fsldma.c:1468:2: warning: passing argument 1 of =
'platform_driver_register' from incompatible pointer type
include/linux/platform_device.h:124:12: note: expected 'struct =
platform_driver *' but argument is of type 'struct of_platform_driver *'
drivers/dma/fsldma.c: In function 'fsldma_exit':
drivers/dma/fsldma.c:1473:2: warning: passing argument 1 of =
'platform_driver_unregister' from incompatible pointer type
include/linux/platform_device.h:125:13: note: expected 'struct =
platform_driver *' but argument is of type 'struct of_platform_driver *'

- k=
