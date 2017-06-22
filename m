Return-Path: <logang@deltatee.com>
Received: from ale.deltatee.com (ale.deltatee.com [207.54.116.67])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3wtpsk04Z8zDqjQ
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 23 Jun 2017 03:46:17 +1000 (AEST)
To: Stephen Bates <sbates@raithlin.com>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>,
 "linux-ntb@googlegroups.com" <linux-ntb@googlegroups.com>,
 "linux-alpha@vger.kernel.org" <linux-alpha@vger.kernel.org>,
 "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
 "linux-crypto@vger.kernel.org" <linux-crypto@vger.kernel.org>,
 "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>
References: <20170622164817.25515-1-logang@deltatee.com>
 <20170622164817.25515-5-logang@deltatee.com>
 <E70FB7EB-3A05-4A08-A85E-020F47751E3B@raithlin.com>
Cc: Arnd Bergmann <arnd@arndb.de>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Richard Henderson <rth@twiddle.net>,
 Ivan Kokshaysky <ink@jurassic.park.msu.ru>, Matt Turner <mattst88@gmail.com>
From: Logan Gunthorpe <logang@deltatee.com>
Message-ID: <0d2f1f7c-d014-5ddf-ad5c-64f13cb5a64a@deltatee.com>
Date: Thu, 22 Jun 2017 11:30:42 -0600
MIME-Version: 1.0
In-Reply-To: <E70FB7EB-3A05-4A08-A85E-020F47751E3B@raithlin.com>
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

On 6/22/2017 11:29 AM, Stephen  Bates wrote:
>> +#define iowrite64be(v,p) iowrite32(cpu_to_be64(v), (p))
>
> Logan, thanks for taking this cleanup on. I think this should be iowrite64 not iowrite32?

Yup, good catch. Thanks. I'll fix it in a v2 of this series.

Logan
