Return-Path: <sfr@canb.auug.org.au>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3t2Yzh2Z39zDvK6
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 24 Oct 2016 22:32:32 +1100 (AEDT)
Date: Mon, 24 Oct 2016 22:32:31 +1100
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Lee Jones <lee.jones@linaro.org>
Cc: Thomas Gleixner <tglx@linutronix.de>, Sudip Mukherjee
 <sudipm.mukherjee@gmail.com>, linuxppc-dev@lists.ozlabs.org,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Marcin
 Niestroj <m.niestroj@grinn-global.com>, Grygorii Strashko
 <grygorii.strashko@ti.com>, Tony Lindgren <tony@atomide.com>, Mark Brown
 <broonie@kernel.org>, kernel-build-reports@lists.linaro.org,
 linaro-kernel@lists.linaro.org, linux-next@vger.kernel.org
Subject: Re: [PATCH] kernel: irq: fix build failure
Message-ID: <20161024223231.5cdbb2ac@canb.auug.org.au>
In-Reply-To: <20161024102215.GN14477@dell>
References: <1475775403-27207-1-git-send-email-sudipm.mukherjee@gmail.com>
 <57FBBA0B.9070500@gmail.com>
 <alpine.DEB.2.20.1610201454410.5073@nanos>
 <20161021120020.52b3fa35@canb.auug.org.au>
 <alpine.DEB.2.20.1610211006370.4797@nanos>
 <20161024102215.GN14477@dell>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi Lee,

On Mon, 24 Oct 2016 11:22:15 +0100 Lee Jones <lee.jones@linaro.org> wrote:
>
> On Fri, 21 Oct 2016, Thomas Gleixner wrote:
> 
> > On Fri, 21 Oct 2016, Stephen Rothwell wrote:  
> > > On Thu, 20 Oct 2016 14:55:45 +0200 (CEST) Thomas Gleixner <tglx@linutronix.de> wrote:  
> > > > I know. This is under discussion with the driver folks as we are not going
> > > > to blindly export stuff just because someone slapped a irq_set_parent()
> > > > into the code w/o knowing why.  
> > > 
> > > Do we have any idea if a resolution is close.  This was first reported
> > > in linux-next in September 14/15.  :-(  
> > 
> > Grr. Yes. As much as I hate it, I'll go and export it for now. Should be
> > able to get it into rc2.  
> 
> Did this get in?  I still have people complaining about it.

It is in -rc2.  Commit 3118dac501bc.

-- 
Cheers,
Stephen Rothwell
