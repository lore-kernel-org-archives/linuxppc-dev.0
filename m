Return-Path: <andriy.shevchenko@linux.intel.com>
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
 by lists.ozlabs.org (Postfix) with ESMTP id 3r44nJ0crnzDq5s
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 11 May 2016 02:43:15 +1000 (AEST)
Message-ID: <1462898661.17131.308.camel@linux.intel.com>
Subject: Re: [PATCH v2 00/23] ata: sata_dwc_460ex: make it working again
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Tejun Heo <tj@kernel.org>, Vinod Koul <vinod.koul@intel.com>
Cc: Andy Shevchenko <andy.shevchenko@gmail.com>,
 =?ISO-8859-1?Q?M=E5ns_Rullg=E5rd?= <mans@mansr.com>,
 linux-ide@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,  "open
 list:LINUX FOR POWERPC PA SEMI PWRFICIENT" <linuxppc-dev@lists.ozlabs.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Christian
 Lamparter <chunkeey@googlemail.com>,  Julian Margetson <runaway@candw.ms>
Date: Tue, 10 May 2016 19:44:21 +0300
In-Reply-To: <20160510163022.GL7110@mtj.duckdns.org>
References: <1461661404-1952-1-git-send-email-andriy.shevchenko@linux.intel.com>
 <CAHp75VeeosHAxhXnWY7rc5o969TDyHPRWGdV7kh1_uR+TBa=aA@mail.gmail.com>
 <20160508200008.GM4775@htj.duckdns.org>
 <20160509010952.GN4775@htj.duckdns.org>
 <CAHp75VeMkZOZgGj2b3tHw7h7V42qM9dCz1qWs8nQENBMGWuZHQ@mail.gmail.com>
 <yw1xmvnziofc.fsf@unicorn.mansr.com>
 <20160509190536.GK7110@mtj.duckdns.org>
 <CAHp75Vf6kivRBd+9nMUU-sLPrA3ctiwvXnqrAFHX3XJWPeNO1Q@mail.gmail.com>
 <20160510060440.GF2274@localhost> <20160510163022.GL7110@mtj.duckdns.org>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, 2016-05-10 at 12:30 -0400, Tejun Heo wrote:
> Hello,
> 
> On Tue, May 10, 2016 at 11:34:40AM +0530, Vinod Koul wrote:
> > 
> > > 
> > > slave-dma [1], branch topic/dw. But I think Vinod can tell us
> > > which
> > > tag/branch will be immutable. Vinod?
> > Please use branch topic/dw. I will not rebase this before sending to
> > Linus.
> Okay, pulled topic/dw into libata/for-4.7-dw and applied 1-22 on top.

Thanks!

> Please let me know how patch 23 should be routed.

Since Rob Acked you may take it as well.

-- 
Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Intel Finland Oy
