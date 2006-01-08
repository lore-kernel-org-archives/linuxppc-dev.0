Return-Path: <benh@kernel.crashing.org>
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Hollis Blanchard <hollis@penguinppc.org>
In-Reply-To: <fe4d9bc576d696dfea0bc1b2a742307d@penguinppc.org>
References: <1136695956.30123.44.camel@localhost.localdomain>
	<fe4d9bc576d696dfea0bc1b2a742307d@penguinppc.org>
Content-Type: text/plain
Date: Sun, 08 Jan 2006 17:22:59 +1100
Message-Id: <1136701380.30123.46.camel@localhost.localdomain>
Mime-Version: 1.0
Cc: linuxppc64-dev <linuxppc64-dev@ozlabs.org>,
	linuxppc-dev list <linuxppc-dev@ozlabs.org>
Subject: Re: [PATCH] powerpc: Fix PowerMac sound i2c
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Sat, 2006-01-07 at 22:55 -0600, Hollis Blanchard wrote:
> On Jan 7, 2006, at 10:52 PM, Benjamin Herrenschmidt wrote:
> 
> > +        data.block[0] = len;
> > +	memcpy(&data.block[1], values, len);
> 
> Seem to be mixing tabs and spaces here (in both *_write_block 
> functions).

You mean the patch got mangled or the code is mixing tab/spaces ? I
think the driver was pretty mixed up in the first place, I'll have to
check.

Ben.
