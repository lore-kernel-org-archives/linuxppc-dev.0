Date: Mon, 27 Aug 2001 03:39:04 -0700
From: Matt Porter <mporter@mvista.com>
To: Rudolf Ladyzhenskii <rudolf.ladyzhenskii@act-aus.net>
Cc: "PPC-Linux list (E-mail)" <linuxppc-embedded@lists.linuxppc.org>
Subject: Re: Linux and two PCI busses
Message-ID: <20010827033903.A23912@cx258813-a.chnd1.az.home.com>
References: <619D608DD3F0D311882C009027732E1A8361F8@ntserver.act.domain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <619D608DD3F0D311882C009027732E1A8361F8@ntserver.act.domain>; from rudolf.ladyzhenskii@act-aus.net on Mon, Aug 27, 2001 at 11:10:55AM +1000
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


On Mon, Aug 27, 2001 at 11:10:55AM +1000, Rudolf Ladyzhenskii wrote:
>
> Hi, all
>
> We have a design where MPC8260 has two independent PCI busses.  We use
> Tundra PowerSpan device to provide two PCI busses.
> Linux only supports single PCI bus.

Correction, the Linux PCI subsystem only supports one _logical_ bus.

> Anyone tried to modify Linux to have support for multiple PCI busses? I mean
> two independent busses, not a PCI bus and another PCI bus behind a bridge.

It's already supported in arch-specific code, no modification necessary.
In linuxppc_2_4_devel, see the K2 port as an example.

--
Matt Porter
MontaVista Software, Inc.
mporter@mvista.com

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
