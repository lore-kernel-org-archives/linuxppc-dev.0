Return-Path: <arnd@arndb.de>
Received: from moutng.kundenserver.de (moutng.kundenserver.de
	[212.227.126.186]) by ozlabs.org (Postfix) with ESMTP id 04A82DDE20
	for <linuxppc-dev@ozlabs.org>; Wed, 31 Dec 2008 20:29:19 +1100 (EST)
From: Arnd Bergmann <arnd@arndb.de>
To: linuxppc-dev@ozlabs.org,
 Paul Mackerras <paulus@samba.org>
Subject: Re: [PATCH] powerpc/cell: bitops work on unsigned longs
Date: Wed, 31 Dec 2008 10:29:04 +0100
References: <20081231140615.51749e7f.sfr@canb.auug.org.au>
In-Reply-To: <20081231140615.51749e7f.sfr@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200812311029.05767.arnd@arndb.de>
Cc: Stephen Rothwell <sfr@canb.auug.org.au>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Wednesday 31 December 2008, Stephen Rothwell wrote:
> So change the flags member of struct spu from u64 to unsigned long.
> This change will also prevent some warnings when we change u64 to unsigned
> long long.

Thanks. I'm still on vacation right now, so it's probably best
if Paul takes these two patches directly.

> Signed-off-by: Stephen Rothwell <sfr@canb.auug.org.au>

Acked-by: Arnd Bergmann <arnd@arndb.de>
