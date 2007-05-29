Return-Path: <Geoffrey.Levand@am.sony.com>
Message-ID: <465C75EA.5020607@am.sony.com>
Date: Tue, 29 May 2007 11:50:18 -0700
From: Geoff Levand <geoffrey.levand@am.sony.com>
MIME-Version: 1.0
To: Stephen Rothwell <sfr@canb.auug.org.au>
Subject: Re: [PATCH] [POWERPC] ps3/interrupt.c uses get_hard_smp_processor_id
References: <20070528101908.2a5deab8.sfr@canb.auug.org.au>
In-Reply-To: <20070528101908.2a5deab8.sfr@canb.auug.org.au>
Content-Type: text/plain; charset=UTF-8
Cc: ppc-dev <linuxppc-dev@ozlabs.org>, paulus@samba.org, cbe-oss-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Stephen Rothwell wrote:
> and so needs to include asm/smp.h for a UP build to work.
> 
> Signed-off-by: Stephen Rothwell <sfr@canb.auug.org.au>
> ---
>  arch/powerpc/platforms/ps3/interrupt.c |    1 +
>  1 files changed, 1 insertions(+), 0 deletions(-)

Acked-by: Geoff Levand <geoffrey.levand@am.sony.com>
