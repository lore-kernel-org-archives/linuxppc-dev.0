Return-Path: <scottwood@freescale.com>
Received: from az33egw02.freescale.net (az33egw02.freescale.net
	[192.88.158.103])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "az33egw02.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 30409DDE01
	for <linuxppc-dev@ozlabs.org>; Sat,  2 Feb 2008 06:24:34 +1100 (EST)
Date: Fri, 1 Feb 2008 13:23:45 -0600
From: Scott Wood <scottwood@freescale.com>
To: Doug Maxey <dwm@austin.ibm.com>
Subject: Re: [PATCH 4/5] ehea: fix phyp checkpatch complaints
Message-ID: <20080201192344.GA4541@loki.buserror.net>
References: <1201832451-23634-1-git-send-email-dwm@austin.ibm.com>
	<1201832451-23634-5-git-send-email-dwm@austin.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1201832451-23634-5-git-send-email-dwm@austin.ibm.com>
Cc: Linux PowerPC List <linuxppc-dev@ozlabs.org>,
	Jan-Bernd Themann <themann@de.ibm.com>, Jeff Garzik <jgarzik@garzik.org>,
	Paul Mackerras <paulus@samba.org>, netdev@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Thu, Jan 31, 2008 at 08:20:50PM -0600, Doug Maxey wrote:
>  /* input param R5 */
> -#define H_ALL_RES_QP_EQPO         EHEA_BMASK_IBM(9, 11)
> -#define H_ALL_RES_QP_QPP          EHEA_BMASK_IBM(12, 12)
> -#define H_ALL_RES_QP_RQR          EHEA_BMASK_IBM(13, 15)
> -#define H_ALL_RES_QP_EQEG         EHEA_BMASK_IBM(16, 16)
> -#define H_ALL_RES_QP_LL_QP        EHEA_BMASK_IBM(17, 17)
> -#define H_ALL_RES_QP_DMA128       EHEA_BMASK_IBM(19, 19)
> -#define H_ALL_RES_QP_HSM          EHEA_BMASK_IBM(20, 21)
> -#define H_ALL_RES_QP_SIGT         EHEA_BMASK_IBM(22, 23)
> -#define H_ALL_RES_QP_TENURE       EHEA_BMASK_IBM(48, 55)
> -#define H_ALL_RES_QP_RES_TYP      EHEA_BMASK_IBM(56, 63)
> +#define H_ALL_RES_QP_EQPO	  EHEA_BMASK_IBM(9, 11)
> +#define H_ALL_RES_QP_QPP	  EHEA_BMASK_IBM(12, 12)
> +#define H_ALL_RES_QP_RQR	  EHEA_BMASK_IBM(13, 15)
> +#define H_ALL_RES_QP_EQEG	  EHEA_BMASK_IBM(16, 16)
> +#define H_ALL_RES_QP_LL_QP	  EHEA_BMASK_IBM(17, 17)
> +#define H_ALL_RES_QP_DMA128	  EHEA_BMASK_IBM(19, 19)
> +#define H_ALL_RES_QP_HSM	  EHEA_BMASK_IBM(20, 21)
> +#define H_ALL_RES_QP_SIGT	  EHEA_BMASK_IBM(22, 23)
> +#define H_ALL_RES_QP_TENURE	  EHEA_BMASK_IBM(48, 55)
> +#define H_ALL_RES_QP_RES_TYP	  EHEA_BMASK_IBM(56, 63)

This was better the way it was (before, it was readable at any tab setting);
checkpatch is overeager to complain on tab/space issues (it's a bit hard to
distinguish indentation from alignment with a regex).

-Scott
