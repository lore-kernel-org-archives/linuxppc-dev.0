Return-Path: <paulus@ozlabs.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Message-ID: <18441.28496.84724.411784@cargo.ozlabs.ibm.com>
Date: Sat, 19 Apr 2008 14:04:32 +1000
From: Paul Mackerras <paulus@samba.org>
To: Jochen Friedrich <jochen@scram.de>
Subject: Re: [PATCH] [POWERPC] i2c: fix build breakage introduced by OF helpers
In-Reply-To: <4808AEC7.8040000@scram.de>
References: <4808AEC7.8040000@scram.de>
Cc: Stephen Rothwell <sfr@canb.auug.org.au>,
	linuxppc-dev list <linuxppc-dev@ozlabs.org>, "Kernel,
	Linux" <linux-kernel@vger.kernel.org>,
	Scott Wood <scottwood@freescale.com>, Linux I2C <i2c@lm-sensors.org>,
	Jean Delvare <khali@linux-fr.org>, David Miller <davem@davemloft.net>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Jochen Friedrich writes:

> Fix build breakage introduced in commit
> "[POWERPC] i2c: OF helpers for the i2c API".
> If i2c-core is compiled as module, the helper needs to be
> compiled as module, as well. Rename i2c.c to of_i2c.c to
> avoid name space conflict.

Actually, since only powerpc has irq_of_parse_and_map, I'm now
inclined to think that drivers/of/i2c.c should live under arch/powerpc
for now, or at the least its option should depend on PPC_OF.

Paul.
