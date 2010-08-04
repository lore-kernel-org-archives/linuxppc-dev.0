Return-Path: <Clive.Jenkins@xerox.com>
Received: from wbmler4.mail.xerox.com (wbmler4.mail.xerox.com [13.13.138.219])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "wbmler4.mail.xerox.com",
	Issuer "AAA Certificate Services" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 0DCBEB6F10
	for <linuxppc-dev@ozlabs.org>; Thu,  5 Aug 2010 00:54:04 +1000 (EST)
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Subject: RE: Booting MPC8377ERBD from NAND flash
Date: Wed, 4 Aug 2010 15:34:59 +0100
Message-ID: <929D3CED81F34E43887A393170D66FB9030B2DBA@GBRSUN01MS002.eu.xerox.net>
In-Reply-To: <AANLkTinfQz3PuZK6urnYyh03JuuSt5mFrv8ykNQmg9nD@mail.gmail.com>
References: <AANLkTinfQz3PuZK6urnYyh03JuuSt5mFrv8ykNQmg9nD@mail.gmail.com>
From: "Jenkins, Clive" <Clive.Jenkins@xerox.com>
To: "Ravi Gupta" <dceravigupta@gmail.com>, <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

> I am trying to boot MPC8377ERBD freescale board from NAND flash.
> As per its specifications, it supports NAND boot but it there is
> no support for NAND boot in the BSP(confirmed with freescale also).
> Now I decided to modify BSP myself to support NAND boot and I am
> confused that from where should I start. Please suggest.

Read this
http://www.freescale.com/files/32bit/doc/app_note/AN3201.pdf
and other documentation on the Freescale site
=20
Clive=20
