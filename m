Return-Path: <benh@kernel.crashing.org>
Subject: Re: spidernet: add improved phy support in sungem_phy.c
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Jens Osterkamp <jens@de.ibm.com>
In-Reply-To: <200701261407.48237.jens@de.ibm.com>
References: <200701261407.48237.jens@de.ibm.com>
Content-Type: text/plain
Date: Sat, 27 Jan 2007 07:20:47 +1100
Message-Id: <1169842847.24996.106.camel@localhost.localdomain>
Mime-Version: 1.0
Cc: netdev@vger.kernel.org, James K Lewis <jim@jklewis.com>,
	linuxppc-dev@ozlabs.org, jgarzik@pobox.com, cbe-oss-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Fri, 2007-01-26 at 14:07 +0100, Jens Osterkamp wrote:
> This patch adds improved version of enable_fiber for both the 5421 and
> the 5461 phy. It is now possible to specify with these wether you want
> autonegotiation or not. This is needed for bladecenter switches where
> some expect autonegotiation and some dont seem to like this at all.
> Depending on this flag it sets phy->autoneg accordingly for the fiber mode.
> 
> More importantly it implements proper read_link and poll_link functions
> for both phys which can handle both copper and fiber mode by determining
> the medium first and then branching to the required functions. For fiber
> they all work fine, for copper they are not tested but return the result
> of the genmii_* function anyway which is supposed to work.
> 
> A "medium" variable in the phy struct is introduced to save the medium
> with which the phy is currently used.
> 
> The patch moves the genmii_* functions around to avoid foreward declarations.
> 
> Signed-off-by: Jens Osterkamp <jens@de.ibm.com>
> Signed-off-by: Arnd Bergmann <arnd.bergmann@de.ibm.com>

Patch is whitespace damaged...

Ben.
