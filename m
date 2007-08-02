Return-Path: <b07421@freescale.com>
Received: from de01egw01.freescale.net (de01egw01.freescale.net
	[192.88.165.102])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "de01egw01.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 2D18ADDE26
	for <linuxppc-dev@ozlabs.org>; Fri,  3 Aug 2007 01:29:33 +1000 (EST)
Date: Thu, 2 Aug 2007 10:28:46 -0500
From: Scott Wood <scottwood@freescale.com>
To: Liu Dave-r63238 <DaveLiu@freescale.com>
Subject: Re: [U-Boot-Users] MPC83xx - previous patch to set MBAR
Message-ID: <20070802152846.GA4468@ld0162-tx32.am.freescale.net>
References: <20070801192009.656fc2e0.kim.phillips@freescale.com>
	<995B09A8299C2C44B59866F6391D2635AAD0C5@zch01exm21.fsl.freescale.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <995B09A8299C2C44B59866F6391D2635AAD0C5@zch01exm21.fsl.freescale.net>
Cc: linuxppc-dev@ozlabs.org, Phillips Kim-R1AAHA <Kim.Phillips@freescale.com>,
	u-boot-users@lists.sourceforge.net
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Thu, Aug 02, 2007 at 10:14:31AM +0800, Liu Dave-r63238 wrote:
> > MBAR doesn't live up to its name.  It's a general-purpose scratch
> > register - the hardware doesn't do anything with it.  So, wrt 

That doesn't mean there isn't value in setting it, so code can easily
find the IMMR without having to parse the device tree.

-Scott
