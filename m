To: Geoff Wyche <GWyche@DATUM.com>
Cc: "'linuxppc-embedded@lists.linuxppc.org'" <linuxppc-embedded@lists.linuxppc.org>
Subject: Re: MPC8xx + serial console on SCC 
From: Wolfgang Denk <wd@denx.de>
Mime-version: 1.0
Content-type: text/plain; charset=ISO-8859-1
In-reply-to: Your message of "Fri, 19 Oct 2001 08:39:47 PDT."
             <607BF0A2B4F3D411A09500508BC225427E8328@mailctx.datum.com>
Date: Fri, 19 Oct 2001 18:05:52 +0200
Message-Id: <20011019160557.1622E10CCD@denx.denx.de>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Hi Geoff,

in message <607BF0A2B4F3D411A09500508BC225427E8328@mailctx.datum.com> you wrote:
>
> Is anyone here working on an 8xx based board and using an SCC for serial
> console?

Yes, we've tested this configuration once when we were re-working the
UART driver for hardware-handshake support, configurable buffer sizes
etc.

We tested all 6 channels ( 2 x SMC, 4 x SCC) on a IP860 board.

> Comments?

See the version of the UART driver in the kernel source tree  on  our
FTP  server; I've sent patches against 2_4_devel to Tom Rini, waiting
for a decision if these patches will make it into the official source
tree...

Wolfgang Denk

--
Software Engineering:  Embedded and Realtime Systems,  Embedded Linux
Phone: (+49)-8142-4596-87  Fax: (+49)-8142-4596-88  Email: wd@denx.de
All these theories, diverse as they are, have two things  in  common:
they explain the observed facts, and they are completeley and utterly
wrong.                       - Terry Pratchett, _The Light Fantastic_

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
