Subject: Re: [PATCH][RFC] I2C support for MPC107 and relatives
From: Stefan Nickl <Stefan.Nickl@kontron.com>
To: Adrian Cox <adrian@humboldt.co.uk>
Cc: linuxppc-embedded@lists.linuxppc.org
In-Reply-To: <1087213025.7360.181.camel@newt>
References: <1087207803.7360.83.camel@newt> <1087208600.7360.102.camel@newt>
	 <1087210866.18442.5.camel@lucy.pep-kaufbeuren.de>
	 <1087213025.7360.181.camel@newt>
Content-Type: text/plain
Message-Id: <1087218066.18446.11.camel@lucy.pep-kaufbeuren.de>
Mime-Version: 1.0
Date: Mon, 14 Jun 2004 15:01:06 +0200
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


On Mon, 2004-06-14 at 13:37, Adrian Cox wrote:
> On Mon, 2004-06-14 at 12:01, Stefan Nickl wrote:
> > FYI: The Motorola folks recently pushed a I2C driver called i2c-mpc.c
> > into the 2.4 tree, it seems to be fully OCP'ed, save it seems the
> > platform hooks are only present for 8540 yet.
>
> Do you know which 2.4 tree? It's not in linuxppc_2_4_devel or in the
> main 2.4 kernel. If their driver works with my OCP patch, it would save
> a whole lot of effort.

Sorry, I was talking about
bk://ppc.bkbits.net/linuxppc-2.4

--
Stefan Nickl
Project Engineering
Kontron Modular Computers
Sudetenstr. 7
D-87600 Kaufbeuren
Phone ++49/8341/803-294


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
