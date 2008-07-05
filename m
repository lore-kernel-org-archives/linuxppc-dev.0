Return-Path: <olof@lixom.net>
Received: from elcamino.pasemi.com (elcamino.pasemi.com [67.155.108.98])
	by ozlabs.org (Postfix) with ESMTP id D99DCDDE17
	for <linuxppc-dev@ozlabs.org>; Sun,  6 Jul 2008 03:51:44 +1000 (EST)
Message-Id: <8B28A4E9-CDFF-46F1-80A5-08B6A8DFEA8D@lixom.net>
From: Olof Johansson <olof@lixom.net>
To: Robert Jennings <rcj@linux.vnet.ibm.com>
In-Reply-To: <20080704125459.GM1310@linux.vnet.ibm.com>
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Mime-Version: 1.0 (Apple Message framework v926)
Subject: Re: [PATCH 10/16 v3] powerpc: iommu enablement for CMO
Date: Sat, 5 Jul 2008 12:51:41 -0500
References: <20080704125459.GM1310@linux.vnet.ibm.com>
Cc: Brian King <brking@linux.vnet.ibm.com>, linuxppc-dev@ozlabs.org,
	paulus@samba.org, David Darrington <ddarring@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Hi,

On Jul 4, 2008, at 7:54 AM, Robert Jennings wrote:

> To support Cooperative Memory Overcommitment (CMO), we need to check
> for failure from some of the tce hcalls.
>
> These changes for the pseries platform affect the powerpc  
> architecture;
> patches for the other affected platforms are included in this patch.
>
> pSeries platform IOMMU code changes:
> * platform TCE functions must handle H_NOT_ENOUGH_RESOURCES errors and
>   return an error.
>
> Architecture IOMMU code changes:
> * Calls to ppc_md.tce_build need to check return values and return
>   DMA_MAPPING_ERROR for transient errors.
>
> Architecture changes:
> * struct machdep_calls for tce_build*_pSeriesLP functions need to  
> change
>   to indicate failure.
> * all other platforms will need updates to iommu functions to match  
> the new
>   calling semantics; they will return 0 on success.  The other  
> platforms
>   default configs have been built, but no further testing was  
> performed.
>
> Signed-off-by: Robert Jennings <rcj@linux.vnet.ibm.com>

Acked-by: Olof Johansson <olof@lixom.net>
