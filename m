Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 263E71A0153
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 18 Aug 2015 20:21:36 +1000 (AEST)
In-Reply-To: <1437801670-23705-4-git-send-email-hegdevasant@linux.vnet.ibm.com>
To: Vasant Hegde <hegdevasant@linux.vnet.ibm.com>, linux-leds@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org, j.anaszewski@samsung.com
From: Michael Ellerman <mpe@ellerman.id.au>
Cc: stewart@linux.vnet.ibm.com, j.anaszewski81@gmail.com, arnd@arndb.de,
 cooloney@gmail.com, Vasant Hegde <hegdevasant@linux.vnet.ibm.com>,
 rpurdie@rpsys.net, khandual@linux.vnet.ibm.com
Subject: Re: [v8,3/3] leds/powernv: Add driver for PowerNV platform
Message-Id: <20150818102136.0C9DD1402B5@ozlabs.org>
Date: Tue, 18 Aug 2015 20:21:35 +1000 (AEST)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Sat, 2015-25-07 at 05:21:10 UTC, Vasant Hegde wrote:
> This patch implements LED driver for PowerNV platform using the existing
> generic LED class framework.
> 
> PowerNV platform has below type of LEDs:
>   - System attention
>       Indicates there is a problem with the system that needs attention.
>   - Identify
>       Helps the user locate/identify a particular FRU or resource in the
>       system.
>   - Fault
>       Indicates there is a problem with the FRU or resource at the
>       location with which the indicator is associated.

Hi Vasant,

I'm waiting for a respin of this based on the discussion between you and
Jackek.

If I don't see it soon it will miss v4.3.

cheers
