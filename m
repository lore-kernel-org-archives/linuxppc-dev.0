Return-Path: <agust@denx.de>
Received: from mail-out.m-online.net (mail-out.m-online.net [212.18.0.10])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id 716992C00D1
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 22 Aug 2013 06:38:24 +1000 (EST)
Date: Wed, 21 Aug 2013 22:38:17 +0200
From: Anatolij Gustschin <agust@denx.de>
To: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH v4 01/31] spi: mpc512x: cleanup clock API use
Message-ID: <20130821223817.1bf459a0@crub>
In-Reply-To: <20130821194817.GL26118@sirena.org.uk>
References: <1374495298-22019-1-git-send-email-gsi@denx.de>
 <1375821851-31609-1-git-send-email-gsi@denx.de>
 <1375821851-31609-2-git-send-email-gsi@denx.de>
 <20130821212258.2cbc969c@crub>
 <20130821194817.GL26118@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: devicetree@vger.kernel.org, Gerhard Sittig <gsi@denx.de>,
 linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, 21 Aug 2013 20:48:17 +0100
Mark Brown <broonie@kernel.org> wrote:

> On Wed, Aug 21, 2013 at 09:22:58PM +0200, Anatolij Gustschin wrote:
> 
> > Mark, are you going to apply this patch? Or should I queue it
> > in my mpc5xxx tree (I'd like to get your Acked-by then)?
> 
> Has this series settled down?  I'd been ignoring it since it was getting
> so many and so frequent revisions.

Patches 01 - 14 (except 09 and 11) won't change I think. I'd prefer
to queue them for v3.12, so there will be no need to resubmit again
and again. Other patches are not ready yet.

Anatolij
