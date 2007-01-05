Return-Path: <m.kozlowski@tuxland.pl>
Received: from tuxland.pl (xdsl-664.zgora.dialog.net.pl [81.168.226.152])
	by ozlabs.org (Postfix) with ESMTP id ABDE8DDE20
	for <linuxppc-dev@ozlabs.org>; Sat,  6 Jan 2007 03:23:06 +1100 (EST)
From: Mariusz Kozlowski <m.kozlowski@tuxland.pl>
To: Andrew Morton <akpm@osdl.org>
Subject: Re: 2.6.20-rc3-mm1
Date: Fri, 5 Jan 2007 17:23:07 +0100
References: <20070104220200.ae4e9a46.akpm@osdl.org>
In-Reply-To: <20070104220200.ae4e9a46.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200701051723.08112.m.kozlowski@tuxland.pl>
Cc: linuxppc-dev@ozlabs.org, linux-kernel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Hello, 

	Doesn't build on my iMac G3 based garage jukebox ;-)

arch/powerpc/kernel/of_platform.c:479: error: unknown field 'multithread_probe' specified in initializer
arch/powerpc/kernel/of_platform.c:479: warning: initialization makes pointer from integer without a cast
make[1]: *** [arch/powerpc/kernel/of_platform.o] Blad 1
make: *** [arch/powerpc/kernel] Blad 2

I guess someone who knows multithread code should take a look at it.

-- 
Regards,

	Mariusz Kozlowski
