Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 387A4DDF8A
	for <linuxppc-dev@ozlabs.org>; Thu, 16 Oct 2008 19:58:31 +1100 (EST)
Subject: Re: Problems with PCI-E devices not being detected with switch
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Stefan Roese <sr@denx.de>
In-Reply-To: <200810161048.45937.sr@denx.de>
References: <16691A8B34B5D9458EA3A1C37A11555A0137F81E@tanisys-ex2.Tanisys.Local>
	<200810161003.31801.sr@denx.de> <1224145785.7654.4.camel@pasglop>
	<200810161048.45937.sr@denx.de>
Content-Type: text/plain
Date: Thu, 16 Oct 2008 19:58:18 +1100
Message-Id: <1224147498.7654.8.camel@pasglop>
Mime-Version: 1.0
Cc: Ayman El-Khashab <AymanE@tanisys.com>, Victor Gallardo <vgallardo@amcc.com>,
	linuxppc-dev@ozlabs.org
Reply-To: benh@kernel.crashing.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Thu, 2008-10-16 at 10:48 +0200, Stefan Roese wrote:
> Yeah. I could add this "configured" property to the current U-Boot version. 
> Perhaps we should add some version information to it so that Linux could 
> eventually decide to re-configure when the "configured" version is known to 
> be buggy. What do you think?

I'd rather have the platform have a way to override it rather than
having tests for uboot versions in the pci code itself.

Ben.
