Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id 326E3B6F5D
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 30 Jun 2012 05:55:05 +1000 (EST)
Subject: Re: RFC [PATCH] fsl pci quirk to __devinit Re: PCIe end-point on FPGA
 doesn't show up on PCI bus when configured
Mime-Version: 1.0 (Apple Message framework v1278)
Content-Type: text/plain; charset=us-ascii
From: Kumar Gala <galak@kernel.crashing.org>
In-Reply-To: <1316446511.10785.34.camel@matias-lnx-host>
Date: Fri, 29 Jun 2012 14:55:03 -0500
Message-Id: <919B5123-A0A7-419D-8E57-6B0FCD798CDB@kernel.crashing.org>
References: <4D430CD4.6060201@rossvideo.com> <4D4321E1.7060506@gmail.com>
 <1316446511.10785.34.camel@matias-lnx-host>
To: Matias Garcia <mgarcia@rossvideo.com>
Cc: linuxppc-dev@lists.ozlabs.org, Elie De Brauwer <eliedebrauwer@gmail.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


On Sep 19, 2011, at 10:35 AM, Matias Garcia wrote:

> 
> Here's the patch against 2.6.37:
> 
> Change quirk_fsl_pcie_header from __init to __devinit.
> 
> Signed-off-by: Matias Garcia <mgarcia@rossvideo.com>

applied

- k
