Return-Path: <fengguang.wu@intel.com>
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
 by ozlabs.org (Postfix) with ESMTP id 2DA242C00A0
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 10 Sep 2012 12:56:50 +1000 (EST)
Date: Mon, 10 Sep 2012 10:56:44 +0800
From: Fengguang Wu <fengguang.wu@intel.com>
To: Gavin Shan <shangw@linux.vnet.ibm.com>
Subject: Re: [powerpc:next 60/78]
 arch/powerpc/platforms/pseries/eeh_pe.c:217:23: error: 'eeh_pe_get' defined
 but not used
Message-ID: <20120910025644.GA30229@localhost>
References: <20120910023442.GB29863@localhost>
 <20120910025121.GB1572@shangw.(null)>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20120910025121.GB1572@shangw.(null)>
Cc: kernel-janitors@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, Sep 10, 2012 at 10:51:22AM +0800, Gavin Shan wrote:
> Hi Fengguang,
> 
> >Hi Gavin,
> >
> >FYI, kernel build failed on
> >
> >tree:   git://git.kernel.org/pub/scm/linux/kernel/git/benh/powerpc.git next
> >head:   4715fed600109e0bd3d6cfa2b925a643173a08b4
> >commit: 22f4ab123f10e1862579785c73d9e60fa24afd4f [60/78] powerpc/eeh: Search PE based on requirement
> >config: powerpc-defconfig (attached as .config)
> >
> >All related error/warning messages:
> >
> >arch/powerpc/platforms/pseries/eeh_pe.c:217:23: error: 'eeh_pe_get' defined but not used [-Werror=unused-function]
> >arch/powerpc/platforms/pseries/eeh_pe.c:237:23: error: 'eeh_pe_get_parent' defined but not used [-Werror=unused-function]
> >cc1: all warnings being treated as errors
> >
> 
> The global functions eeh_pe_get() and eeh_pe_get_parent() will be used
> by subsequent patches. I think ppc/next merged 23 patches for EEH core
> this time. I'm not sure I should refactor those patches to avoid the
> build failure? :-)

I guess it's not your fault.. I have rules to filter out
"unused-function" warnings, however in your case all warnings are
turned into errors.. Although I can filter such errors too, they will
still present as bisect holes.

Thanks,
Fengguang
