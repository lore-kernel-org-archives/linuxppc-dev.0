Subject: Re: Broken arch/ppc/8260_io/uart.c
From: David Woodhouse <dwmw2@infradead.org>
To: Rune Torgersen <runet@innovsys.com>
Cc: Tom Rini <trini@kernel.crashing.org>,
	linuxppc-embedded@lists.linuxppc.org
In-Reply-To: <DCEAAC0833DD314AB0B58112AD99B93B06DB07@ismail.innsys.innovsys.com>
References: 
	 <DCEAAC0833DD314AB0B58112AD99B93B06DB07@ismail.innsys.innovsys.com>
Content-Type: text/plain
Date: Sun, 20 Jun 2004 07:10:35 +0100
Message-Id: <1087711835.4230.19.camel@localhost.localdomain>
Mime-Version: 1.0
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


On Thu, 2004-06-17 at 14:24 -0500, Rune Torgersen wrote:
> The following patch broke compilation of uart.c for cases when SMC2 is
> not used
> (used to be doen by #define USE_SMC2 0, now is done by #undef USE_SMC2)

Please test the new driver instead.

--
dwmw2


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
