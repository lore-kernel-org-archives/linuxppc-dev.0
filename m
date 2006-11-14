Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 95D3D67FA6
	for <linuxppc-dev@ozlabs.org>; Tue, 14 Nov 2006 14:03:04 +1100 (EST)
Subject: Re: [PATCH/RFC] powerpc: Fix mmap of PCI resource with hack for X
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Ian Romanick <idr@us.ibm.com>
In-Reply-To: <455926C0.9080906@us.ibm.com>
References: <1163405790.4982.289.camel@localhost.localdomain>
	<20061113.163138.98554015.davem@davemloft.net>
	<455926C0.9080906@us.ibm.com>
Content-Type: text/plain
Date: Tue, 14 Nov 2006 14:02:51 +1100
Message-Id: <1163473371.5940.84.camel@localhost.localdomain>
Mime-Version: 1.0
Cc: linux-kernel@vger.kernel.org, linuxppc-dev@ozlabs.org, paulus@samba.org,
	anton@samba.org, airlied@gmail.com, David Miller <davem@davemloft.net>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


> > So the gist of your change is that X isn't obtaining BAR values
> > in the correct context on powerpc, and so you're going to hack up
> > the "devices" files output to "help" X out.
> > 
> > This doesn't sound sane to me.
> 
> It doesn't sound terribly sane to me.  What's wrong with just opening
> /sys/bus/pci/devices/*/resource[0-5]?  It seems like that solves all the
> problems.

We have to, that's how we get current X to work. Of course it will be
much better once X uses sysfs, no question about that.

Ben.
