Return-Path: <matthias.fuchs@esd-electronics.com>
Received: from moutng.kundenserver.de (moutng.kundenserver.de
	[212.227.126.174]) by ozlabs.org (Postfix) with ESMTP id 6E36EDDF1A
	for <linuxppc-dev@ozlabs.org>; Wed,  9 Jan 2008 22:18:08 +1100 (EST)
From: Matthias Fuchs <matthias.fuchs@esd-electronics.com>
To: linuxppc-dev@ozlabs.org
Subject: Re: [PATCH] enable built-in networking for Sequoia defconfig
Date: Wed, 9 Jan 2008 12:16:25 +0100
References: <1199489214.9673.18.camel@basalt>
	<20080108100937.0cfca4cf@zod.rchland.ibm.com>
In-Reply-To: <20080108100937.0cfca4cf@zod.rchland.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200801091216.25581.matthias.fuchs@esd-electronics.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Josh, 

Where did you apply this patch to? Couldn't find it in your for-2.6.25 branch.

BTW, is it normal to edit the defconfig file by hand?
I cannot get CONFIG_IBM_NEW_EMAC enabled through Kconfig. Am I missing something:
	
	a) Patch to enable IBM_NEW_EMAC via Kconfig is welcome
	b) Matthias only knows only half the truth.

Matthias


On Tuesday 08 January 2008 17:09, Josh Boyer wrote:
> On Fri, 04 Jan 2008 17:26:54 -0600
> Hollis Blanchard <hollisb@us.ibm.com> wrote:
> 
> > Enable EMAC driver for Sequoia (and while we're in there, disable
> > Macintosh drivers for Sequoia and Bamboo).
> > 
> > Signed-off-by: Hollis Blanchard <hollisb@us.ibm.com>
> 
> applied, thanks.
> 
> josh
> _______________________________________________
> Linuxppc-dev mailing list
> Linuxppc-dev@ozlabs.org
> https://ozlabs.org/mailman/listinfo/linuxppc-dev
> 
> 
