Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 928E7DDF51
	for <linuxppc-dev@ozlabs.org>; Fri, 18 Jan 2008 17:49:34 +1100 (EST)
Date: Fri, 18 Jan 2008 00:46:53 -0600 (CST)
From: Kumar Gala <galak@kernel.crashing.org>
To: Timur Tabi <timur@freescale.com>
Subject: Re: [PATCH v7] qe: add ability to upload QE firmware
In-Reply-To: <11998098582795-git-send-email-timur@freescale.com>
Message-ID: <Pine.LNX.4.64.0801180046400.16260@blarg.am.freescale.net>
References: <11998098582795-git-send-email-timur@freescale.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: linuxppc-dev@ozlabs.org, sfr@canb.auug.org.au
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Tue, 8 Jan 2008, Timur Tabi wrote:

> Define the layout of a binary blob that contains a QE firmware and instructions
> on how to upload it.  Add function qe_upload_firmware() to parse the blob
> and perform the actual upload.  Fully define 'struct rsp' in immap_qe.h to
> include the actual RISC Special Registers.  Added description of a new
> QE firmware node to booting-without-of.txt.
>
> Signed-off-by: Timur Tabi <timur@freescale.com>
> ---
>
> Updated w.r.t. comments from Stephen R.
>
> This patch is for Kumar's for-2.6.25 branch.  This code is necessary for
> my QE UART driver.
>
>  Documentation/powerpc/00-INDEX               |    3 +
>  Documentation/powerpc/booting-without-of.txt |   33 +++-
>  Documentation/powerpc/qe_firmware.txt        |  295 ++++++++++++++++++++++++++
>  arch/powerpc/platforms/Kconfig               |    1 +
>  arch/powerpc/sysdev/qe_lib/qe.c              |  247 +++++++++++++++++++++
>  include/asm-powerpc/immap_qe.h               |   34 +++-
>  include/asm-powerpc/qe.h                     |   61 ++++++
>  7 files changed, 670 insertions(+), 4 deletions(-)
>  create mode 100644 Documentation/powerpc/qe_firmware.txt
>

applied.

- k
