Return-Path: <mb@bu3sch.de>
Received: from bu3sch.de (static-ip-62-75-166-246.inaddr.intergenia.de
	[62.75.166.246]) by ozlabs.org (Postfix) with ESMTP id 2C00467C02
	for <linuxppc-dev@ozlabs.org>; Fri,  6 Oct 2006 05:57:41 +1000 (EST)
From: Michael Buesch <mb@bu3sch.de>
To: Olof Johansson <olof@lixom.net>
Subject: Re: [PATCH] powerpc: Enable DEEPNAP power savings mode on 970MP
Date: Thu, 5 Oct 2006 21:25:15 +0200
References: <20061004234141.749b13fb@localhost.localdomain>
In-Reply-To: <20061004234141.749b13fb@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200610052125.15305.mb@bu3sch.de>
Cc: linuxppc-dev@ozlabs.org, paulus@samba.org, linux-kernel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Thursday 05 October 2006 06:41, Olof Johansson wrote:
> Hi,
> 
> Without this patch, on an idle system I get:
> 
> cpu-power-0:21.638
> cpu-power-1:27.102
> cpu-power-2:29.343
> cpu-power-3:25.784
> Total: 103.8W
> 
> With this patch:
> 
> cpu-power-0:11.730
> cpu-power-1:17.185
> cpu-power-2:18.547
> cpu-power-3:17.528
> Total: 65.0W
> 
> If I lower HZ to 100, I can get it as low as:
> 
> cpu-power-0:10.938
> cpu-power-1:16.021
> cpu-power-2:17.245
> cpu-power-3:16.145
> Total: 60.2W
> 
> Another (older) Quad G5 went from 54W to 39W at HZ=250.
> 
> Coming back out of Deep Nap takes 40-70 cycles longer than coming back
> from just Nap (which already takes quite a while). I don't think it'll
> be a performance issue (interrupt latency on an idle system), but in
> case someone does measurements feel free to report them.
> 
> 
> Signed-off-by: Olof Johansson <olof@lixom.net>

Acked-by: Michael Buesch <mb@bu3sch.de>

I am running DEEPNAP on my Quad since quite some time and I
did not see any problems.
It saves quite a bit of power (I think it was about 20W for me when
I measured it)
That's really worth it.

-- 
Greetings Michael.
