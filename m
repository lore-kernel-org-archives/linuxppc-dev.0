Return-Path: <ian.molton@codethink.co.uk>
Message-ID: <502D201E.9030304@codethink.co.uk>
Date: Thu, 16 Aug 2012 17:30:22 +0100
From: Ian Molton <ian.molton@codethink.co.uk>
MIME-Version: 1.0
To: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH v3 0/7] mv643xx.c: Add basic device tree support.
References: <1344350092-24050-1-git-send-email-ian.molton@codethink.co.uk>
 <201208091143.32972.arnd@arndb.de> <5023D577.8090001@codethink.co.uk>
 <201208101049.57586.arnd@arndb.de> <5028D040.60604@codethink.co.uk>
In-Reply-To: <5028D040.60604@codethink.co.uk>
Content-Type: text/plain; charset=ISO-8859-1
Cc: thomas.petazzoni@free-electrons.com, andrew@lunn.ch, netdev@vger.kernel.org,
 devicetree-discuss@lists.ozlabs.org, ben.dooks@codethink.co.uk,
 linuxppc-dev@lists.ozlabs.org, David Miller <davem@davemloft.net>,
 linux-arm-kernel@lists.infradead.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Ping :)

Can we get some consensus on the right approach here? I'm loathe to code
this if its going to be rejected.

I'd prefer the driver to be properly split so we dont have the MDIO
driver mapping the ethernet drivers address spaces, but if thats not
going to be merged, I'm not feeling like doing the work for nothing.

If the driver is to use the overlapping-address mapped-by-the-mdio
scheme, then so be it, but I could do with knowing.

Another point against the latter scheme is that the MDIO driver could
sensibly be used (the block is identical) on the ArmadaXP, which has 4
ethernet blocks rather than two, yet grouped in two pairs with a
discontiguous address range.

I'd like to get this moved along as soon as possible though.

-Ian
