Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id E42D8DE01E
	for <linuxppc-dev@ozlabs.org>; Tue, 19 May 2009 07:52:53 +1000 (EST)
Subject: Re: fs_enet build breakage
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Scott Wood <scottwood@freescale.com>
In-Reply-To: <20090518172016.GB18620@b07421-ec1.am.freescale.net>
References: <1242630064.18075.48.camel@pasglop>
	<9732983B-B67C-4831-BBAB-65472BE0F279@kernel.crashing.org>
	<20090518172016.GB18620@b07421-ec1.am.freescale.net>
Content-Type: text/plain
Date: Tue, 19 May 2009 07:50:44 +1000
Message-Id: <1242683444.16901.1.camel@pasglop>
Mime-Version: 1.0
Cc: Kumar Gala <galak@gate.crashing.org>,
	linuxppc-dev list <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Mon, 2009-05-18 at 12:20 -0500, Scott Wood wrote:
> > I'm pretty sure the driver changes to address this are in dave's
> net- 
> > next tree.
> 
> Won't this break git bisect?
> 
> Not to mention anyone trying to use your tree now...

Right, though if you have the commit ID in DaveM tree, I can work with
him to sort out that driver, for example by having the same commit in
my tree.

Ben.
