Subject: Re: [PATCH][RFC] I2C support for MPC107 and relatives
From: Stefan Nickl <Stefan.Nickl@kontron.com>
To: Adrian Cox <adrian@humboldt.co.uk>
Cc: linuxppc-embedded@lists.linuxppc.org
In-Reply-To: <1087208600.7360.102.camel@newt>
References: <1087207803.7360.83.camel@newt> <1087208600.7360.102.camel@newt>
Content-Type: text/plain; charset=ISO-8859-15
Message-Id: <1087210866.18442.5.camel@lucy.pep-kaufbeuren.de>
Mime-Version: 1.0
Date: Mon, 14 Jun 2004 13:01:07 +0200
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


On Mon, 2004-06-14 at 12:23, Adrian Cox wrote:
> The attached patch is a 2.6 port of my I2C driver for the MPC107 and
> relatives. It uses my OCP patch to find the address and IRQ information,
> which replaces the direct reading of EPIC registers used in the 2.4
> version.

FYI: The Motorola folks recently pushed a I2C driver called i2c-mpc.c
into the 2.4 tree, it seems to be fully OCP'ed, save it seems the
platform hooks are only present for 8540 yet.

It claims to be:
"non-CPM I2C driver for the Motorola MPC85xx, MPC824x, and MPC107"

It works fine on 8540 (except when the PCB has passed the 74°C-mark
and you reboot it ...)

--
Stefan Nickl
Kontron Modular Computers


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
