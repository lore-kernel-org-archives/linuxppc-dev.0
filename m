Return-Path: <tmarri@apm.com>
Received: from exprod5og113.obsmtp.com (exprod5og113.obsmtp.com [64.18.0.26])
	by ozlabs.org (Postfix) with SMTP id E836BB70D1
	for <linuxppc-dev@lists.ozlabs.org>;
	Sat, 25 Sep 2010 04:53:03 +1000 (EST)
Received: by qyk5 with SMTP id 5so4377574qyk.11
	for <linuxppc-dev@lists.ozlabs.org>;
	Fri, 24 Sep 2010 11:53:00 -0700 (PDT)
From: Tirumala Marri <tmarri@apm.com>
References: <1284774145-14543-1-git-send-email-tmarri@apm.com>
	<4C9BB6EB.7020802@intel.com>
	<d2d7c3068b5582bde7529ccc65d71e52@mail.gmail.com>
	<201009240858.05018.sr@denx.de>
In-Reply-To: <201009240858.05018.sr@denx.de>
MIME-Version: 1.0
Date: Fri, 24 Sep 2010 11:52:49 -0700
Message-ID: <ba171a39721d9cfd3e7c8ca8d287f485@mail.gmail.com>
Subject: RE: [PATCH 1/2] PPC4xx: Generelizing drivers/dma/ppc4xx/adma.c
To: Stefan Roese <sr@denx.de>, linuxppc-dev@lists.ozlabs.org
Content-Type: text/plain; charset=ISO-8859-1
Cc: neilb@suse.de, yur@emcraft.com, linux-raid@vger.kernel.org,
	herbert@gondor.hengli.com.au, linux-crypto@vger.kernel.org,
	Dan Williams <dan.j.williams@intel.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

>
> It would be really preferable to support all those platforms in a
> single Linux
> image. If technically possible, please try to move this direction.
It is do-able for couple of SoCs. Other SoC DMA engines are quite a bit
different.
Let me first do small steps first and slowly achieve some run time
Differentiation.

Thanks,
Marri
