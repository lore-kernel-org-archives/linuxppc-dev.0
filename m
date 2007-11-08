Return-Path: <jdl@freescale.com>
Message-ID: <47331CC9.3080804@freescale.com>
Date: Thu, 08 Nov 2007 08:27:21 -0600
From: Jon Loeliger <jdl@freescale.com>
MIME-Version: 1.0
To: David Gibson <david@gibson.dropbear.id.au>
Subject: Re: [PATCH 4/4] Kill flatdevtree.c
References: <20071108033603.B6377DDE0E@ozlabs.org>
In-Reply-To: <20071108033603.B6377DDE0E@ozlabs.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: linuxppc-dev@ozlabs.org, Paul Mackerras <paulus@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

David Gibson wrote:
> Now that earlier patches have switched the bootwrapper to using libfdt
> for device tree manipulation, this patch removes the now unused
> flatdevtree.c and related files.
> 
> Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
> 
> ---
>  arch/powerpc/boot/Makefile           |    2 
>  arch/powerpc/boot/flatdevtree.c      | 1036 -----------------------------------
>  arch/powerpc/boot/flatdevtree.h      |  113 ---
>  arch/powerpc/boot/flatdevtree_misc.c |   79 --
>  arch/powerpc/boot/main.c             |    1 
>  arch/powerpc/boot/ops.h              |    1 
>  6 files changed, 1 insertion(+), 1231 deletions(-)

This sort of patch really appears a lot cleaner and nicer
using git and the -M flag to simply state which files
are removed outright.

*sigh*

jdl
