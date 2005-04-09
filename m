Return-Path: <flar@pants.nu>
Received: from cynthia.pants.nu (adsl-216-102-214-42.dsl.snfc21.pacbell.net
	[216.102.214.42]) by ozlabs.org (Postfix) with ESMTP id 5D35B67B2C
	for <linuxppc-dev@ozlabs.org>; Sun, 10 Apr 2005 02:23:25 +1000 (EST)
Date: Sat, 9 Apr 2005 09:23:22 -0700
From: Brad Boyer <flar@allandria.com>
To: Martin-?ric Racine <q-funk@iki.fi>
Message-ID: <20050409162322.GA23981@pants.nu>
References: <1113006674.9568.414.camel@gaston>
	<Pine.LNX.4.21.0504091309420.18767-100000@hal.pp.fishpool.fi>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <Pine.LNX.4.21.0504091309420.18767-100000@hal.pp.fishpool.fi>
Cc: linuxppc-dev list <linuxppc-dev@ozlabs.org>,
	"debian-powerpc@lists.debian.org" <debian-powerpc@lists.debian.org>
Subject: Re: Sound drivers for newer machines: need help
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Sat, Apr 09, 2005 at 01:12:31PM +0300, Martin-?ric Racine wrote:
> Btw, not sound-related but nonetheless a bug in the device tree:
> 
> /proc/device-tree/psuedo-hid
> 
> That wouldn't be a typo now, would it?

If it is, I suspect it's in your version of the firmware. That isn't
added by the kernel. Here's mine:

dr-xr-xr-x  5 root root 0 Apr  9 09:17 /proc/device-tree/pseudo-hid/

And in OSX, ioreg lists a top level node of pseudo-hid as well. These
are PowerMac7,2 and PowerBook5,2 respectively.

	Brad Boyer
	flar@allandria.com
