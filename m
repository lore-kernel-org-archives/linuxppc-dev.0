Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id 65A27B7393
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 17 Mar 2012 02:14:32 +1100 (EST)
Subject: Re: [PATCH 2/2] powerpc/p2020rdb p1010rdb: lower spi flash freq to
 40Mhz
Mime-Version: 1.0 (Apple Message framework v1257)
Content-Type: text/plain; charset=us-ascii
From: Kumar Gala <galak@kernel.crashing.org>
In-Reply-To: <1331833228-14903-2-git-send-email-bigeasy@linutronix.de>
Date: Fri, 16 Mar 2012 10:13:56 -0500
Message-Id: <BD7A373A-7AE9-49A1-87C0-D66A4BBE07B8@kernel.crashing.org>
References: <1331833228-14903-1-git-send-email-bigeasy@linutronix.de>
 <1331833228-14903-2-git-send-email-bigeasy@linutronix.de>
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


On Mar 15, 2012, at 12:40 PM, Sebastian Andrzej Siewior wrote:

> This is here most likely since the FSL bsp. Back in the FSL bsp it was
> set to 50Mhz and working. However the driver divided the SoC freq. only
> by 2. According to the TRM the platform clock (which the manual refers
> in its formula) is the system clock divided by two. So in the end it has
> to divide by 4 and this is what the fsl-spi driver in tree is doing.
> Since then the flash is not wokring I guess. After chaning the freq from
> 50Mhz to 40Mhz like others do then I can access the flash.
> 
> Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
> ---
> arch/powerpc/boot/dts/p1010rdb.dtsi |    2 +-
> arch/powerpc/boot/dts/p2020rdb.dts  |    2 +-
> 2 files changed, 2 insertions(+), 2 deletions(-)

applied

- k
