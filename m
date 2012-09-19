Return-Path: <sruffell@digium.com>
Received: from mail.digium.com (mail.digium.com [216.207.245.2])
 (using TLSv1 with cipher AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id 5EE4A2C008A
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 19 Sep 2012 14:00:34 +1000 (EST)
Date: Tue, 18 Sep 2012 22:53:06 -0500
From: Shaun Ruffell <sruffell@digium.com>
To: Xie Shaohui-B21989 <B21989@freescale.com>
Subject: Re: [PATCH] edac/85xx: fix error handle of mpc85xx_mc_err_probe
Message-ID: <20120919035306.GF24873@digium.com>
References: <1347533729-5893-1-git-send-email-Shaohui.Xie@freescale.com>
 <20120914182137.GD18672@digium.com>
 <ED492CCEAF882048BC2237DE806547C9079E171E@039-SN2MPN1-012.039d.mgd.msft.net>
 <20120919030438.GE24873@digium.com>
 <ED492CCEAF882048BC2237DE806547C9079E3F3D@039-SN2MPN1-012.039d.mgd.msft.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <ED492CCEAF882048BC2237DE806547C9079E3F3D@039-SN2MPN1-012.039d.mgd.msft.net>
Cc: "avorontsov@mvista.com" <avorontsov@mvista.com>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
 "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
 "linux-edac@vger.kernel.org" <linux-edac@vger.kernel.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, Sep 19, 2012 at 03:43:35AM +0000, Xie Shaohui-B21989 wrote:
> > On Mon, Sep 17, 2012 at 10:32:59AM +0000, Xie Shaohui-B21989 wrote:
> > >
> > > BTW: seems you are using a different kernel tree with mine.
> > 
> > On the chance that I missing something important: Why do you say
> > I was running a different kernel tree? I was against 3.6-rc2
> > when I original hit the problem.
>
> [S.H] I'm using 3.6-rc4, and some codes in your patch I did not
> find them in 3.6-rc4.

Is it because there were three patches in the series?

  [1/3] https://lkml.org/lkml/2012/9/14/473
  [2/3] https://lkml.org/lkml/2012/9/14/469
  [3/3] https://lkml.org/lkml/2012/9/14/474

They are also the last three commits on my edac_debug_v2 branch
here, which is on top of 3.6-rc6:

https://github.com/sruffell/linux/commits/edac_debug_v2/

Cheers,
Shaun
