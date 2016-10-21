Return-Path: <tglx@linutronix.de>
Received: from Galois.linutronix.de (Galois.linutronix.de
 [IPv6:2a01:7a0:2:106d:700::1])
 (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3t0ddc4ZtGzDvZx
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 21 Oct 2016 19:10:12 +1100 (AEDT)
Date: Fri, 21 Oct 2016 10:07:41 +0200 (CEST)
From: Thomas Gleixner <tglx@linutronix.de>
To: Stephen Rothwell <sfr@canb.auug.org.au>
cc: Sudip Mukherjee <sudipm.mukherjee@gmail.com>,
 linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org,
 Marcin Niestroj <m.niestroj@grinn-global.com>,
 Grygorii Strashko <grygorii.strashko@ti.com>,
 Tony Lindgren <tony@atomide.com>, Lee Jones <lee.jones@linaro.org>,
 Mark Brown <broonie@kernel.org>, kernel-build-reports@lists.linaro.org,
 linaro-kernel@lists.linaro.org, linux-next@vger.kernel.org
Subject: Re: [PATCH] kernel: irq: fix build failure
In-Reply-To: <20161021120020.52b3fa35@canb.auug.org.au>
Message-ID: <alpine.DEB.2.20.1610211006370.4797@nanos>
References: <1475775403-27207-1-git-send-email-sudipm.mukherjee@gmail.com>
 <57FBBA0B.9070500@gmail.com> <alpine.DEB.2.20.1610201454410.5073@nanos>
 <20161021120020.52b3fa35@canb.auug.org.au>
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

On Fri, 21 Oct 2016, Stephen Rothwell wrote:
> On Thu, 20 Oct 2016 14:55:45 +0200 (CEST) Thomas Gleixner <tglx@linutronix.de> wrote:
> > I know. This is under discussion with the driver folks as we are not going
> > to blindly export stuff just because someone slapped a irq_set_parent()
> > into the code w/o knowing why.
> 
> Do we have any idea if a resolution is close.  This was first reported
> in linux-next in September 14/15.  :-(

Grr. Yes. As much as I hate it, I'll go and export it for now. Should be
able to get it into rc2.

Thanks,

	tglx
