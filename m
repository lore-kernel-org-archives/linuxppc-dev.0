Return-Path: <lee.jones@linaro.org>
Received: from mail-wm0-x232.google.com (mail-wm0-x232.google.com
 [IPv6:2a00:1450:400c:c09::232])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3t2XMm0mn4zDt5g
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 24 Oct 2016 21:19:47 +1100 (AEDT)
Received: by mail-wm0-x232.google.com with SMTP id c78so106762957wme.1
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 24 Oct 2016 03:19:47 -0700 (PDT)
Date: Mon, 24 Oct 2016 11:22:15 +0100
From: Lee Jones <lee.jones@linaro.org>
To: Thomas Gleixner <tglx@linutronix.de>
Cc: Stephen Rothwell <sfr@canb.auug.org.au>,
 Sudip Mukherjee <sudipm.mukherjee@gmail.com>,
 linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org,
 Marcin Niestroj <m.niestroj@grinn-global.com>,
 Grygorii Strashko <grygorii.strashko@ti.com>,
 Tony Lindgren <tony@atomide.com>, Mark Brown <broonie@kernel.org>,
 kernel-build-reports@lists.linaro.org,
 linaro-kernel@lists.linaro.org, linux-next@vger.kernel.org
Subject: Re: [PATCH] kernel: irq: fix build failure
Message-ID: <20161024102215.GN14477@dell>
References: <1475775403-27207-1-git-send-email-sudipm.mukherjee@gmail.com>
 <57FBBA0B.9070500@gmail.com>
 <alpine.DEB.2.20.1610201454410.5073@nanos>
 <20161021120020.52b3fa35@canb.auug.org.au>
 <alpine.DEB.2.20.1610211006370.4797@nanos>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
In-Reply-To: <alpine.DEB.2.20.1610211006370.4797@nanos>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, 21 Oct 2016, Thomas Gleixner wrote:

> On Fri, 21 Oct 2016, Stephen Rothwell wrote:
> > On Thu, 20 Oct 2016 14:55:45 +0200 (CEST) Thomas Gleixner <tglx@linutronix.de> wrote:
> > > I know. This is under discussion with the driver folks as we are not going
> > > to blindly export stuff just because someone slapped a irq_set_parent()
> > > into the code w/o knowing why.
> > 
> > Do we have any idea if a resolution is close.  This was first reported
> > in linux-next in September 14/15.  :-(
> 
> Grr. Yes. As much as I hate it, I'll go and export it for now. Should be
> able to get it into rc2.

Did this get in?  I still have people complaining about it.

-- 
Lee Jones
Linaro STMicroelectronics Landing Team Lead
Linaro.org │ Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
