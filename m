Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 7D1E0DDEDE
	for <linuxppc-dev@ozlabs.org>; Wed, 23 Apr 2008 20:34:44 +1000 (EST)
Subject: Re: [Linux-fbdev-devel] [PATCH 1/3] radeonfb: Fix 64 bits
	resources on 32 bits archs
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: David Miller <davem@davemloft.net>
In-Reply-To: <20080423.025721.50367920.davem@davemloft.net>
References: <480E0A54.9010203@linux.vnet.ibm.com>
	<1208902903.9640.138.camel@pasglop>
	<1208943127.5632.324.camel@thor.sulgenrain.local>
	<20080423.025721.50367920.davem@davemloft.net>
Content-Type: text/plain
Date: Wed, 23 Apr 2008 20:34:21 +1000
Message-Id: <1208946861.9060.30.camel@pasglop>
Mime-Version: 1.0
Cc: linux-fbdev-devel@lists.sourceforge.net, adaplas@gmail.com,
	hollisb@us.ibm.com, linux-kernel@vger.kernel.org,
	michel@tungstengraphics.com, linuxppc-dev@ozlabs.org,
	akpm@linux-foundation.org, dzu@denx.de
Reply-To: benh@kernel.crashing.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On Wed, 2008-04-23 at 02:57 -0700, David Miller wrote:
> > It's up to the driver, and again, the current radeon driver doesn't
> use
> > radeonfb at all anymore...
> 
> The only portable thing is for X to use the PCI sysfs mmap() stuff,
> which current Xorg servers using libpciaccess do.
> 
> I know because I'm typing this from a sparc64 using a Radeon
> with current Xorg :-)

True :-) But I'd still like to fix the fb API for the sake of things
like directfb etc...

Ben.
