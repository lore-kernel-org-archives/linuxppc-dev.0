Return-Path: <stephen.neuendorffer@xilinx.com>
Received: from outbound9-dub-R.bigfish.com (outbound-dub.frontbridge.com
	[213.199.154.16])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "*.bigfish.com", Issuer "*.bigfish.com" (not verified))
	by ozlabs.org (Postfix) with ESMTP id 38B38DE0C4
	for <linuxppc-dev@ozlabs.org>; Sat, 16 Feb 2008 04:08:50 +1100 (EST)
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Subject: RE: [PATCH] booting-without-of: add Xilinx uart 16550.
Date: Fri, 15 Feb 2008 09:08:42 -0800
In-Reply-To: <47B59631.10908@ru.mvista.com>
References: <47B59631.10908@ru.mvista.com>
From: "Stephen Neuendorffer" <stephen.neuendorffer@xilinx.com>
To: "Pavel Kiryukhin" <pkiryukhin@ru.mvista.com>,
	<linuxppc-dev@ozlabs.org>
Message-Id: <20080215170844.9D21610081@mail40-dub.bigfish.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


> +       - reg-shift : registers offset shift (standard uart_port
field).
> +         Property is optional if regshift is zero.

I was hoping to get an idea of what is required here, or when I might
use it?

It looks like the ARCH=3Dppc code instantiates this with a reg-shift of
2...  Is this the expected value?  When would it be not zero? or not
two?

Steve
