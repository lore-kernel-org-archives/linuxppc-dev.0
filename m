Return-Path: <B07421@freescale.com>
Received: from VA3EHSOBE003.bigfish.com (va3ehsobe003.messaging.microsoft.com
	[216.32.180.13]) by ozlabs.org (Postfix) with ESMTP id 1AB0FB6F10
	for <linuxppc-dev@ozlabs.org>; Thu,  5 Aug 2010 02:19:03 +1000 (EST)
Received: from mail32-va3 (localhost.localdomain [127.0.0.1])	by
	mail32-va3-R.bigfish.com (Postfix) with ESMTP id 265377884AB	for
	<linuxppc-dev@ozlabs.org>; Wed,  4 Aug 2010 16:16:41 +0000 (UTC)
Received: from VA3EHSMHS028.bigfish.com (unknown [10.7.14.243])	by
	mail32-va3.bigfish.com (Postfix) with ESMTP id 3A35CCA8055	for
	<linuxppc-dev@ozlabs.org>; Wed,  4 Aug 2010 16:16:33 +0000 (UTC)
Received: from de01smr02.am.mot.com (de01smr02.freescale.net [10.208.0.151])
	by az33egw02.freescale.net (8.14.3/8.14.3) with ESMTP id
	o74GGQEv018319	for
	<linuxppc-dev@ozlabs.org>; Wed, 4 Aug 2010 09:16:26 -0700 (MST)
Received: from az33exm25.fsl.freescale.net (az33exm25.am.freescale.net
	[10.64.32.16])	by de01smr02.am.mot.com (8.13.1/8.13.0) with ESMTP id
	o74GU7f0022741	for <linuxppc-dev@ozlabs.org>;
	Wed, 4 Aug 2010 11:30:07 -0500 (CDT)
Date: Wed, 4 Aug 2010 11:16:23 -0500
From: Scott Wood <scottwood@freescale.com>
To: "Jenkins, Clive" <Clive.Jenkins@xerox.com>
Subject: Re: Booting MPC8377ERBD from NAND flash
Message-ID: <20100804111623.08c6d920@schlenkerla.am.freescale.net>
In-Reply-To: <929D3CED81F34E43887A393170D66FB9030B2DBA@GBRSUN01MS002.eu.xerox.net>
References: <AANLkTinfQz3PuZK6urnYyh03JuuSt5mFrv8ykNQmg9nD@mail.gmail.com>
	<929D3CED81F34E43887A393170D66FB9030B2DBA@GBRSUN01MS002.eu.xerox.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Cc: Ravi Gupta <dceravigupta@gmail.com>, linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, 4 Aug 2010 15:34:59 +0100
"Jenkins, Clive" <Clive.Jenkins@xerox.com> wrote:

> > I am trying to boot MPC8377ERBD freescale board from NAND flash.
> > As per its specifications, it supports NAND boot but it there is
> > no support for NAND boot in the BSP(confirmed with freescale also).
> > Now I decided to modify BSP myself to support NAND boot and I am
> > confused that from where should I start. Please suggest.
> 
> Read this
> http://www.freescale.com/files/32bit/doc/app_note/AN3201.pdf
> and other documentation on the Freescale site

That's a bit outdated on the software side.  Look under the nand_spl
directory in u-boot; you should see several boards to use as examples.

If possible, I suggest working with the latest upstream u-boot rather
than what comes with the BSP.

If you have further questions, ask at u-boot@lists.denx.de.

-Scott
