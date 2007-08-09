Return-Path: <segher@kernel.crashing.org>
In-Reply-To: <20070809030752.GB8261@localhost.localdomain>
References: <20070808170728.GA21118@localhost.localdomain>
	<20070808170921.GA21487@localhost.localdomain>
	<20070809030752.GB8261@localhost.localdomain>
Mime-Version: 1.0 (Apple Message framework v623)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <af4642f6ed6a4bc167161ac73ad75350@kernel.crashing.org>
From: Segher Boessenkool <segher@kernel.crashing.org>
Subject: Re: [PATCH v3 1/2] [POWERPC] MPC832x_RDB: update dts to use spi,
	register mmc_spi stub
Date: Thu, 9 Aug 2007 22:15:44 +0200
To: David Gibson <david@gibson.dropbear.id.au>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

> Hrm... Freescale is using these 'fsl,device-id' properties, I'm
> guessing they're basically the same thing as the 'cell-index' used in
> the EMAC binding.
>
> We should co-ordinate better on this, if it's to become a
> convention...

That means we shouldn't coordinate on this, right?


Segher
