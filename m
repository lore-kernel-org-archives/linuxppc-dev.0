Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id E022A2C00A0
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 18 Aug 2012 00:07:24 +1000 (EST)
Subject: Re: [PATCH] powerpc/mpc85xx:Add new ext fields to Integrated FLash
 Controller
Mime-Version: 1.0 (Apple Message framework v1278)
Content-Type: text/plain; charset=us-ascii
From: Kumar Gala <galak@kernel.crashing.org>
In-Reply-To: <1345089502-23979-1-git-send-email-prabhakar@freescale.com>
Date: Fri, 17 Aug 2012 09:07:26 -0500
Message-Id: <34D5F708-A01E-4B57-8B7E-20BB988590F9@kernel.crashing.org>
References: <1345089502-23979-1-git-send-email-prabhakar@freescale.com>
To: Prabhakar Kushwaha <prabhakar@freescale.com>
Cc: linuxppc-dev@lists.ozlabs.org, York Sun <yorksun@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


On Aug 15, 2012, at 10:58 PM, Prabhakar Kushwaha wrote:

> Freescale's Integrated Flash controller(IFC) v1.1.0 supports 40 bit
> address bus width. 
> In case more than 32 bit address is used, the EXT registers should be set.
> 
> Add support of ext registers.
> 
> Signed-off-by: Kumar Gala <galak@kernel.crashing.org>
> Signed-off-by: York Sun <yorksun@freescale.com>
> Signed-off-by: Prabhakar Kushwaha <prabhakar@freescale.com>
> ---
> Base upon git://git.kernel.org/pub/scm/linux/kernel/git/galak/powerpc.git
> Branch next
> 
> arch/powerpc/include/asm/fsl_ifc.h |   14 ++++++++------
> 1 file changed, 8 insertions(+), 6 deletions(-)

applied to next

- k
