Return-Path: <gregkh@linuxfoundation.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 37C1A1A000B
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 25 Feb 2015 11:32:32 +1100 (AEDT)
Received: from mail.linuxfoundation.org (mail.linuxfoundation.org
 [140.211.169.12])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id E1ACE140111
 for <linuxppc-dev@ozlabs.org>; Wed, 25 Feb 2015 11:32:31 +1100 (AEDT)
Date: Tue, 24 Feb 2015 16:32:29 -0800
From: Greg KH <gregkh@linuxfoundation.org>
To: Michael Ellerman <mpe@ellerman.id.au>
Subject: Re: [PATCH 1/3] cxl: Use image state defaults for reloading FPGA
Message-ID: <20150225003229.GA10806@kroah.com>
References: <1424665281-25431-1-git-send-email-mpe@ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1424665281-25431-1-git-send-email-mpe@ellerman.id.au>
Cc: grimm@linux.vnet.ibm.com, linuxppc-dev@ozlabs.org, imunsie@au.ibm.com,
 stable@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, Feb 23, 2015 at 03:21:19PM +1100, Michael Ellerman wrote:
> From: Ryan Grimm <grimm@linux.vnet.ibm.com>
> 
> Commit 4beb5421babee1204757b877622830c6aa31be6d upstream.
> 
> Select defaults such that a PERST causes flash image reload.  Select which
> image based on what the card is set up to load.
> 
> CXL_VSEC_PERST_LOADS_IMAGE selects whether PERST assertion causes flash image
> load.
> 
> CXL_VSEC_PERST_SELECT_USER selects which image is loaded on the next PERST.
> 
> cxl_update_image_control writes these bits into the VSEC.
> 
> Signed-off-by: Ryan Grimm <grimm@linux.vnet.ibm.com>
> Acked-by: Ian Munsie <imunsie@au1.ibm.com>
> Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
> ---
>  drivers/misc/cxl/cxl.h |  1 +
>  drivers/misc/cxl/pci.c | 42 ++++++++++++++++++++++++++++++++++++++++--
>  2 files changed, 41 insertions(+), 2 deletions(-)

What stable kernel(s) are you wanting this series to go into?

thanks,

greg k-h
