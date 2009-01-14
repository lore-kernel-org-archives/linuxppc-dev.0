Return-Path: <Geoffrey.Levand@am.sony.com>
Message-ID: <496E6CCA.4010309@am.sony.com>
Date: Wed, 14 Jan 2009 14:52:58 -0800
From: Geoff Levand <geoffrey.levand@am.sony.com>
MIME-Version: 1.0
To: Stephen Rothwell <sfr@canb.auug.org.au>
Subject: Re: [PATCH 01/13] powerpc/ps3: set_dabr takes an unsigned long
References: <20090114165450.ebbc11a7.sfr@canb.auug.org.au>
In-Reply-To: <20090114165450.ebbc11a7.sfr@canb.auug.org.au>
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

Hi Stephen,

Thanks for working through it and making these fixups.  I
tested the set applied onto Ben's powerpc tree and they
seem to work OK (with ps3_defconfig).

Stephen Rothwell wrote:
> Also silences this warning:
> 
> arch/powerpc/platforms/ps3/setup.c:275: warning: initialization from incompatible pointer type
> 
> Signed-off-by: Stephen Rothwell <sfr@canb.auug.org.au>
> ---
>  arch/powerpc/platforms/ps3/setup.c |    2 +-
>  1 files changed, 1 insertions(+), 1 deletions(-)

Acked-by: Geoff Levand <geoffrey.levand@am.sony.com>
