Date: Sun, 19 Jan 2003 17:33:33 -0700
From: Tom Rini <trini@kernel.crashing.org>
To: b y <by012345@yahoo.com>
Cc: linuxppc-embedded@lists.linuxppc.org
Subject: Re: openpic and serial interupt mode of mpc107
Message-ID: <20030120003333.GG888@opus.bloom.county>
References: <20030119031516.68349.qmail@web41505.mail.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20030119031516.68349.qmail@web41505.mail.yahoo.com>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


On Sat, Jan 18, 2003 at 07:15:16PM -0800, b y wrote:

> I am using Monta Vista Preview 2.1 kit for a customer
> board that used mpc107 serial interrupt mode only.
> Does anyone know if Monta Vista Preview 2.1 supports
> serial mode in interrupt implementation ? If not,
> where should i get patch if any as I found several old
> messages mentioned patch for mpc107 serial interrupt
> mode before.

Yes, see how the Motorola LoPEC (arch/ppc/platforms/lopec_*.c) is
handled.  And the Sandpoint as well.

--
Tom Rini (TR1265)
http://gate.crashing.org/~trini/

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
