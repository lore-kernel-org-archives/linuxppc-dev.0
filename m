Return-Path: <olof@lixom.net>
Received: from mail.lixom.net (lixom.net [66.141.50.11])
	by ozlabs.org (Postfix) with ESMTP id DEDB4DDDFE
	for <linuxppc-dev@ozlabs.org>; Mon, 10 Sep 2007 06:39:41 +1000 (EST)
Date: Sun, 9 Sep 2007 15:40:17 -0500
From: Olof Johansson <olof@lixom.net>
To: Adrian Bunk <bunk@kernel.org>
Subject: Re: [2.6 patch] powerpc: proper defconfig for crosscompiles
Message-ID: <20070909204017.GA7275@lixom.net>
References: <20070909182117.GJ3563@stusta.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20070909182117.GJ3563@stusta.de>
Cc: linuxppc-dev@ozlabs.org, paulus@samba.org, linux-kernel@vger.kernel.org,
	Sam Ravnborg <sam@ravnborg.org>
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

You should probably use ppc64_defconfig instead, since it's the "superset"
config that will compile a multiplatform kernel.


-Olof
