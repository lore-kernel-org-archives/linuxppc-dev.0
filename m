Return-Path: <logang@deltatee.com>
Received: from ale.deltatee.com (ale.deltatee.com [207.54.116.67])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3wtthf3TQBzDr2d
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 23 Jun 2017 06:38:42 +1000 (AEST)
To: Alan Cox <gnomes@lxorguk.ukuu.org.uk>
References: <20170622164817.25515-1-logang@deltatee.com>
 <20170622164817.25515-4-logang@deltatee.com>
 <20170622211431.14270378@alans-desktop>
 <e856de0b-e9a3-8228-7a73-4daa38cb4479@deltatee.com>
 <20170622213655.07dffac2@alans-desktop>
Cc: linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
 linux-ntb@googlegroups.com, linux-alpha@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org, linux-crypto@vger.kernel.org,
 dri-devel@lists.freedesktop.org, Arnd Bergmann <arnd@arndb.de>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Stephen Bates <sbates@raithlin.com>
From: Logan Gunthorpe <logang@deltatee.com>
Message-ID: <131f6a1c-ee4d-20eb-d1d3-200c70bbae0c@deltatee.com>
Date: Thu, 22 Jun 2017 14:38:28 -0600
MIME-Version: 1.0
In-Reply-To: <20170622213655.07dffac2@alans-desktop>
Content-Type: text/plain; charset=windows-1252; format=flowed
Subject: Re: [PATCH 3/7] asm-generic/io.h: make ioread64 and iowrite64
 universally available
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 6/22/2017 2:36 PM, Alan Cox wrote:
> I think that makes sense for the platforms with that problem. I'm not
> sure there are many that can't do it for mmio at least. 486SX can't do it
> and I guess some ARM32 but I think almost everyone else can including
> most 32bit x86.
>
> What's more of a problem is a lot of platforms can do 64bit MMIO via
> ioread/write64 but not 64bit port I/O, and it's not clear how you
> represent that via an ioread/write API that abstracts it away.

In Patch 2, we call bad_io_access for anyone trying to do 64bit accesses 
on port I/O.

Logan
