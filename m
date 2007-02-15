Return-Path: <paulus@ozlabs.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Message-ID: <17875.49565.444870.924729@cargo.ozlabs.ibm.com>
Date: Thu, 15 Feb 2007 13:12:45 +1100
From: Paul Mackerras <paulus@samba.org>
To: Segher Boessenkool <segher@kernel.crashing.org>
Subject: Re: [PATCH 15/16] Add device tree for Ebony
In-Reply-To: <122a66d49480520cf87cd748bbfc50bb@kernel.crashing.org>
References: <20070213060904.GA6214@localhost.localdomain>
	<20070213061026.5837FDDDE9@ozlabs.org>
	<9696D7A991D0824DBA8DFAC74A9C5FA302A1B705@az33exm25.fsl.freescale.net>
	<1171470754.4003.101.camel@zod.rchland.ibm.com>
	<6206de08b7f12175bebe669291c66334@kernel.crashing.org>
	<9696D7A991D0824DBA8DFAC74A9C5FA302A1B86F@az33exm25.fsl.freescale.net>
	<9df9bf3adf511f4c1a7945e022fdd447@kernel.crashing.org>
	<9696D7A991D0824DBA8DFAC74A9C5FA302A1B8EF@az33exm25.fsl.freescale.net>
	<1171489360.20192.184.camel@localhost.localdomain>
	<122a66d49480520cf87cd748bbfc50bb@kernel.crashing.org>
Cc: David Gibson <david@gibson.dropbear.id.au>,
	Yoder Stuart-B08248 <stuart.yoder@freescale.com>, linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Segher Boessenkool writes:

> Exactly.  The "separate device tree" imitates a real OF,
> so you will lose much of its value if you start to deviate
> from how real OF works.

I disagree.  It was never (and isn't now) the intention to put all of
the OF requirements on the device tree supplied on OF-less systems.

In other words, "we should do X because the bindings require it" isn't
of itself an argument for making X a requirement on the device tree.
"We should do X because there are good technical reasons for doing it
that way" is.  "We should do X because if we don't then device trees
from real OF systems won't be compatible" is also a reasonable
argument.

The device tree is required because it is a flexible way to give
useful information to the kernel.  Thus the focus is quite properly on
what is useful (or at least potentially useful) to the Linux kernel,
not on what some binding document says.

Paul.
