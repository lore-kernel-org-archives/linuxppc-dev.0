Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 94232DDE0F
	for <linuxppc-dev@ozlabs.org>; Sat, 10 Nov 2007 08:07:56 +1100 (EST)
Subject: Re: Using PVR value after boot?
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Mike Nuss <nmx@fromtheshadows.net>
In-Reply-To: <a340dd0e0711091239mdf1b772l1d5a8208f7def4f5@mail.gmail.com>
References: <a340dd0e0711091239mdf1b772l1d5a8208f7def4f5@mail.gmail.com>
Content-Type: text/plain
Date: Sat, 10 Nov 2007 08:07:24 +1100
Message-Id: <1194642444.21340.16.camel@pasglop>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org
Reply-To: benh@kernel.crashing.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On Fri, 2007-11-09 at 15:39 -0500, Mike Nuss wrote:
> I'm writing a module for the Security/KASUMI function on the
> PPC440EPx-S and PPC440GRx-S. This relies on checking the PVR value at
> runtime, which is done early on in the boot process.  What would be
> the correct way to check which CPU is present during module
> initialization?

Checking the PVR can be done at any time, though a better option would
be to put something in device-tree of course :-)

Ben.
