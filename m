Return-Path: <avorontsov@ru.mvista.com>
Received: from buildserver.ru.mvista.com (unknown [85.21.88.6])
	by ozlabs.org (Postfix) with ESMTP id DBC87DDE00
	for <linuxppc-dev@ozlabs.org>; Wed, 17 Dec 2008 03:51:44 +1100 (EST)
Date: Tue, 16 Dec 2008 19:51:43 +0300
From: Anton Vorontsov <avorontsov@ru.mvista.com>
To: Kumar Gala <galak@kernel.crashing.org>
Subject: Re: Please pull from 'next' branch
Message-ID: <20081216165143.GA25492@oksana.dev.rtsoft.ru>
References: <Pine.LNX.4.64.0812151430430.29867@blarg.am.freescale.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=windows-1251
In-Reply-To: <Pine.LNX.4.64.0812151430430.29867@blarg.am.freescale.net>
Cc: linuxppc-dev@ozlabs.org, Paul Mackerras <paulus@samba.org>
Reply-To: avorontsov@ru.mvista.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Hi Kumar,

On Mon, Dec 15, 2008 at 02:31:04PM -0600, Kumar Gala wrote:
> Please pull from 'next' branch of
> 
> 	master.kernel.org:/pub/scm/linux/kernel/git/galak/powerpc.git next
> 
> to receive the following updates:
> 
>  arch/powerpc/boot/dts/mpc8572ds.dts |   16 ++++++++--------
>  arch/powerpc/include/asm/cputable.h |   15 ++++++++-------
>  2 files changed, 16 insertions(+), 15 deletions(-)
> 
> Benjamin Herrenschmidt (1):
>       powerpc: Fix bogus cache flushing on all 40x and BookE processors v2
> 
> Kumar Gala (1):
>       powerpc/85xx: Fix compile issues with mpc8572ds.dts

Could you please take a look into these:

powerpc/qe: Select QE_USB with USB_GADGET_FSL_QE
http://patchwork.ozlabs.org/patch/7892/

[1/5] powerpc/qe: Implement QE Pin Multiplexing API
http://patchwork.ozlabs.org/patch/11982/

[2/5] powerpc: Implement GPIO driver for simple memory-mapped banks
http://patchwork.ozlabs.org/patch/11984/

[3/5] powerpc/83xx: Add USB Host/Gadget support for MPC8360E-MDS boards
http://patchwork.ozlabs.org/patch/11985/

[4/5] powerpc/83xx: Add USB Host support for MPC8360E-RDK boards
http://patchwork.ozlabs.org/patch/11986/

[5/5] powerpc/83xx: Fix sparse warnings in mpc836x_mds.c
http://patchwork.ozlabs.org/patch/11987/

powerpc/83xx: Fix sparse warnings in board files
http://patchwork.ozlabs.org/patch/12419/

powerpc/83xx: Fix few build errors with CONFIG_QUICC_ENGINE=n
http://patchwork.ozlabs.org/patch/12425/
-- OR --
powerpc/qe: Fix few build errors with CONFIG_QUICC_ENGINE=n
http://patchwork.ozlabs.org/patch/12426/

Thanks,

-- 
Anton Vorontsov
email: cbouatmailru@gmail.com
irc://irc.freenode.net/bd2
