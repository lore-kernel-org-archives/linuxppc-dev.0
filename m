Return-Path: <sr@denx.de>
Received: from mo-p05-ob.rzone.de (mo-p05-ob.rzone.de [81.169.146.180])
	(using TLSv1 with cipher EDH-RSA-DES-CBC3-SHA (168/168 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 0F72AB70A8
	for <linuxppc-dev@lists.ozlabs.org>;
	Wed, 24 Nov 2010 16:30:40 +1100 (EST)
From: Stefan Roese <sr@denx.de>
To: Rupjyoti Sarmah <rsarmah@apm.com>
Subject: Re: [PATCH v1] ppc44x:PHY fixup for USB on canyonlands board
Date: Wed, 24 Nov 2010 06:30:26 +0100
References: <201011231256.oANCur3N016433@amcc.com>
	<201011231421.02377.sr@denx.de>
	<602c780cd2a81ee32f834a82814fe77f@mail.gmail.com>
In-Reply-To: <602c780cd2a81ee32f834a82814fe77f@mail.gmail.com>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="us-ascii"
Message-Id: <201011240630.26570.sr@denx.de>
Cc: linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wednesday 24 November 2010 05:55:03 Rupjyoti Sarmah wrote:
> >> +#define BCSR_USB_EN	0x11
> >
> >This define is wrong here. Its not common for all 44x platforms but
> 
> Canyonlands specific.
> 
> So, do you suggest to move this macro to the canyonlands.c ? Or introduce
> canyonlands.h ?

canyonlands.c is fine with me.

Cheers,
Stefan
