Return-Path: <dan.j.williams@gmail.com>
Received: from gv-out-0910.google.com (gv-out-0910.google.com [216.239.58.189])
	by ozlabs.org (Postfix) with ESMTP id 60A9EDDE20
	for <linuxppc-dev@ozlabs.org>; Fri, 28 Mar 2008 06:37:55 +1100 (EST)
Received: by gv-out-0910.google.com with SMTP id p33so945066gvf.14
	for <linuxppc-dev@ozlabs.org>; Thu, 27 Mar 2008 12:37:53 -0700 (PDT)
Message-ID: <e9c3a7c20803271237x1b2c3a2ci6837c5e2d5288c95@mail.gmail.com>
Date: Thu, 27 Mar 2008 12:37:52 -0700
From: "Dan Williams" <dan.j.williams@intel.com>
Sender: dan.j.williams@gmail.com
To: "Zhang Wei" <wei.zhang@freescale.com>,
	"Andrew Morton" <akpm@linux-foundation.org>
Subject: Re: [PATCH] fsldma: The MPC8377MDS board device tree node for fsldma
	driver
In-Reply-To: <1206517356-11209-2-git-send-email-wei.zhang@freescale.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
References: <1206517356-11209-1-git-send-email-wei.zhang@freescale.com>
	<1206517356-11209-2-git-send-email-wei.zhang@freescale.com>
Cc: linuxppc-dev@ozlabs.org, Linux Kernel <linux-kernel@vger.kernel.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Wed, Mar 26, 2008 at 12:42 AM, Zhang Wei <wei.zhang@freescale.com> wrote:
> The fsldma driver is tested on MPC8377MDS board.
>  The patch adds fsldma driver support into MPC8377MDS device tree.
>
>  Signed-off-by: Zhang Wei <wei.zhang@freescale.com>
>  ---
>   arch/powerpc/boot/dts/mpc8377_mds.dts |   27 +++++++++++++++++++++++++++
>   1 files changed, 27 insertions(+), 0 deletions(-)

I think this patch should probably go through the powerpc tree, or
-mm.  I'll pick up the ones that touch either drivers/dma or
crypto/async_tx.

--
Dan
