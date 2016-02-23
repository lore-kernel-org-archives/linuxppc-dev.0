Return-Path: <oss@buserror.net>
Received: from host.buserror.net (host.buserror.net [209.198.135.123])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id C202D1A08E8
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 24 Feb 2016 06:33:19 +1100 (AEDT)
Message-ID: <1456255996.5360.18.camel@buserror.net>
From: Scott Wood <oss@buserror.net>
To: christophe leroy <christophe.leroy@c-s.fr>
Cc: linuxppc-dev@lists.ozlabs.org
Date: Tue, 23 Feb 2016 13:33:16 -0600
In-Reply-To: <56CCB3CA.6020908@c-s.fr>
References: <201602240229.rczorCJa%fengguang.wu@intel.com>
 <1456255707.5360.17.camel@buserror.net> <56CCB3CA.6020908@c-s.fr>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Subject: Re: [PATCH v7] powerpc32: provide VIRT_CPU_ACCOUNTING
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, 2016-02-23 at 20:32 +0100, christophe leroy wrote:
> 
> Le 23/02/2016 20:28, Scott Wood a écrit :
> > On Wed, 2016-02-24 at 02:38 +0800, kbuild test robot wrote:
> > > Hi Christophe,
> > > 
> > > [auto build test ERROR on powerpc/next]
> > > [also build test ERROR on v4.5-rc5 next-20160223]
> > > [if your patch is applied to the wrong git tree, please drop us a note
> > > to
> > > help improving the system]
> > > 
> > > url:    
> > > https://github.com/0day-ci/linux/commits/Christophe-Leroy/powerpc32-
> > > provide-VIRT_CPU_ACCOUNTING/20160224-010322
> > > base:   
> > > https://git.kernel.org/pub/scm/linux/kernel/git/powerpc/linux.git ne
> > > xt
> > > config: powerpc-defconfig (attached as .config)
> > > reproduce:
> > >          wget 
> > > https://git.kernel.org/cgit/linux/kernel/git/wfg/lkp-tests.git/
> > > plain/sbin/make.cross -O ~/bin/make.cross
> > >          chmod +x ~/bin/make.cross
> > >          # save the attached .config to linux build tree
> > >          make.cross ARCH=powerpc
> > I've been seeing a lot of these build failure reports from your patches --
> > can
> > you please test build on an appropriate variety of configs before
> > submitting?
> > 
> > 
> I usually test several PPC32 configs, but I only have a PPC32 compiler, 
> therefore I'm not able to test PPC64 configs.
> I'll see what I can do.

Get a ppc64 compiler.

https://www.kernel.org/pub/tools/crosstool/

-Scott
