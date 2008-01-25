Return-Path: <scottwood@freescale.com>
Received: from az33egw02.freescale.net (az33egw02.freescale.net
	[192.88.158.103])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "az33egw02.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 50C1ADDE03
	for <linuxppc-dev@ozlabs.org>; Fri, 25 Jan 2008 11:15:33 +1100 (EST)
Message-ID: <47992A27.1070409@freescale.com>
Date: Thu, 24 Jan 2008 18:15:35 -0600
From: Scott Wood <scottwood@freescale.com>
MIME-Version: 1.0
To: Paul Gortmaker <paul.gortmaker@windriver.com>
Subject: Re: [PATCH 3/10] CPM2: Make support for the CPM2 optional on 8560
	based	boards
References: <12012180922447-git-send-email-paul.gortmaker@windriver.com>	<12012180943940-git-send-email-paul.gortmaker@windriver.com>	<12012180944056-git-send-email-paul.gortmaker@windriver.com>
	<12012180951674-git-send-email-paul.gortmaker@windriver.com>
In-Reply-To: <12012180951674-git-send-email-paul.gortmaker@windriver.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Paul Gortmaker wrote:
> @@ -41,7 +42,7 @@ config MPC85xx_DS
>  config SBC8560
>  	bool "Wind River SBC8560"
>  	select DEFAULT_UIMAGE
> -	select PPC_CPM_NEW_BINDING
> +	select PPC_CPM_NEW_BINDING if CPM2
>  	help
>  	  This option enables support for the Wind River SBC8560 board

Setting PPC_CPM_NEW_BINGING should be harmless if CPM2 isn't set.  Looks 
good otherwise.

-Scott
