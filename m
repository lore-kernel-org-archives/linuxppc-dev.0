Return-Path: <Geoffrey.Levand@am.sony.com>
Message-ID: <496E6D32.2050004@am.sony.com>
Date: Wed, 14 Jan 2009 14:54:42 -0800
From: Geoff Levand <geoffrey.levand@am.sony.com>
MIME-Version: 1.0
To: Stephen Rothwell <sfr@canb.auug.org.au>
Subject: Re: [PATCH 11/13] powerpc/ps3: printing fixups for l64 to ll64
	conversion: drivers/ps3
References: <20090114165450.ebbc11a7.sfr@canb.auug.org.au>
	<20090114171006.d5af608e.sfr@canb.auug.org.au>
In-Reply-To: <20090114171006.d5af608e.sfr@canb.auug.org.au>
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
> Also some min -> mint_t conversion.
> 
> Signed-off-by: Stephen Rothwell <sfr@canb.auug.org.au>
> ---
>  drivers/ps3/ps3-lpm.c     |   16 ++++++++--------
>  drivers/ps3/ps3-vuart.c   |    8 ++++----
>  drivers/ps3/ps3stor_lib.c |   14 +++++++-------
>  3 files changed, 19 insertions(+), 19 deletions(-)

Acked-by: Geoff Levand <geoffrey.levand@am.sony.com>
