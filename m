Return-Path: <benh@kernel.crashing.org>
Subject: Re: Fix Kconfig undefined symbol 'IBM_NEW_EMAC_ZMII'
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Tony Breeds <tony@bakeyournoodle.com>
In-Reply-To: <20070511070006.GF15955@bakeyournoodle.com>
References: <20070511070006.GF15955@bakeyournoodle.com>
Content-Type: text/plain
Date: Fri, 11 May 2007 17:56:42 +1000
Message-Id: <1178870202.32247.15.camel@localhost.localdomain>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org, David Gibson <david@gibson.dropbear.id.au>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Fri, 2007-05-11 at 17:00 +1000, Tony Breeds wrote:
> Fix Kconfig undefined symbol 'IBM_NEW_EMAC_ZMII'
> 
> An allmodconfig on the current powerpc tree yields:
> arch/powerpc/platforms/44x/Kconfig:41:warning: 'select' used by config symbol '440GP' refers to undefined symbol 'IBM_NEW_EMAC_ZMII'
> 
> Remove the select until the driver exists.

Can you comment it out instead ?

Ben.
