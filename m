Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 4F33BDDE0D
	for <linuxppc-dev@ozlabs.org>; Wed,  1 Oct 2008 13:46:39 +1000 (EST)
Subject: Re: Device Tree
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Matt Sealey <matt@genesi-usa.com>
In-Reply-To: <48E2B16C.6030501@genesi-usa.com>
References: <48E07490.9020805@enseirb.fr> <48E09108.4020400@ru.mvista.com>
	<48E2444D.1050301@genesi-usa.com>
	<eee4c0020809301530w20d6d1e4sd2e3542366cc595d@mail.gmail.com>
	<48E2B16C.6030501@genesi-usa.com>
Content-Type: text/plain
Date: Wed, 01 Oct 2008 13:24:55 +1000
Message-Id: <1222831495.12264.2.camel@pasglop>
Mime-Version: 1.0
Cc: =?ISO-8859-1?Q?hr=E9tien?= <chretien@enseirb.fr>,
	=?UTF-8?B?U8OpYmFzdGllbiBD?=@ozlabs.org, linuxppc-dev@ozlabs.org
Reply-To: benh@kernel.crashing.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Tue, 2008-09-30 at 18:08 -0500, Matt Sealey wrote:
> It's far more common than people might think at first glance. With x86
> I am sure it would benefit the platform a little more if the OF support
> was in-line with the shared code between PPC and SPARC (and now I guess,
> ARM) but nevertheless it's an Open Firmware platform and something that
> appeared not too long ago.
> 
> OF is still a going concern; if you want a nice flexible firmware, why
> not use it? Most of the implementations are open source (FirmWorks and
> CodeGen trees, and the Sun reference design) too.

And SLOF :-)

Cheers,
Ben.
