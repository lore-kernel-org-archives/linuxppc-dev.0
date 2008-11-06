Return-Path: <jeff@garzik.org>
Received: from mail.dvmed.net (srv5.dvmed.net [207.36.208.214])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id DA4FBDDDFA
	for <linuxppc-dev@ozlabs.org>; Thu,  6 Nov 2008 16:54:23 +1100 (EST)
Message-ID: <49128684.4040508@garzik.org>
Date: Thu, 06 Nov 2008 00:54:12 -0500
From: Jeff Garzik <jeff@garzik.org>
MIME-Version: 1.0
To: Hannes Hering <hannes.hering@linux.vnet.ibm.com>
Subject: Re: [PATCH] ehea: Fix some whitespace issues
References: <200811051318.21579.hannes.hering@linux.vnet.ibm.com>
In-Reply-To: <200811051318.21579.hannes.hering@linux.vnet.ibm.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: themann@de.ibm.com, netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	raisch@de.ibm.com, ossrosch@linux.vnet.ibm.com,
	linuxppc-dev@ozlabs.org, ossthema@de.ibm.com, osstklei@de.ibm.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Hannes Hering wrote:
> This patch removes some trailing whitespaces and spaces before tabs.
> 
> Signed-off-by: Hannes Hering <hering2@de.ibm.com>
> ---
> diff -Nurp -X dontdiff linux-2.6.28-rc3/drivers/net/ehea/ehea.h patched_kernel/drivers/net/ehea/ehea.h
> --- linux-2.6.28-rc3/drivers/net/ehea/ehea.h	2008-11-02 23:17:19.000000000 +0100
> +++ patched_kernel/drivers/net/ehea/ehea.h	2008-11-05 10:10:14.563107976 +0100
> @@ -40,7 +40,7 @@
>  #include <asm/io.h>
>  
>  #define DRV_NAME	"ehea"
> -#define DRV_VERSION	"EHEA_0095"
> +#define DRV_VERSION	"EHEA_0096"
>  
>  /* eHEA capability flags */
>  #define DLPAR_PORT_ADD_REM 1
> diff -Nurp -X dontdiff linux-2.6.28-rc3/drivers/net/ehea/ehea_qmr.c patched_kernel/drivers/net/ehea/ehea_qmr.c
> --- linux-2.6.28-rc3/drivers/net/ehea/ehea_qmr.c	2008-11-02 23:17:19.000000000 +0100
> +++ patched_kernel/drivers/net/ehea/ehea_qmr.c	2008-11-05 10:10:14.563107976 +0100
> @@ -653,7 +653,7 @@ static int ehea_update_busmap(unsigned l
>  		int top = ehea_calc_index(i, EHEA_TOP_INDEX_SHIFT);
>  		int dir = ehea_calc_index(i, EHEA_DIR_INDEX_SHIFT);
>  		int idx = i & EHEA_INDEX_MASK;
> -		
> +
>  		if (add) {
>  			int ret = ehea_init_bmap(ehea_bmap, top, dir);
>  			if (ret)
> @@ -780,7 +780,7 @@ void ehea_destroy_busmap(void)
>  
>  	kfree(ehea_bmap);
>  	ehea_bmap = NULL;
> -out_destroy:	
> +out_destroy:
>  	mutex_unlock(&ehea_busmap_mutex);
>  }
>  
> @@ -858,10 +858,10 @@ static u64 ehea_reg_mr_sections(int top,
>  	for (idx = 0; idx < EHEA_MAP_ENTRIES; idx++) {
>  		if (!ehea_bmap->top[top]->dir[dir]->ent[idx])
>  			continue;
> -		
> +
>  		hret = ehea_reg_mr_section(top, dir, idx, pt, adapter, mr);
>  		if ((hret != H_SUCCESS) && (hret != H_PAGE_REGISTERED))
> -			    	return hret;
> +			return hret;
>  	}
>  	return hret;
>  }
> @@ -879,7 +879,7 @@ static u64 ehea_reg_mr_dir_sections(int 
>  
>  		hret = ehea_reg_mr_sections(top, dir, pt, adapter, mr);
>  		if ((hret != H_SUCCESS) && (hret != H_PAGE_REGISTERED))
> -			    	return hret;
> +			return hret;
>  	}

applied
