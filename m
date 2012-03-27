Return-Path: <davem@davemloft.net>
Received: from shards.monkeyblade.net (shards.monkeyblade.net [198.137.202.13])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id 09364B6EF3
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 27 Mar 2012 16:55:28 +1100 (EST)
Date: Tue, 27 Mar 2012 01:53:16 -0400 (EDT)
Message-Id: <20120327.015316.1552473998755517441.davem@davemloft.net>
To: benh@kernel.crashing.org
Subject: Re: [PATCH v2] powerpc+sparc/vio: Modernize driver registration
From: David Miller <davem@davemloft.net>
In-Reply-To: <1332824790.2882.51.camel@pasglop>
References: <1332824790.2882.51.camel@pasglop>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Cc: gregkh@linuxfoundation.org, key@linux.vnet.ibm.com,
 linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Date: Tue, 27 Mar 2012 16:06:30 +1100

> This makes vio_register_driver() get the module owner & name at compile
> time like PCI drivers do, and adds a name pointer directly in struct
> vio_driver to avoid having to explicitly initialize the embedded
> struct device.
> 
> Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>

Acked-by: David S. Miller <davem@davemloft.net>
