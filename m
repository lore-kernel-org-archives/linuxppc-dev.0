Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 404rDH40RbzF1W6
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 20 Mar 2018 09:22:55 +1100 (AEDT)
In-Reply-To: <20180216234323.27601-1-alexandre.belloni@bootlin.com>
To: Alexandre Belloni <alexandre.belloni@bootlin.com>
From: Michael Ellerman <patch-notifications@ellerman.id.au>
Cc: linux-rtc@vger.kernel.org,
 Alexandre Belloni <alexandre.belloni@bootlin.com>,
 linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Subject: Re: [RESEND] powerpc/5200: dts: digsy_mtc.dts: fix rv3029 compatible
Message-Id: <404rDF3D4sz9sVl@ozlabs.org>
Date: Tue, 20 Mar 2018 09:22:52 +1100 (AEDT)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, 2018-02-16 at 23:43:23 UTC, Alexandre Belloni wrote:
> The proper compatible for rv3029 is microcrystal,rv3029.
> 
> Acked-by: Anatolij Gustschin <agust@denx.de>
> Signed-off-by: Alexandre Belloni <alexandre.belloni@bootlin.com>

Applied to powerpc next, thanks.

https://git.kernel.org/powerpc/c/7004263bd4f4c79da9ca2a1d04d38d

cheers
