Return-Path: <paulus@ozlabs.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Message-ID: <17619.55376.662510.379504@cargo.ozlabs.ibm.com>
Date: Sat, 5 Aug 2006 09:29:20 +1000
From: Paul Mackerras <paulus@samba.org>
To: Tom Rini <trini@kernel.crashing.org>
Subject: Re: RFC: Location for Device Tree Sources?
In-Reply-To: <20060804175418.GA28095@smtp.west.cox.net>
References: <3115459755319495cff4.1649760492.miltonm@bga.com>
	<20060803135440.GB3075@smtp.west.cox.net>
	<17618.53692.364647.412406@cargo.ozlabs.ibm.com>
	<20060804175418.GA28095@smtp.west.cox.net>
Cc: linuxppc-dev@ozlabs.org, g.liakhovetski@gmx.de,
	Milton Miller <miltonm@bga.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Tom Rini writes:

> But doesn't the representation include meaning?

No, in the sense that the device-tree representation doesn't define
what meaning or interpretation is to be given to particular node and
property names or to particular property values.

> I'll rephrase what I said to what I think we all agree.  Changing
> existing fields meanings in incompatible ways and not somehow allowing
> that to still work (like by adding a flag so new trees are interpreted
> one way, old trees are fixed-up or whatever) is a problem.

Yes it's a problem.  Not one that we want to solve by changing the dt
version number, though.

Paul.
