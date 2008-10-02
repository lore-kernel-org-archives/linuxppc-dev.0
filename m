Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id DE56EDDDEF
	for <linuxppc-dev@ozlabs.org>; Thu,  2 Oct 2008 22:52:05 +1000 (EST)
Subject: Re: [PATCH v2] ibm_newemac: Add support for GPCS, SGMII
	andM88E1112 PHY
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Josh Boyer <jwboyer@linux.vnet.ibm.com>
In-Reply-To: <20081002115507.GB2227@yoda.jdub.homelinux.org>
References: <1222929477-10329-1-git-send-email-vgallardo@amcc.com>
	<1222929920.12264.96.camel@pasglop>
	<0CA0A16855646F4FA96D25A158E299D602C81377@SDCEXCHANGE01.ad.amcc.com>
	<1222932759.12264.104.camel@pasglop>
	<20081002063320.7b2331b4@zod.rchland.ibm.com>
	<1222943668.12264.106.camel@pasglop>
	<20081002065648.285cce25@zod.rchland.ibm.com>
	<20081002115507.GB2227@yoda.jdub.homelinux.org>
Content-Type: text/plain
Date: Thu, 02 Oct 2008 22:37:48 +1000
Message-Id: <1222951068.12264.109.camel@pasglop>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org, Victor Gallardo <vgallardo@amcc.com>,
	Jeff Garzik <jgarzik@pobox.com>, netdev@vger.kernel.org
Reply-To: benh@kernel.crashing.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Thu, 2008-10-02 at 07:55 -0400, Josh Boyer wrote:
> >Yep.  You could pull now if you'd like.  I have a few more patches I'd
> >like to get in before the merge window, but if it helps things I can do
> >those in a separate pull request.
> 
> Actually, it seems not.  I pulled in an older version of the patch.  I'll
> grab the new version today.

Victor, while at it, can you do a fixup patch on top of it that guards
the new feature with a Kconfig option like some of the other ones so
that the code for it doesn't get compiled in when building, for example.
for 405GP only ?

The trick is to have the option not be part of the possible mask, so
that the compiler optimises out the feature tests as if (0) (gcc
nowadays is supposedly smart enough to rip off the code when it finds
such constructs).

Thanks !

Cheers,
Ben.
