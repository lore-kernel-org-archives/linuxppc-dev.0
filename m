Return-Path: <htejun@gmail.com>
Received: from mail-yw0-x22f.google.com (mail-yw0-x22f.google.com
 [IPv6:2607:f8b0:4002:c05::22f])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3r44VV0XW6zDq5s
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 11 May 2016 02:30:26 +1000 (AEST)
Received: by mail-yw0-x22f.google.com with SMTP id t10so19116153ywa.0
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 10 May 2016 09:30:25 -0700 (PDT)
Sender: Tejun Heo <htejun@gmail.com>
Date: Tue, 10 May 2016 12:30:22 -0400
From: Tejun Heo <tj@kernel.org>
To: Vinod Koul <vinod.koul@intel.com>
Cc: Andy Shevchenko <andy.shevchenko@gmail.com>,
 =?iso-8859-1?Q?M=E5ns_Rullg=E5rd?= <mans@mansr.com>,
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
 linux-ide@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
 "open list:LINUX FOR POWERPC PA SEMI PWRFICIENT"
 <linuxppc-dev@lists.ozlabs.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 Christian Lamparter <chunkeey@googlemail.com>,
 Julian Margetson <runaway@candw.ms>
Subject: Re: [PATCH v2 00/23] ata: sata_dwc_460ex: make it working again
Message-ID: <20160510163022.GL7110@mtj.duckdns.org>
References: <1461661404-1952-1-git-send-email-andriy.shevchenko@linux.intel.com>
 <CAHp75VeeosHAxhXnWY7rc5o969TDyHPRWGdV7kh1_uR+TBa=aA@mail.gmail.com>
 <20160508200008.GM4775@htj.duckdns.org>
 <20160509010952.GN4775@htj.duckdns.org>
 <CAHp75VeMkZOZgGj2b3tHw7h7V42qM9dCz1qWs8nQENBMGWuZHQ@mail.gmail.com>
 <yw1xmvnziofc.fsf@unicorn.mansr.com>
 <20160509190536.GK7110@mtj.duckdns.org>
 <CAHp75Vf6kivRBd+9nMUU-sLPrA3ctiwvXnqrAFHX3XJWPeNO1Q@mail.gmail.com>
 <20160510060440.GF2274@localhost>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20160510060440.GF2274@localhost>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hello,

On Tue, May 10, 2016 at 11:34:40AM +0530, Vinod Koul wrote:
> > slave-dma [1], branch topic/dw. But I think Vinod can tell us which
> > tag/branch will be immutable. Vinod?
> 
> Please use branch topic/dw. I will not rebase this before sending to Linus.

Okay, pulled topic/dw into libata/for-4.7-dw and applied 1-22 on top.
Please let me know how patch 23 should be routed.

Thanks.

-- 
tejun
