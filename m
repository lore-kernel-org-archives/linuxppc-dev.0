Return-Path: <paulus@ozlabs.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Message-ID: <17186.57078.514661.712234@cargo.ozlabs.ibm.com>
Date: Sat, 10 Sep 2005 23:26:14 +1000
From: Paul Mackerras <paulus@samba.org>
To: Tobias Klauser <tklauser@nuerscht.ch>
In-Reply-To: <20050910121633.GC1218@neon.tklauser.home>
References: <20050910121633.GC1218@neon.tklauser.home>
Cc: akpm@osdl.org, kernel-janitors@lists.osdl.org, linuxppc-dev@ozlabs.org,
	trini@kernel.crashing.org
Subject: Re: [PATCH 2/4] arch/ppc: Replace custom macro with isdigit()
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Tobias Klauser writes:

> Replace the custom is_digit() macro with isdigit() from <linux/ctype.h>

NAK.  No point pulling in 256 bytes of _ctype array when all we use it
for is two '0' <= c <= '9' comparisons.

In fact Tom Rini maintains this code, so it's his opinion that counts.

Paul.
