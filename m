Return-Path: <sr@denx.de>
Received: from mo-p05-ob.rzone.de (mo-p05-ob.rzone.de [81.169.146.181])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 84CABB70D1
	for <linuxppc-dev@lists.ozlabs.org>;
	Fri, 24 Sep 2010 16:58:32 +1000 (EST)
From: Stefan Roese <sr@denx.de>
To: linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH 1/2] PPC4xx: Generelizing drivers/dma/ppc4xx/adma.c
Date: Fri, 24 Sep 2010 08:58:04 +0200
References: <1284774145-14543-1-git-send-email-tmarri@apm.com>
	<4C9BB6EB.7020802@intel.com>
	<d2d7c3068b5582bde7529ccc65d71e52@mail.gmail.com>
In-Reply-To: <d2d7c3068b5582bde7529ccc65d71e52@mail.gmail.com>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="us-ascii"
Message-Id: <201009240858.05018.sr@denx.de>
Cc: herbert@gondor.hengli.com.au, Tirumala Marri <tmarri@apm.com>,
	yur@emcraft.com, linux-raid@vger.kernel.org, neilb@suse.de,
	linux-crypto@vger.kernel.org, Dan Williams <dan.j.williams@intel.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Friday 24 September 2010 00:39:47 Tirumala Marri wrote:
> > Will both versions of this driver exist in the same kernel build?  For
> > example the iop-adma driver supports iop13xx and iop3xx, but we select
> > the archtitecture at build time?  Or, as I assume in this case, will
> > the
> > two (maybe more?) ppc4xx adma drivers all be built in the same image,
> > more like ioatdma?
> 
> [Marri] We select the architecture at build time.

It would be really preferable to support all those platforms in a single Linux 
image. If technically possible, please try to move this direction.

Thanks.

Cheers,
Stefan
