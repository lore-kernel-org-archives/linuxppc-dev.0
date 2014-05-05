Return-Path: <mikey@neuling.org>
Message-ID: <1399270379.29252.1.camel@ale.ozlabs.ibm.com>
Subject: Re: [PATCH] powerpc/eeh: Fix build error for celleb
From: Michael Neuling <mikey@neuling.org>
To: Gavin Shan <gwshan@linux.vnet.ibm.com>
Date: Mon, 05 May 2014 16:12:59 +1000
In-Reply-To: <1399255745-2745-1-git-send-email-gwshan@linux.vnet.ibm.com>
References: <1399255745-2745-1-git-send-email-gwshan@linux.vnet.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Cc: linuxppc-dev@lists.ozlabs.org, Stephen Rothwell <sfr@canb.auug.org.au>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, 2014-05-05 at 12:09 +1000, Gavin Shan wrote:
> Commit 7f52a526f ("powerpc/eeh: Allow to disable EEH") caused
> following build error with "celleb_defconfig" as being catched
> by Mikey on linux-next.
>=20
> arch/powerpc/kernel/eeh.c: In function 'eeh_init_proc':
> arch/powerpc/kernel/eeh.c:1173:37: error: 'powerpc_debugfs_root' \
> undeclared (first use in this function)
> arch/powerpc/kernel/eeh.c:1173:37: note: each undeclared identifier \
> is reported only once for each function it appears in
>=20
> Reported-by: Michael Neuling <mikey@neuling.org>
> Signed-off-by: Gavin Shan <gwshan@linux.vnet.ibm.com>

Thanks.

> ---
>  arch/powerpc/kernel/eeh.c | 1 +
>  1 file changed, 1 insertion(+)
>=20
> diff --git a/arch/powerpc/kernel/eeh.c b/arch/powerpc/kernel/eeh.c
> index 33d683a..9c6b899 100644
> --- a/arch/powerpc/kernel/eeh.c
> +++ b/arch/powerpc/kernel/eeh.c
> @@ -36,6 +36,7 @@
>  #include <linux/of.h>
> =20
>  #include <linux/atomic.h>
> +#include <asm/debug.h>
>  #include <asm/eeh.h>
>  #include <asm/eeh_event.h>
>  #include <asm/io.h>
