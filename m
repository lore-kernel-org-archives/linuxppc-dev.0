Return-Path: <jonathan@jonmasters.org>
Received: from smtp.mailbox.co.uk (smtp.mailbox.net.uk [195.82.125.32])
	by ozlabs.org (Postfix) with ESMTP id D16CD67A79
	for <linuxppc-dev@ozlabs.org>; Thu, 20 Jan 2005 06:37:16 +1100 (EST)
Message-ID: <41EEA1C7.7060802@jonmasters.org>
Date: Wed, 19 Jan 2005 18:07:03 +0000
From: Jon Masters <jonathan@jonmasters.org>
MIME-Version: 1.0
To: Kumar Gala <kumar.gala@freescale.com>
References: <1106120622.10851.42.camel@baythorne.infradead.org>
	<BD84893E-6A28-11D9-AC28-000393DBC2E8@freescale.com>
In-Reply-To: <BD84893E-6A28-11D9-AC28-000393DBC2E8@freescale.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: Linux Kernel list <linux-kernel@vger.kernel.org>,
	linuxppc-dev list <linuxppc-dev@ozlabs.org>,
	Linus Torvalds <torvalds@osdl.org>, Paul Mackerras <paulus@samba.org>,
	"H. Peter Anvin" <hpa@zytor.com>, David Woodhouse <dwmw2@infradead.org>
Subject: Re: [PATCH] raid6: altivec support
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Kumar Gala wrote:

> We did talk about looking at using some work Ben did in ppc64 with OF in 
> ppc32.  John Masters was looking into this, but I havent heard much from 
> him on it lately.

I went rather quiet since I had nothing new to add to the discussion. 
But I did plan to get somewhere before FOSDEM (next month) so I could at 
least talk to the guys there about it - this is really taking a backseat 
as I've little time for it and no BDI2000/etc. at home :-)

> The firmware interface on the ppc32 embedded side is some what broken in 
> my mind.

It's absolutely broken and needs fixing - perhaps if someone wants to 
work with me on it, we'd get it sorted more quickly.

Cheers,

Jon.
