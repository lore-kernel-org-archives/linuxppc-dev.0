Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id D46E3DDE1F
	for <linuxppc-dev@ozlabs.org>; Mon, 29 Sep 2008 18:52:11 +1000 (EST)
Subject: Re: Device Tree
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: =?ISO-8859-1?Q?S=E9bastien_Chr=E9tien?= <chretien@enseirb.fr>
In-Reply-To: <48E07490.9020805@enseirb.fr>
References: <48E07490.9020805@enseirb.fr>
Content-Type: text/plain; charset=utf-8
Date: Mon, 29 Sep 2008 18:51:52 +1000
Message-Id: <1222678312.7807.95.camel@pasglop>
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

On Mon, 2008-09-29 at 08:24 +0200, Sébastien Chrétien wrote:
> Hello,
> I have a question about Device Tree.
> Is Device Tree found only only on Linux Powerpc ?

Sparc also uses open firmware and shares some of the device-tree
handling code with powerpc in linux. Other operating systems on those
platforms also use it (AIX, Solaris, MacOS, ...)

I think the proposed new Xilinx microblaze architecture also uses it,
and at least on x86, the OLPC has an Open Firmware implementation though
it doesn't use the device-tree the way we do currently on powerpc and
sparc and has its own interface to the firmware.

Ben.
