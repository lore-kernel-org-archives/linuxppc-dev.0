Return-Path: <apw@shadowen.org>
Received: from hellhawk.shadowen.org (hellhawk.shadowen.org [80.68.90.175])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 1CED1DDF12
	for <linuxppc-dev@ozlabs.org>; Thu, 10 May 2007 21:48:37 +1000 (EST)
Message-ID: <4643068C.8010302@shadowen.org>
Date: Thu, 10 May 2007 12:48:28 +0100
From: Andy Whitcroft <apw@shadowen.org>
MIME-Version: 1.0
To: Andrew Morton <akpm@linux-foundation.org>
Subject: Re: 2.6.21-mm2 -- powerpc missing kset
References: <20070509012322.199f292b.akpm@linux-foundation.org>
In-Reply-To: <20070509012322.199f292b.akpm@linux-foundation.org>
Content-Type: text/plain; charset=US-ASCII
Cc: linuxppc-dev@ozlabs.org, paulus@samba.org, linux-kernel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Getting this new compile failure on powerpc:

-apw

arch/powerpc/platforms/pseries/power.c:31: warning: `struct subsystem'
declared inside parameter list
arch/powerpc/platforms/pseries/power.c:31: warning: its scope is only
this definition or declaration, which is probably not what you want
arch/powerpc/platforms/pseries/power.c:37: warning: `struct subsystem'
declared inside parameter list
arch/powerpc/platforms/pseries/power.c:55: warning: initialization from
incompatible pointer type
arch/powerpc/platforms/pseries/power.c:56: warning: initialization from
incompatible pointer type
arch/powerpc/platforms/pseries/power.c: In function `pm_init':
arch/powerpc/platforms/pseries/power.c:75: error: structure has no
member named `kset'
make[2]: *** [arch/powerpc/platforms/pseries/power.o] Error 1
make[1]: *** [arch/powerpc/platforms/pseries] Error 2
make: *** [arch/powerpc/platforms] Error 2
