Return-Path: <lee.jones@linaro.org>
Received: from mail-wm0-x230.google.com (mail-wm0-x230.google.com
 [IPv6:2a00:1450:400c:c09::230])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3t2ZkY58XRzDvXs
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 24 Oct 2016 23:06:13 +1100 (AEDT)
Received: by mail-wm0-x230.google.com with SMTP id c78so100621905wme.0
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 24 Oct 2016 05:06:13 -0700 (PDT)
Date: Mon, 24 Oct 2016 13:08:41 +0100
From: Lee Jones <lee.jones@linaro.org>
To: Stephen Rothwell <sfr@canb.auug.org.au>
Cc: Thomas Gleixner <tglx@linutronix.de>,
 Sudip Mukherjee <sudipm.mukherjee@gmail.com>,
 linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org,
 Marcin Niestroj <m.niestroj@grinn-global.com>,
 Grygorii Strashko <grygorii.strashko@ti.com>,
 Tony Lindgren <tony@atomide.com>, Mark Brown <broonie@kernel.org>,
 kernel-build-reports@lists.linaro.org,
 linaro-kernel@lists.linaro.org, linux-next@vger.kernel.org
Subject: Re: [PATCH] kernel: irq: fix build failure
Message-ID: <20161024120840.GC8574@dell>
References: <1475775403-27207-1-git-send-email-sudipm.mukherjee@gmail.com>
 <57FBBA0B.9070500@gmail.com>
 <alpine.DEB.2.20.1610201454410.5073@nanos>
 <20161021120020.52b3fa35@canb.auug.org.au>
 <alpine.DEB.2.20.1610211006370.4797@nanos>
 <20161024102215.GN14477@dell>
 <20161024223231.5cdbb2ac@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
In-Reply-To: <20161024223231.5cdbb2ac@canb.auug.org.au>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, 24 Oct 2016, Stephen Rothwell wrote:
> On Mon, 24 Oct 2016 11:22:15 +0100 Lee Jones <lee.jones@linaro.org> wrote:
> > On Fri, 21 Oct 2016, Thomas Gleixner wrote:
> > 
> > > On Fri, 21 Oct 2016, Stephen Rothwell wrote:  
> > > > On Thu, 20 Oct 2016 14:55:45 +0200 (CEST) Thomas Gleixner <tglx@linutronix.de> wrote:  
> > > > > I know. This is under discussion with the driver folks as we are not going
> > > > > to blindly export stuff just because someone slapped a irq_set_parent()
> > > > > into the code w/o knowing why.  
> > > > 
> > > > Do we have any idea if a resolution is close.  This was first reported
> > > > in linux-next in September 14/15.  :-(  
> > > 
> > > Grr. Yes. As much as I hate it, I'll go and export it for now. Should be
> > > able to get it into rc2.  
> > 
> > Did this get in?  I still have people complaining about it.
> 
> It is in -rc2.  Commit 3118dac501bc.

Ah, I was searching for patches authored my Thomas.

I see it now, thanks.

-- 
Lee Jones
Linaro STMicroelectronics Landing Team Lead
Linaro.org │ Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
