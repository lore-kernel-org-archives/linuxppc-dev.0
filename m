Return-Path: <arnd@arndb.de>
Received: from mout.kundenserver.de (mout.kundenserver.de [212.227.126.187])
 (using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3s9C810xyqzDqfj
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 12 Aug 2016 01:47:27 +1000 (AEST)
From: Arnd Bergmann <arnd@arndb.de>
To: linuxppc-dev@lists.ozlabs.org
Cc: Nicholas Piggin <npiggin@gmail.com>,
 Stephen Rothwell <sfr@canb.auug.org.au>, Alan Modra <amodra@gmail.com>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "Luis R. Rodriguez" <mcgrof@kernel.org>, linux-next@vger.kernel.org,
 Paul Mackerras <paulus@samba.org>, Fengguang Wu <fengguang.wu@intel.com>,
 Guenter Roeck <linux@roeck-us.net>
Subject: Re: [TESTING] kbuild: link drivers subdirectories separately
Date: Thu, 11 Aug 2016 17:46:24 +0200
Message-ID: <3541255.WOXCFhM6uN@wuerfel>
In-Reply-To: <10934898.zRVpW5bs5f@wuerfel>
References: <CAB=NE6U18jv89pxqAeZY8eTj44mq90kyXGaQO-108+ZMTyxQiQ@mail.gmail.com>
 <20160811231240.4ba73123@roar.ozlabs.ibm.com> <10934898.zRVpW5bs5f@wuerfel>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thursday, August 11, 2016 3:49:03 PM CEST Arnd Bergmann wrote:
> @@ -137,7 +134,8 @@ obj-$(CONFIG_PPC_PS3)               += ps3/
>  obj-$(CONFIG_OF)               += of/
>  obj-$(CONFIG_SSB)              += ssb/
>  obj-$(CONFIG_BCMA)             += bcma/
> -obj-y                          += vhost/
> +obj-$(CONFIG_VHOST_RING)       += vhost/
> +obj-$(CONFIG_VHOST)            += vhost/
>  obj-$(CONFIG_VLYNQ)            += vlynq/
>  obj-$(CONFIG_STAGING)          += staging/
>  obj-y                          += platform/
> 

This hunk should have been the other way round to apply and work correctly,
I mixed up the number of reverts I had on my tree before it.

	Arnd
