Return-Path: <Geoffrey.Levand@am.sony.com>
Received: from outbound6-blu-R.bigfish.com (outbound-blu.frontbridge.com
	[65.55.251.16])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "*.bigfish.com", Issuer "*.bigfish.com" (not verified))
	by ozlabs.org (Postfix) with ESMTP id BF4A3DDEE3
	for <linuxppc-dev@ozlabs.org>; Sat, 12 May 2007 03:38:17 +1000 (EST)
Message-ID: <4644A9FA.4050108@am.sony.com>
Date: Fri, 11 May 2007 10:38:02 -0700
From: Geoff Levand <geoffrey.levand@am.sony.com>
MIME-Version: 1.0
To: paulus@samba.org
Subject: Re: [PATCH] [POWERPC] trivial ps3 fixups
References: <20070511154244.34ad81e6.sfr@canb.auug.org.au>
In-Reply-To: <20070511154244.34ad81e6.sfr@canb.auug.org.au>
Content-Type: text/plain; charset=UTF-8
Cc: Stephen Rothwell <sfr@canb.auug.org.au>, ppc-dev <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Stephen Rothwell wrote:
> Fixes warnings:
> 
> arch/powerpc/platforms/ps3/system-bus.c: In function 'ps3_map_sg':
> arch/powerpc/platforms/ps3/system-bus.c:278: warning: unused variable 'i'
> arch/powerpc/platforms/ps3/system-bus.c:277: warning: unused variable 'dev'
> arch/powerpc/platforms/ps3/setup.c:103: warning: 'prealloc' defined but not used
> 
> Signed-off-by: Stephen Rothwell <sfr@canb.auug.org.au>

Acked-by: Geoff Levand <geoffrey.levand@am.sony.com>
