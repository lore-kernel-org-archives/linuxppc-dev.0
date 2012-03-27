Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id 97B83B6EEA
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 27 Mar 2012 17:50:40 +1100 (EST)
Message-ID: <1332831027.2882.55.camel@pasglop>
Subject: Re: [PATCH v2] powerpc+sparc/vio: Modernize driver registration
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: gregkh@linuxfoundation.org
Date: Tue, 27 Mar 2012 17:50:27 +1100
In-Reply-To: <20120327.015316.1552473998755517441.davem@davemloft.net>
References: <1332824790.2882.51.camel@pasglop>
 <20120327.015316.1552473998755517441.davem@davemloft.net>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Cc: key@linux.vnet.ibm.com, linuxppc-dev@lists.ozlabs.org,
 linux-kernel@vger.kernel.org, David Miller <davem@davemloft.net>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, 2012-03-27 at 01:53 -0400, David Miller wrote:
> From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
> Date: Tue, 27 Mar 2012 16:06:30 +1100
> 
> > This makes vio_register_driver() get the module owner & name at compile
> > time like PCI drivers do, and adds a name pointer directly in struct
> > vio_driver to avoid having to explicitly initialize the embedded
> > struct device.
> > 
> > Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>
> 
> Acked-by: David S. Miller <davem@davemloft.net>
> --

Greg, do you want to carry this or should I ? In the later case, I'd
rather send it to Linus now than having it hanging around til the next
merge window :-)

Cheers,
Ben.
