Return-Path: <tkil@scrye.com>
Received: from mail.scrye.com (unknown
 [IPv6:2001:470:b8bc:cafe:5054:ff:fedc:793f])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "mail.scrye.com", Issuer "mail.scrye.com" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 01C3EB7051
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 31 May 2012 06:14:17 +1000 (EST)
To: Scott Wood <scottwood@freescale.com>
Subject: Re: ppc/sata-fsl: orphan config value: CONFIG_MPC8315_DS
From: Anthony Foiani <tkil@scrye.com>
References: <ghave7n25.fsf@dworkin.scrye.com>
 <94F013E7935FF44C83EBE7784D62AD3F0930B855@039-SN2MPN1-022.039d.mgd.msft.net>
 <g7gvzbfhb.fsf@dworkin.scrye.com> <4FC50F22.2040404@freescale.com>
 <gvcjetze3.fsf@dworkin.scrye.com> <4FC5546A.4090506@freescale.com>
Date: Wed, 30 May 2012 14:14:14 -0600
In-Reply-To: <4FC5546A.4090506@freescale.com> (Scott Wood's message of "Tue,
 29 May 2012 17:57:46 -0500")
Message-ID: <gd35lbf55.fsf@dworkin.scrye.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "Robert P.J.Day" <rpjday@crashcourse.ca>,
 "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
 Li Yang-R58472 <r58472@freescale.com>, Jeff Garzik <jeff@garzik.org>,
 Adrian Bunk <bunk@stusta.de>
Reply-To: Anthony Foiani <tkil@scrye.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Scott Wood <scottwood@freescale.com> writes:

> Board information is available from the device tree, and from
> platform code that was selected based on the device tree.

You're right, of course; I was focusing on discovery/probing, and
completely forgot about "provided information".

However, as I just mentioned in my reply to Yang, I'm pretty happy
with the kconfig solution (Adrian's patch, basically).

If we find that this is a more widespread problem, we can revisit this
discussion; but if only a handful of us have encountered this in a
5-year-old design, then I don't think it's worth the extra effort of
making it dynamic.

Maybe someone who knows devtree really well could crank that out in a
few minutes... but I'm not that person.  :)

Regardless, thanks very much for helping out on this.

I do advocate that Adrian's patch get put into place, so that we don't
have undocumented / unconnected kconfig symbols in the tree.  If we
ever do find out more details about the workaround, we can at least
add some comments at the code site.

Thanks again!

Best regards,
Anthony Foiani
