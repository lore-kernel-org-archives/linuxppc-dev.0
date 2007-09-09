Return-Path: <sam@ravnborg.org>
Received: from pasmtpB.tele.dk (pasmtpb.tele.dk [80.160.77.98])
	by ozlabs.org (Postfix) with ESMTP id 857DDDDE01
	for <linuxppc-dev@ozlabs.org>; Mon, 10 Sep 2007 04:38:08 +1000 (EST)
Date: Sun, 9 Sep 2007 20:39:29 +0200
From: Sam Ravnborg <sam@ravnborg.org>
To: Adrian Bunk <bunk@kernel.org>
Subject: Re: [2.6 patch] powerpc: proper defconfig for crosscompiles
Message-ID: <20070909183929.GA20443@uranus.ravnborg.org>
References: <20070909182117.GJ3563@stusta.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20070909182117.GJ3563@stusta.de>
Cc: linuxppc-dev@ozlabs.org, paulus@samba.org, linux-kernel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Sun, Sep 09, 2007 at 08:21:17PM +0200, Adrian Bunk wrote:
> The trick for finding the right defconfig is neat, but you forgot to 
> provide an i686_defconfig.  ;-)
> 
> More seriously, cross compiling the defconfig is often useful, e.g. for 
> testing the compilation of patches that touch multiple architectures, 
> and this patch therefore chooses g5_defconfig if $(CROSS_COMPILE) is 
> non-empty.

Thanks - much appreciated.

Acked-by: Sam Ravnborg <sam@ravnborg.org>

	Sam
