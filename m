Return-Path: <Geoffrey.Levand@am.sony.com>
Message-ID: <496E6CF7.1040905@am.sony.com>
Date: Wed, 14 Jan 2009 14:53:43 -0800
From: Geoff Levand <geoffrey.levand@am.sony.com>
MIME-Version: 1.0
To: Stephen Rothwell <sfr@canb.auug.org.au>
Subject: Re: [PATCH 05/13] powerpc/ps3: ps3_repository_read_mm_info takes
	u64 * arguments
References: <20090114165450.ebbc11a7.sfr@canb.auug.org.au>
	<20090114170128.797f5795.sfr@canb.auug.org.au>
In-Reply-To: <20090114170128.797f5795.sfr@canb.auug.org.au>
Content-Type: text/plain; charset="ISO-8859-1"
Cc: ppc-dev <linuxppc-dev@ozlabs.org>, cbe-oss-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Stephen Rothwell wrote:
> Fixes compiler warnings:
> 
> arch/powerpc/platforms/ps3/mm.c:1205: warning: passing argument 2 of 'ps3_repository_read_mm_info' from incompatible pointer type
> arch/powerpc/platforms/ps3/mm.c:1205: warning: passing argument 3 of 'ps3_repository_read_mm_info' from incompatible pointer type
> 
> Signed-off-by: Stephen Rothwell <sfr@canb.auug.org.au>
> ---
>  arch/powerpc/platforms/ps3/mm.c |   17 ++++++++---------
>  1 files changed, 8 insertions(+), 9 deletions(-)

Acked-by: Geoff Levand <geoffrey.levand@am.sony.com>
