Return-Path: <sr@denx.de>
Received: from mo-p05-ob.rzone.de (mo-p05-ob.rzone.de [81.169.146.180])
	(using TLSv1 with cipher EDH-RSA-DES-CBC3-SHA (168/168 bits))
	(Client did not present a certificate)
	by bilbo.ozlabs.org (Postfix) with ESMTPS id 813DBB7BE2
	for <linuxppc-dev@lists.ozlabs.org>;
	Fri, 21 Aug 2009 16:36:38 +1000 (EST)
From: Stefan Roese <sr@denx.de>
To: linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH 2/2] powerpc/405ex: support cuImage via included dtb
Date: Fri, 21 Aug 2009 08:35:58 +0200
References: <1250562484-16415-1-git-send-email-tiejun.chen@windriver.com>
	<20090820133118.GF2530@zod.rchland.ibm.com>
	<4A8E3396.9030006@windriver.com>
In-Reply-To: <4A8E3396.9030006@windriver.com>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="us-ascii"
Message-Id: <200908210835.58288.sr@denx.de>
Cc: "tiejun.chen" <tiejun.chen@windriver.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Friday 21 August 2009 07:41:42 tiejun.chen wrote:
> >> +static void kilauea_fixups(void)
> >> +{
> >> +	/*TODO: Please change this as the real. Note that should be
> >> 33MHZ~100MHZ.*/
> >
> > What does that mean?
>
> It's difficult to check the sysclk value on all revision Kilauea board for
> me, and we have to check this value only by the real target, not by reading
> one register. So I hope it's safe to remind other guys here.

Kilauea uses this value (33.333MHz) on all board revisions, AFAIK. Your 
comment is a bit confusing. I suggest that you just remove it.

Cheers,
Stefan
