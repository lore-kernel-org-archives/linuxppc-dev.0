Return-Path: <akpm@linux-foundation.org>
Received: from mail.linuxfoundation.org (mail.linuxfoundation.org
 [140.211.169.12])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 41Zxbr0cxVzDrHF
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 25 Jul 2018 10:55:35 +1000 (AEST)
Date: Tue, 24 Jul 2018 17:55:31 -0700
From: Andrew Morton <akpm@linux-foundation.org>
To: Joe Perches <joe@perches.com>
Cc: Arnd Bergmann <arnd@arndb.de>, Samuel Ortiz <sameo@linux.intel.com>,
 "David S. Miller" <davem@davemloft.net>, Rob Herring <robh+dt@kernel.org>,
 Michael Ellerman <mpe@ellerman.id.au>, Jonathan Cameron <jic23@kernel.org>,
 linux-wireless@vger.kernel.org, netdev@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-crypto@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org, linux-iio@vger.kernel.org,
 linux-pm@vger.kernel.org, lvs-devel@vger.kernel.org,
 netfilter-devel@vger.kernel.org, coreteam@netfilter.org
Subject: Re: [PATCH 1/4] treewide: convert ISO_8859-1 text comments to utf-8
Message-Id: <20180724175531.75276cf4e539124aa9e27177@linux-foundation.org>
In-Reply-To: <aa39b6d15f44555cb79d5ebdef74aeab19003d6a.camel@perches.com>
References: <20180724111600.4158975-1-arnd@arndb.de>
 <20180724140010.e24a9964fd340afe2d98a994@linux-foundation.org>
 <aa39b6d15f44555cb79d5ebdef74aeab19003d6a.camel@perches.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, 24 Jul 2018 17:13:20 -0700 Joe Perches <joe@perches.com> wrote:

> On Tue, 2018-07-24 at 14:00 -0700, Andrew Morton wrote:
> > On Tue, 24 Jul 2018 13:13:25 +0200 Arnd Bergmann <arnd@arndb.de> wrote:
> > > Almost all files in the kernel are either plain text or UTF-8
> > > encoded. A couple however are ISO_8859-1, usually just a few
> > > characters in a C comments, for historic reasons.
> > > This converts them all to UTF-8 for consistency.
> []
> > Will we be getting a checkpatch rule to keep things this way?
> 
> How would that be done?

I'm using this, seems to work.

        if ! file $p | grep -q -P ", ASCII text|, UTF-8 Unicode text"
        then
                echo $p: weird charset
        fi
