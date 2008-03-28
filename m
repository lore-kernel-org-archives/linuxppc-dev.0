Return-Path: <glikely@secretlab.ca>
Received: from an-out-0708.google.com (an-out-0708.google.com [209.85.132.240])
	by ozlabs.org (Postfix) with ESMTP id D7E66DE029
	for <linuxppc-dev@ozlabs.org>; Sat, 29 Mar 2008 10:56:02 +1100 (EST)
Received: by an-out-0708.google.com with SMTP id c37so114927anc.78
	for <linuxppc-dev@ozlabs.org>; Fri, 28 Mar 2008 16:56:01 -0700 (PDT)
Message-ID: <fa686aa40803281656w2435672auf7cbad735cdc477e@mail.gmail.com>
Date: Fri, 28 Mar 2008 17:56:00 -0600
From: "Grant Likely" <grant.likely@secretlab.ca>
Sender: glikely@secretlab.ca
To: "Dale Farnsworth" <dale@farnsworth.org>
Subject: Re: [PATCH 9/9] [POWERPC] prpmc2800 needs a dtbImage
In-Reply-To: <20080328235213.GI30214@farnsworth.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
References: <20080328233954.GA29499@farnsworth.org>
	<20080328235213.GI30214@farnsworth.org>
Cc: linuxppc-dev@ozlabs.org, paulus@samba.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Fri, Mar 28, 2008 at 5:52 PM, Dale Farnsworth <dale@farnsworth.org> wrote:
> From: Dale Farnsworth <dale@farnsworth.org>
>
>  The prpmc2800 platform requires a zImage formatted file with an
>  embedded dtb file.  Rename the requested boot image file to
>  dtbImage.prpmc2800.
>
>  Signed-off-by: Dale Farnsworth <dale@farnsworth.org>
>  Acked-by: Mark A. Greer <mgreer@mvista.com>

Acked-by: Grant Likely <grant.likely@secretlab.ca>

>
>  --- a/arch/powerpc/boot/Makefile
>  +++ b/arch/powerpc/boot/Makefile
>  @@ -192,7 +192,7 @@ image-$(CONFIG_PPC_CHRP)            += zImage.chrp
>   image-$(CONFIG_PPC_EFIKA)              += zImage.chrp
>   image-$(CONFIG_PPC_PMAC)               += zImage.pmac
>   image-$(CONFIG_PPC_HOLLY)              += zImage.holly
>  -image-$(CONFIG_PPC_PRPMC2800)          += zImage.prpmc2800
>  +image-$(CONFIG_PPC_PRPMC2800)          += dtbImage.prpmc2800
>   image-$(CONFIG_PPC_ISERIES)            += zImage.iseries
>   image-$(CONFIG_DEFAULT_UIMAGE)         += uImage
>
>  _______________________________________________
>  Linuxppc-dev mailing list
>  Linuxppc-dev@ozlabs.org
>  https://ozlabs.org/mailman/listinfo/linuxppc-dev
>



-- 
Grant Likely, B.Sc., P.Eng.
Secret Lab Technologies Ltd.
