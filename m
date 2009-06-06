Return-Path: <sr@denx.de>
Received: from ozlabs.org (ozlabs.org [203.10.76.45])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.ozlabs.org",
	Issuer "CA Cert Signing Authority" (verified OK))
	by bilbo.ozlabs.org (Postfix) with ESMTPS id 7C351B70B1
	for <linuxppc-dev@lists.ozlabs.org>;
	Sat,  6 Jun 2009 13:59:56 +1000 (EST)
Received: from mo-p05-ob.rzone.de (mo-p05-ob.rzone.de [81.169.146.180])
	by ozlabs.org (Postfix) with ESMTP id 3C196DDD0B
	for <linuxppc-dev@ozlabs.org>; Sat,  6 Jun 2009 13:59:53 +1000 (EST)
From: Stefan Roese <sr@denx.de>
To: linux-mtd@lists.infradead.org
Subject: Re: [PATCH 1/3 v3] mtd: physmap_of: Add multiple regions and
	concatenation support
Date: Sat, 6 Jun 2009 05:59:56 +0200
References: <1239883845-17804-1-git-send-email-sr@denx.de>
	<fa686aa40904160646v75a98e02s446fd89c08cfebae@mail.gmail.com>
	<200904161549.44841.sr@denx.de>
In-Reply-To: <200904161549.44841.sr@denx.de>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="us-ascii"
Message-Id: <200906060559.56839.sr@denx.de>
Cc: linuxppc-dev@ozlabs.org, devicetree-discuss@ozlabs.org,
	David Woodhouse <dwmw2@infradead.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thursday 16 April 2009 15:49:44 Stefan Roese wrote:
> > Okay.  It will be good to get this one into -next for some testing
> > exposure.  Unless he asks me to do otherwise, I'll leave this one to
> > David to pick up.
>
> Understood. Thanks Grant.

David, just checking on the status of this patch. Is it in your queue for the 
next merge window?

Thanks,
Stefan
