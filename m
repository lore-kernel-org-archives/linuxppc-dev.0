Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id C74FDDDF23
	for <linuxppc-embedded@ozlabs.org>;
	Tue, 23 Jan 2007 08:00:42 +1100 (EST)
Subject: Re: MPC83xx:  ns16550.c - 'SERIAL_PORT_DFNS' undeclared?
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Vitaly Bordug <vbordug@ru.mvista.com>
In-Reply-To: <20070119233454.6c096bb3@localhost.localdomain>
References: <000801c73c00$01d6cf30$6405a8c0@absolut>
	<1169236694.3029.49.camel@saruman.qstreams.net>
	<001001c73c06$5fbf2060$6405a8c0@absolut>
	<20070119233454.6c096bb3@localhost.localdomain>
Content-Type: text/plain
Date: Tue, 23 Jan 2007 08:00:35 +1100
Message-Id: <1169499635.1582.10.camel@localhost.localdomain>
Mime-Version: 1.0
Cc: Russell McGuire <rmcguire@uwbt.com>, linuxppc-embedded@ozlabs.org
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

On Fri, 2007-01-19 at 23:34 +0300, Vitaly Bordug wrote:
> On Fri, 19 Jan 2007 12:14:04 -0800
> Russell McGuire wrote:
> 
> > Ben,
> > 
> > That could be the problem
> > 
> > I am building using ARCH=ppc
> > 
> > What is the difference between the two?
> Newer targets appear within arch/powerpc... Concerning your question, 
> you seem to add new board hence you'll have to do those SERIAL_PORT_DFNS
> in board-specific header file - grep for them inside arch/ppc for reference (if
> that code is still there of course).

Note that SERIAL_PORT_DFNS are pretty much deprecated too :-) Nobody
cared fixing arch/ppc but for arch/powerpc, you should use one of the
new mecanisms, if possible using the device-tree / platform devices.

Ben.
