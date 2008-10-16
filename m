Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id EF470DDDEF
	for <linuxppc-dev@ozlabs.org>; Fri, 17 Oct 2008 08:19:08 +1100 (EST)
Subject: RE: Problems with PCI-E devices not being detected with switch
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Ayman El-Khashab <AymanE@tanisys.com>
In-Reply-To: <16691A8B34B5D9458EA3A1C37A11555A0137F822@tanisys-ex2.Tanisys.Local>
References: <16691A8B34B5D9458EA3A1C37A11555A0137F81E@tanisys-ex2.Tanisys.Local>
	<1224134422.8157.549.camel@pasglop>
	<16691A8B34B5D9458EA3A1C37A11555A0137F822@tanisys-ex2.Tanisys.Local>
Content-Type: text/plain
Date: Fri, 17 Oct 2008 08:19:02 +1100
Message-Id: <1224191942.7654.24.camel@pasglop>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org
Reply-To: benh@kernel.crashing.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Thu, 2008-10-16 at 10:01 -0500, Ayman El-Khashab wrote:
> 
> Thanks for your help.  I did try a 5s delay and other than the boot
> taking an extra couple of seconds, there was no change.  The messages
> above "unknown header" still showed up.  Downstream devices were not
> found.
> BTW, this is with both the Denx kernel tree and the official 2.6.27
> kernel.  
> Both have the same results. One added note, just to rule out bad
> electronics,
> I have confirmed that the switch+sata work correctly together if placed
> into a plain x86 pc with 2.6.24.  So the electronics are fine.

I think I know where the problem comes from. The bus numbers aren't
getting properly assigned below the root bus. I'm working on some test
patches, I'll let you know when I have something.

Cheers,
Ben.
