Return-Path: <htejun@gmail.com>
Received: from mail-qg0-x241.google.com (mail-qg0-x241.google.com
 [IPv6:2607:f8b0:400d:c04::241])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3r2xFj5LN7zDq5f
 for <linuxppc-dev@lists.ozlabs.org>; Mon,  9 May 2016 06:00:24 +1000 (AEST)
Received: by mail-qg0-x241.google.com with SMTP id b14so10351446qge.2
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 08 May 2016 13:00:24 -0700 (PDT)
Sender: Tejun Heo <htejun@gmail.com>
Date: Sun, 8 May 2016 16:00:08 -0400
From: Tejun Heo <tj@kernel.org>
To: Andy Shevchenko <andy.shevchenko@gmail.com>
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
 linux-ide@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
 "open list:LINUX FOR POWERPC PA SEMI PWRFICIENT"
 <linuxppc-dev@lists.ozlabs.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 Christian Lamparter <chunkeey@googlemail.com>,
 =?iso-8859-1?Q?M=E5ns_Rullg=E5rd?= <mans@mansr.com>,
 Julian Margetson <runaway@candw.ms>, Vinod Koul <vinod.koul@intel.com>
Subject: Re: [PATCH v2 00/23] ata: sata_dwc_460ex: make it working again
Message-ID: <20160508200008.GM4775@htj.duckdns.org>
References: <1461661404-1952-1-git-send-email-andriy.shevchenko@linux.intel.com>
 <CAHp75VeeosHAxhXnWY7rc5o969TDyHPRWGdV7kh1_uR+TBa=aA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <CAHp75VeeosHAxhXnWY7rc5o969TDyHPRWGdV7kh1_uR+TBa=aA@mail.gmail.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hello, Andy.

On Wed, May 04, 2016 at 03:22:51PM +0300, Andy Shevchenko wrote:
> Tejun, since Vinod applied all necessary patches into his tree, the
> series now has just a dependency to whatever branch / tag he marks for
> it.
> Do we have a chance to see the SATA series be applied in your tree?

Applied 1-22 to libata/for-4.7.  There was a couple trivial conflicts
which I resolved while applying but it'd be great if you can check
whether everything looks okay.

 https://git.kernel.org/cgit/linux/kernel/git/tj/libata.git/log/?h=for-4.7

How is patch 23 gonna be routed?  Should I pick that one up too?

Thanks.

-- 
tejun
