Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 3387C67A8A
	for <linuxppc-dev@ozlabs.org>; Thu, 20 Jan 2005 10:26:55 +1100 (EST)
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: David Woodhouse <dwmw2@infradead.org>
In-Reply-To: <1106146083.26551.526.camel@hades.cambridge.redhat.com>
References: <1106120622.10851.42.camel@baythorne.infradead.org>
	<BD84893E-6A28-11D9-AC28-000393DBC2E8@freescale.com>
	<1106146083.26551.526.camel@hades.cambridge.redhat.com>
Content-Type: text/plain
Date: Thu, 20 Jan 2005 10:25:29 +1100
Message-Id: <1106177129.5327.43.camel@gaston>
Mime-Version: 1.0
Cc: "H. Peter Anvin" <hpa@zytor.com>,
	Linux Kernel list <linux-kernel@vger.kernel.org>,
	linuxppc-dev list <linuxppc-dev@ozlabs.org>,
	Linus Torvalds <torvalds@osdl.org>, Paul Mackerras <paulus@samba.org>
Subject: Re: [PATCH] raid6: altivec support
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Wed, 2005-01-19 at 14:48 +0000, David Woodhouse wrote:
> On Wed, 2005-01-19 at 08:45 -0600, Kumar Gala wrote:
> > We did talk about looking at using some work Ben did in ppc64 with OF 
> > in ppc32.  John Masters was looking into this, but I havent heard much
> > from him on it lately.
> > 
> > The firmware interface on the ppc32 embedded side is some what broken 
> > in my mind.
> 
> The binary structure which changes every few weeks and which is shared
> between the bootloader and the kernel? Yeah, "somewhat broken" is one
> way of putting it :)
> 
> The ARM kernel does it a lot better with tag,value pairs.

And ppc64 adds a flattened device-tree format, even better imho :)

Ben.
