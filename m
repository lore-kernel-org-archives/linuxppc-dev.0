Return-Path: <tmarri@apm.com>
Received: from exprod5og108.obsmtp.com (exprod5og108.obsmtp.com [64.18.0.186])
	by ozlabs.org (Postfix) with SMTP id 9F06FB6EE9
	for <linuxppc-dev@ozlabs.org>; Wed, 22 Sep 2010 02:58:14 +1000 (EST)
Received: by mail-ew0-f50.google.com with SMTP id 24so1955439ewy.9
	for <linuxppc-dev@ozlabs.org>; Tue, 21 Sep 2010 09:58:12 -0700 (PDT)
From: Tirumala Marri <tmarri@apm.com>
References: <1284774145-14543-1-git-send-email-tmarri@apm.com>
	<loom.20100919T215645-646@post.gmane.org>
In-Reply-To: <loom.20100919T215645-646@post.gmane.org>
MIME-Version: 1.0
Date: Tue, 21 Sep 2010 09:51:32 -0700
Message-ID: <322ffe990b9c7295977accbdec0e6e99@mail.gmail.com>
Subject: RE: [PATCH 1/2] PPC4xx: Generelizing drivers/dma/ppc4xx/adma.c
To: Ilya Yanok <yanok@emcraft.com>, linuxppc-dev@ozlabs.org
Content-Type: text/plain; charset=ISO-8859-1
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

> -----Original Message-----
> From: linuxppc-dev-bounces+tmarri=amcc.com@lists.ozlabs.org
> [mailto:linuxppc-dev-bounces+tmarri=amcc.com@lists.ozlabs.org] On
> Behalf Of Ilya Yanok
> Sent: Sunday, September 19, 2010 1:01 PM
> To: linuxppc-dev@ozlabs.org
> Subject: Re: [PATCH 1/2] PPC4xx: Generelizing drivers/dma/ppc4xx/adma.c
>
> Hi Tirumala,
>
> >  drivers/dma/ppc4xx/adma.c        | 4370 +++-------------------------
> ----------
> >  drivers/dma/ppc4xx/adma.h        |  116 +-
> >  drivers/dma/ppc4xx/ppc4xx-adma.h | 4020
> +++++++++++++++++++++++++++++++++++
>
> You've moved tons of code to the header file. Why?
>
> Regards, Ilya.
>
My intention is to keep the SoC specific code in the header files.
Something iop-dma is also doing.
