Return-Path: <SRS0=yWDH=R7=denx.de=sr@srs.kundenserver.de>
Received: from moutng.kundenserver.de (moutng.kundenserver.de
	[212.227.126.183]) by ozlabs.org (Postfix) with ESMTP id D920ADDF58
	for <linuxppc-dev@ozlabs.org>; Thu, 10 Jan 2008 02:11:58 +1100 (EST)
From: Stefan Roese <sr@denx.de>
To: linuxppc-dev@ozlabs.org
Subject: Re: [PATCH] enable built-in networking for Sequoia defconfig
Date: Wed, 9 Jan 2008 16:06:59 +0100
References: <1199489214.9673.18.camel@basalt>
	<20080109060723.06885abd@zod.rchland.ibm.com>
	<200801091542.38914.matthias.fuchs@esd-electronics.com>
In-Reply-To: <200801091542.38914.matthias.fuchs@esd-electronics.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200801091606.59541.sr@denx.de>
Cc: Hollis Blanchard <hollisb@us.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Wednesday 09 January 2008, Matthias Fuchs wrote:
> > The defconfig?  Not sure.  What I normally do is a make foo_defconfig,
> > edit the .config, make oldconfig, and copy the resulting .config back
> > to foo_defconfig.
>
> Yes, this is what I also do.
>
> But how did Hollis get these lines into .config or sequoia_defconfig:
>
> +CONFIG_IBM_NEW_EMAC=3Dy
> +CONFIG_IBM_NEW_EMAC_RXB=3D128
> +CONFIG_IBM_NEW_EMAC_TXB=3D64
> +CONFIG_IBM_NEW_EMAC_POLL_WEIGHT=3D32
> +CONFIG_IBM_NEW_EMAC_RX_COPY_THRESHOLD=3D256
> +CONFIG_IBM_NEW_EMAC_RX_SKB_HEADROOM=3D0
>
> I did not find any Kconfigs where these might come from.

Take a look at drivers/net/ibm_newemac/Kconfig.

Viele Gr=FC=DFe,
Stefan

=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
DENX Software Engineering GmbH,     MD: Wolfgang Denk & Detlev Zundel
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany
Phone: +49-8142-66989-0 Fax: +49-8142-66989-80  Email: office@denx.de
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
