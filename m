Return-Path: <Geoffrey.Levand@am.sony.com>
Message-ID: <496E6CFF.8060605@am.sony.com>
Date: Wed, 14 Jan 2009 14:53:51 -0800
From: Geoff Levand <geoffrey.levand@am.sony.com>
MIME-Version: 1.0
To: Stephen Rothwell <sfr@canb.auug.org.au>
Subject: Re: [PATCH 06/13] powerpc/ps3: printing fixups for l64 to ll64
	conversion: arch/powerpc
References: <20090114165450.ebbc11a7.sfr@canb.auug.org.au>
	<20090114170239.7741b23c.sfr@canb.auug.org.au>
In-Reply-To: <20090114170239.7741b23c.sfr@canb.auug.org.au>
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
> Signed-off-by: Stephen Rothwell <sfr@canb.auug.org.au>
> ---
>  arch/powerpc/platforms/ps3/device-init.c |   26 +++++++++++++-------------
>  arch/powerpc/platforms/ps3/htab.c        |    2 +-
>  arch/powerpc/platforms/ps3/interrupt.c   |   16 ++++++++--------
>  arch/powerpc/platforms/ps3/mm.c          |   10 +++++-----
>  arch/powerpc/platforms/ps3/os-area.c     |    2 +-
>  arch/powerpc/platforms/ps3/repository.c  |   22 +++++++++++-----------
>  arch/powerpc/platforms/ps3/system-bus.c  |    6 +++---
>  7 files changed, 42 insertions(+), 42 deletions(-)

Acked-by: Geoff Levand <geoffrey.levand@am.sony.com>
