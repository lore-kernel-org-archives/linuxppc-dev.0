Return-Path: <vinod.koul@intel.com>
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
 by lists.ozlabs.org (Postfix) with ESMTP id 3r3pTS1n3NzDq60
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 10 May 2016 15:58:34 +1000 (AEST)
Date: Tue, 10 May 2016 11:34:40 +0530
From: Vinod Koul <vinod.koul@intel.com>
To: Andy Shevchenko <andy.shevchenko@gmail.com>
Cc: Tejun Heo <tj@kernel.org>,
 =?iso-8859-1?Q?M=E5ns_Rullg=E5rd?= <mans@mansr.com>,
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
 linux-ide@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
 "open list:LINUX FOR POWERPC PA SEMI PWRFICIENT"
 <linuxppc-dev@lists.ozlabs.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 Christian Lamparter <chunkeey@googlemail.com>,
 Julian Margetson <runaway@candw.ms>
Subject: Re: [PATCH v2 00/23] ata: sata_dwc_460ex: make it working again
Message-ID: <20160510060440.GF2274@localhost>
References: <1461661404-1952-1-git-send-email-andriy.shevchenko@linux.intel.com>
 <CAHp75VeeosHAxhXnWY7rc5o969TDyHPRWGdV7kh1_uR+TBa=aA@mail.gmail.com>
 <20160508200008.GM4775@htj.duckdns.org>
 <20160509010952.GN4775@htj.duckdns.org>
 <CAHp75VeMkZOZgGj2b3tHw7h7V42qM9dCz1qWs8nQENBMGWuZHQ@mail.gmail.com>
 <yw1xmvnziofc.fsf@unicorn.mansr.com>
 <20160509190536.GK7110@mtj.duckdns.org>
 <CAHp75Vf6kivRBd+9nMUU-sLPrA3ctiwvXnqrAFHX3XJWPeNO1Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
In-Reply-To: <CAHp75Vf6kivRBd+9nMUU-sLPrA3ctiwvXnqrAFHX3XJWPeNO1Q@mail.gmail.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, May 09, 2016 at 10:59:32PM +0300, Andy Shevchenko wrote:
> On Mon, May 9, 2016 at 10:05 PM, Tejun Heo <tj@kernel.org> wrote:
> > On Mon, May 09, 2016 at 10:13:59AM +0100, Måns Rullgård wrote:
> >> Andy Shevchenko <andy.shevchenko@gmail.com> writes:
> >>
> >> > On Mon, May 9, 2016 at 4:09 AM, Tejun Heo <tj@kernel.org> wrote:
> >> >> On Sun, May 08, 2016 at 04:00:08PM -0400, Tejun Heo wrote:
> >> >>> Hello, Andy.
> >> >>>
> >> >>> On Wed, May 04, 2016 at 03:22:51PM +0300, Andy Shevchenko wrote:
> >> >>> > Tejun, since Vinod applied all necessary patches into his tree, the
> >> >>> > series now has just a dependency to whatever branch / tag he marks for
> >> >>> > it.
> >> >>> > Do we have a chance to see the SATA series be applied in your tree?
> >> >>>
> >> >>> Applied 1-22 to libata/for-4.7.  There was a couple trivial conflicts
> >> >>> which I resolved while applying but it'd be great if you can check
> >> >>> whether everything looks okay.
> >> >>>
> >> >>>  https://git.kernel.org/cgit/linux/kernel/git/tj/libata.git/log/?h=for-4.7
> >> >>
> >> >> Oops, build failure.  Reverted for now.
> >> >
> >> > I suppose you have to pull material from Vinod.
> >>
> >> The failure the build bot reported is due to the DMA patches not being
> >> in the tree.
> >
> > Which tree should I pull?
> 
> slave-dma [1], branch topic/dw. But I think Vinod can tell us which
> tag/branch will be immutable. Vinod?

Please use branch topic/dw. I will not rebase this before sending to Linus.

Also if you prefer a signed tag, then please use dmaengine-topic-dw-4.7-rc1

> 
> [1] http://git.infradead.org/users/vkoul/slave-dma.git

Thanks
-- 
~Vinod
