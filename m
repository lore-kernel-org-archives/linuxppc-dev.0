Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 91D132BDA2
	for <linuxppc-dev@ozlabs.org>; Sat, 25 Sep 2004 13:02:43 +1000 (EST)
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Tom Rini <trini@kernel.crashing.org>
In-Reply-To: <1096081145.475.12.camel@gaston>
References: <20040923164655.0472a8b9.sfr@ozlabs.org>
	<20040923233035.GH27238@smtp.west.cox.net>
	<36b714c80409231731257ca5d0@mail.gmail.com>
	<29D00F8B-0DC8-11D9-A0FB-000A95A0560C@penguinppc.org>
	<DA7E9084-0DED-11D9-A74B-003065F9B7DC@embeddededge.com>
	<20040924164146.GG2107@smtp.west.cox.net>
	<1096081145.475.12.camel@gaston>
Content-Type: text/plain
Message-Id: <1096081315.576.15.camel@gaston>
Mime-Version: 1.0
Date: Sat, 25 Sep 2004 13:01:56 +1000
Cc: linuxppc-dev@ozlabs.org
Subject: Re: New mailing list specifically for embedded PowerPC development
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Sat, 2004-09-25 at 12:59, Benjamin Herrenschmidt wrote:
> I specifically asked for the split.
> 

Oh, and another reason, which, though, is also a signal/noise
ratio matter. I expect most patches addressing ppc32 to be CCed
to linuxppc-dev. This is important for distro people to keep track
of bug fixes that went in after the kernel version they decided to
freeze on.

That will simply not happen if the embedded traffic is mixed in

Ben.
