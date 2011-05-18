Return-Path: <B07421@freescale.com>
Received: from DB3EHSOBE001.bigfish.com (db3ehsobe001.messaging.microsoft.com
	[213.199.154.139])
	(using TLSv1 with cipher AES128-SHA (128/128 bits))
	(Client CN "mail.global.frontbridge.com",
	Issuer "Cybertrust SureServer Standard Validation CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id DAC9B10080A
	for <linuxppc-dev@lists.ozlabs.org>;
	Thu, 19 May 2011 07:52:20 +1000 (EST)
Date: Wed, 18 May 2011 16:52:00 -0500
From: Scott Wood <scottwood@freescale.com>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [PATCH 7/7] powerpc/e5500: set MMU_FTR_USE_PAIRED_MAS
Message-ID: <20110518165200.0d3e0188@schlenkerla.am.freescale.net>
In-Reply-To: <1305754699.7481.6.camel@pasglop>
References: <20110518210538.GF29524@schlenkerla.am.freescale.net>
	<1305754699.7481.6.camel@pasglop>
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

On Thu, 19 May 2011 07:38:19 +1000
Benjamin Herrenschmidt <benh@kernel.crashing.org> wrote:

> On Wed, 2011-05-18 at 16:05 -0500, Scott Wood wrote:
> > Signed-off-by: Scott Wood <scottwood@freescale.com>
> > ---
> > Is there any 64-bit book3e chip that doesn't support this?  It
> > doesn't appear to be optional in the ISA.
> 
> Not afaik.

Any objection to just removing the feature bit?

-Scott
