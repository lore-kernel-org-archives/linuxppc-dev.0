Subject: Re: [PATCH][RFC] I2C support for MPC107 and relatives
From: Adrian Cox <adrian@humboldt.co.uk>
To: Stefan Nickl <Stefan.Nickl@kontron.com>
Cc: linuxppc-embedded@lists.linuxppc.org
In-Reply-To: <1087210866.18442.5.camel@lucy.pep-kaufbeuren.de>
References: <1087207803.7360.83.camel@newt> <1087208600.7360.102.camel@newt>
	 <1087210866.18442.5.camel@lucy.pep-kaufbeuren.de>
Content-Type: text/plain
Message-Id: <1087213025.7360.181.camel@newt>
Mime-Version: 1.0
Date: Mon, 14 Jun 2004 12:37:06 +0100
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


On Mon, 2004-06-14 at 12:01, Stefan Nickl wrote:
> FYI: The Motorola folks recently pushed a I2C driver called i2c-mpc.c
> into the 2.4 tree, it seems to be fully OCP'ed, save it seems the
> platform hooks are only present for 8540 yet.

Do you know which 2.4 tree? It's not in linuxppc_2_4_devel or in the
main 2.4 kernel. If their driver works with my OCP patch, it would save
a whole lot of effort.

- Adrian Cox
Humboldt Solutions Ltd.


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
