Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id 79BD72C0086
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  8 Feb 2013 13:34:30 +1100 (EST)
Message-ID: <1360290858.2650.50.camel@pasglop>
Subject: Re: kernel BUG at arch/powerpc/mm/hash_utils_64.c:1223!
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Aaro Koskinen <aaro.koskinen@iki.fi>
Date: Fri, 08 Feb 2013 13:34:18 +1100
In-Reply-To: <20130207230900.GC3178@blackmetal.musicnaut.iki.fi>
References: <20130207230900.GC3178@blackmetal.musicnaut.iki.fi>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Cc: linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, 2013-02-08 at 01:09 +0200, Aaro Koskinen wrote:
> 
> I get this BUG when enabling DEBUG_PAGEALLOC with 3.8-rc6+
> (6bacaa9ddacb71c691d32c678d37bc59ffc71fac) on G5 PPC.
> 
> It seems to be fairly reproducible - I saw it 3 times, soon after
> booting
> while running a compilation job on ext3 partition. Unfortunately I'm
> not able to capture the full trace at the moment. Kernel config is
> below.

Thanks, I'll investigate.

Cheers,
Ben.
