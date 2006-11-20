Return-Path: <arnd@arndb.de>
From: Arnd Bergmann <arnd@arndb.de>
To: maynardj@us.ibm.com
Subject: Re: [PATCH 1/1]OProfile for Cell bug fix
Date: Mon, 20 Nov 2006 21:21:01 +0100
References: <4561DCE8.20502@us.ibm.com>
In-Reply-To: <4561DCE8.20502@us.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Message-Id: <200611202121.01573.arnd@arndb.de>
Cc: linuxppc-dev@ozlabs.org, cbe-oss-dev@ozlabs.org,
	oprofile-list@lists.sourceforge.net, linux-kernel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Monday 20 November 2006 17:50, Maynard Johnson wrote:
>   Subject: Bug fixes for OProfile for Cell
>
> From: Maynard Johnson <maynardj@us.ibm.com>
>
> This patch contains three crucial fixes:
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0- op_model_cell.c:cell_vi=
rtual_cntr: correctly access the per-cpu
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 =C2=A0pmc_values arrays
>
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0- op_model_cell.c:cell_re=
g_setup: =C2=A0initialize _all_ 4 elements of
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 =C2=A0pmc_values with re=
set_value
>
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0- include/asm-powerpc/cel=
l-pmu.h: =C2=A0fix broken macro,
> PM07_CTR_INPUT_MUX
>
> Signed-off-by: Carl Love <carll@us.ibm.com>
> Signed-off-by: Maynard Johnson <mpjohn@us.ibm.com>

Ok, looks good. I've posted the combined oprofile patch now as part of
my cell patch series for 2.6.20, using the version you sent me during
the Weekend. Can you check that everything from this patch is included
there as well?

	Arnd <><
