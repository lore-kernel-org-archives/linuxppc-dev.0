Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id D86A91A05BC
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 20 Aug 2015 18:38:14 +1000 (AEST)
In-Reply-To: <1440002994-25662-3-git-send-email-hegdevasant@linux.vnet.ibm.com>
To: Vasant Hegde <hegdevasant@linux.vnet.ibm.com>, linux-leds@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org
From: Michael Ellerman <mpe@ellerman.id.au>
Cc: stewart@linux.vnet.ibm.com, j.anaszewski81@gmail.com, arnd@arndb.de,
 cooloney@gmail.com, Vasant Hegde <hegdevasant@linux.vnet.ibm.com>,
 rpurdie@rpsys.net, j.anaszewski@samsung.com, khandual@linux.vnet.ibm.com
Subject: Re: [v10,2/3] powerpc/powernv: Create LED platform device
Message-Id: <20150820083814.92DC31402A9@ozlabs.org>
Date: Thu, 20 Aug 2015 18:38:14 +1000 (AEST)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, 2015-19-08 at 16:49:53 UTC, Vasant Hegde wrote:
> This patch adds platform devices for leds. Also export LED related
> OPAL API's so that led driver can use these APIs.
> 
> Signed-off-by: Vasant Hegde <hegdevasant@linux.vnet.ibm.com>
> Acked-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>

Applied to powerpc next, thanks.

https://git.kernel.org/powerpc/c/c159b5968ec9d3cbf168

cheers
