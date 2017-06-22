Return-Path: <logang@deltatee.com>
Received: from ale.deltatee.com (ale.deltatee.com [207.54.116.67])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3wtt3l18BHzDqj7
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 23 Jun 2017 06:10:11 +1000 (AEST)
To: Alan Cox <gnomes@lxorguk.ukuu.org.uk>
References: <20170622164817.25515-1-logang@deltatee.com>
 <20170622164817.25515-5-logang@deltatee.com>
 <20170622210828.27304f6a@alans-desktop>
Cc: linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
 linux-ntb@googlegroups.com, linux-alpha@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org, linux-crypto@vger.kernel.org,
 dri-devel@lists.freedesktop.org, Arnd Bergmann <arnd@arndb.de>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Stephen Bates <sbates@raithlin.com>, Richard Henderson <rth@twiddle.net>,
 Ivan Kokshaysky <ink@jurassic.park.msu.ru>, Matt Turner <mattst88@gmail.com>
From: Logan Gunthorpe <logang@deltatee.com>
Message-ID: <401cdb64-6fdb-be30-b8bc-bf51c1a35074@deltatee.com>
Date: Thu, 22 Jun 2017 14:09:55 -0600
MIME-Version: 1.0
In-Reply-To: <20170622210828.27304f6a@alans-desktop>
Content-Type: text/plain; charset=windows-1252; format=flowed
Subject: Re: [PATCH 4/7] alpha: provide ioread64 and iowrite64 implementations
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 6/22/2017 2:08 PM, Alan Cox wrote:
> But this does not do the same thing as an ioread64 with regards to
> atomicity or side effects on the device. The same is true of the other
> hacks. You either have a real 64bit single read/write from MMIO space or
> you don't. You can't fake it.

Yes, I know. But is it not better than having every driver that wants to 
use these functions fake it themselves?

Logan
