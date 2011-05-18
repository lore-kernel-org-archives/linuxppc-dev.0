Return-Path: <B07421@freescale.com>
Received: from DB3EHSOBE005.bigfish.com (db3ehsobe005.messaging.microsoft.com
	[213.199.154.143])
	(using TLSv1 with cipher AES128-SHA (128/128 bits))
	(Client CN "mail.global.frontbridge.com",
	Issuer "Cybertrust SureServer Standard Validation CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 9C9F2100814
	for <linuxppc-dev@lists.ozlabs.org>;
	Thu, 19 May 2011 07:51:45 +1000 (EST)
Date: Wed, 18 May 2011 16:51:34 -0500
From: Scott Wood <scottwood@freescale.com>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [PATCH 6/7] powerpc/mm: 64-bit: tlb handler micro-optimization
Message-ID: <20110518165134.1023dccc@schlenkerla.am.freescale.net>
In-Reply-To: <1305754667.7481.5.camel@pasglop>
References: <20110518210536.GE29524@schlenkerla.am.freescale.net>
	<1305754667.7481.5.camel@pasglop>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Cc: linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, 19 May 2011 07:37:47 +1000
Benjamin Herrenschmidt <benh@kernel.crashing.org> wrote:

> On Wed, 2011-05-18 at 16:05 -0500, Scott Wood wrote:
> > A little more speed up measured on e5500.
> > 
> > Setting of U0-3 is dropped as it is not used by Linux as far as I can
> > see.
> 
> Please keep them for now. If your core doesn't have them, make them an
> MMU feature.

We have them, it was just an attempt to clean out unused things to speed up
the miss handler.  I'll drop that part if you think we'll use it in the
future.

-Scott
