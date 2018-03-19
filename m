Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (bilbo.ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 404rDP2GfjzF1Wc
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 20 Mar 2018 09:23:01 +1100 (AEDT)
In-Reply-To: <20180221214633.2012-1-alexandre.belloni@bootlin.com>
To: Alexandre Belloni <alexandre.belloni@bootlin.com>
From: Michael Ellerman <patch-notifications@ellerman.id.au>
Cc: linux-rtc@vger.kernel.org,
 Alexandre Belloni <alexandre.belloni@bootlin.com>,
 linux-kernel@vger.kernel.org, Paul Mackerras <paulus@samba.org>,
 linuxppc-dev@lists.ozlabs.org
Subject: Re: powerpc/time: stop validating rtc_time in .read_time
Message-Id: <404rDL3m5Dz9sVZ@ozlabs.org>
Date: Tue, 20 Mar 2018 09:22:56 +1100 (AEDT)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, 2018-02-21 at 21:46:33 UTC, Alexandre Belloni wrote:
> The RTC core is always calling rtc_valid_tm after the read_time callback.
> It is not necessary to call it just before returning from the callback.
> 
> Signed-off-by: Alexandre Belloni <alexandre.belloni@bootlin.com>

Applied to powerpc next, thanks.

https://git.kernel.org/powerpc/c/890ae7979758568734881ad0f382c4

cheers
