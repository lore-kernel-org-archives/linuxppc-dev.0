Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id E1C33B6F98
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 22 Mar 2012 16:40:13 +1100 (EST)
Message-ID: <1332394796.2982.78.camel@pasglop>
Subject: Re: [PATCH 14/17] powerpc: crypto: nx driver code supporting nx
 encryption
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Greg KH <gregkh@linuxfoundation.org>
Date: Thu, 22 Mar 2012 16:39:56 +1100
In-Reply-To: <20120322033957.GA16914@kroah.com>
References: <1332365297.3858.5.camel@key-ThinkPad-W510>
 <1332366068.3858.50.camel@key-ThinkPad-W510>
 <20120321221517.GB30748@kroah.com> <1332381004.2982.65.camel@pasglop>
 <1332385050.2982.71.camel@pasglop> <20120322033957.GA16914@kroah.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Cc: rcj@linux.vnet.ibm.com, linux-kernel@vger.kernel.org,
 linux-crypto@vger.kernel.org, Kent Yoder <key@linux.vnet.ibm.com>,
 linuxppc-dev@lists.ozlabs.org, David Miller <davem@davemloft.net>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, 2012-03-21 at 20:39 -0700, Greg KH wrote:
> On Thu, Mar 22, 2012 at 01:57:30PM +1100, Benjamin Herrenschmidt wrote:
> > +int __vio_register_driver(struct vio_driver *viodrv, struct module *owner,
> > +			const char *mod_name)
> >  {
> >  	viodrv->driver.bus = &vio_bus_type;
> > +	viodrv->driver.name = viodrv->name;
> > +	viodrv->driver.bus = &vio_bus_type;
> > +	viodrv->driver.owner = owner;
> > +	viodrv->driver.mod_name = mod_name;
> 
> Any reason you set .bus twice?

Nope, just a typo. I'll fix it up, when I have feedback from Dave.

Cheers,
Ben.
