Return-Path: <logang@deltatee.com>
Received: from ale.deltatee.com (ale.deltatee.com [207.54.116.67])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3wtvPR0tYSzDqjH
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 23 Jun 2017 07:10:34 +1000 (AEST)
To: Arnd Bergmann <arnd@arndb.de>
References: <20170622164817.25515-1-logang@deltatee.com>
 <20170622164817.25515-5-logang@deltatee.com>
 <20170622210828.27304f6a@alans-desktop>
 <401cdb64-6fdb-be30-b8bc-bf51c1a35074@deltatee.com>
 <CAK8P3a1R-uvjjs=UpbvJjVXnFpD_OL1aRsw0KE_GkvNy+dVj8g@mail.gmail.com>
Cc: Alan Cox <gnomes@lxorguk.ukuu.org.uk>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 linux-arch <linux-arch@vger.kernel.org>, linux-ntb@googlegroups.com,
 linux-alpha@vger.kernel.org, linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
 linux-crypto@vger.kernel.org, dri-devel <dri-devel@lists.freedesktop.org>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Stephen Bates <sbates@raithlin.com>, Richard Henderson <rth@twiddle.net>,
 Ivan Kokshaysky <ink@jurassic.park.msu.ru>, Matt Turner <mattst88@gmail.com>
From: Logan Gunthorpe <logang@deltatee.com>
Message-ID: <3ae2d934-1054-cdd1-7eaa-e9758276cf51@deltatee.com>
Date: Thu, 22 Jun 2017 15:10:20 -0600
MIME-Version: 1.0
In-Reply-To: <CAK8P3a1R-uvjjs=UpbvJjVXnFpD_OL1aRsw0KE_GkvNy+dVj8g@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Subject: Re: [PATCH 4/7] alpha: provide ioread64 and iowrite64 implementations
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 6/22/2017 3:03 PM, Arnd Bergmann wrote:
> Drivers that want a non-atomic variant should include either
> include/linux/io-64-nonatomic-hi-lo.h or include/linux/io-64-nonatomic-lo-hi.h
> depending on what they need. Drivers that require 64-bit I/O should
> probably just depend on CONFIG_64BIT and maybe use readq/writeq.

Ok, I will work something like that up.

We'll still need a patch similar to patch 2 (less the non-atomic 
versions) seeing even CONFIG_GENERIC_IOMAP arches don't actually have a 
working ioread64/iowrite64 implementation.

Thanks,

Logan
