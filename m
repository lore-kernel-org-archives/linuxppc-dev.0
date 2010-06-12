Return-Path: <agust@denx.de>
Received: from mail-out.m-online.net (mail-out.m-online.net [212.18.0.10])
	by ozlabs.org (Postfix) with ESMTP id 33C34B7D8C
	for <linuxppc-dev@lists.ozlabs.org>;
	Sat, 12 Jun 2010 22:56:16 +1000 (EST)
Date: Sat, 12 Jun 2010 14:56:08 +0200
From: Anatolij Gustschin <agust@denx.de>
To: Richard Cochran <richardcochran@gmail.com>
Subject: Re: [PATCH] powerpc: fix obsolete device tree code for the UPM NAND
	driver.
Message-ID: <20100612145608.28ba3953@wker>
In-Reply-To: <20100612123943.GA1982@riccoc20.at.omicron.at>
References: <20100612123943.GA1982@riccoc20.at.omicron.at>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Sat, 12 Jun 2010 14:39:43 +0200
Richard Cochran <richardcochran@gmail.com> wrote:

> Commit 58f9b0b02414062eaff46716bc04b47d7e79add5 removed of_device->node.
> This driver was apparently overlooked in the processes.
> 
> Signed-off-by: Richard Cochran <richard.cochran@omicron.at>
> ---
>  drivers/mtd/nand/fsl_upm.c |   18 ++++++++++--------
>  1 files changed, 10 insertions(+), 8 deletions(-)

This is already fixed in 2.6.35-rc2, please update your tree.
