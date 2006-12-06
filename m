Return-Path: <Geoffrey.Levand@am.sony.com>
Received: from outbound1-sin-R.bigfish.com (outbound-sin.frontbridge.com
	[207.46.51.80])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "*.bigfish.com", Issuer "*.bigfish.com" (not verified))
	by ozlabs.org (Postfix) with ESMTP id 3D0C667BFD
	for <linuxppc-dev@ozlabs.org>; Thu,  7 Dec 2006 06:45:17 +1100 (EST)
Message-ID: <45771DC3.8000505@am.sony.com>
Date: Wed, 06 Dec 2006 11:45:07 -0800
From: Geoff Levand <geoffrey.levand@am.sony.com>
MIME-Version: 1.0
To: Linas Vepstas <linas@austin.ibm.com>
Subject: Re: Bug report: CELL on linux-2.6.19-git7 won't build,
References: <20061206192745.GC17931@austin.ibm.com>
In-Reply-To: <20061206192745.GC17931@austin.ibm.com>
Content-Type: text/plain; charset=UTF-8
Cc: linuxppc-dev@ozlabs.org, Arnd Bergmann <arnd@arndb.de>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Linas Vepstas wrote:
> Hi Arnd, Geoff,
> 
> At this time, linux-2.6.19-git7 won't build when CELL is enabled, with the error
> 
>   CHECK   include/asm/spu_info.h
> /kernels/kernel.org/linux-2.6.19-git7/usr/include/asm/spu_info.h requires asm/spu.h, which does not exist in exported headers

Linas,

Yes, that's with CONFIG_HEADERS_CHECK=y.  Arnd sent that fix
out yesterday.  Please see:

  http://ozlabs.org/pipermail/linuxppc-dev/2006-December/028829.html

-Geoff
