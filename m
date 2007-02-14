Return-Path: <dgibson@ozlabs.org>
Date: Thu, 15 Feb 2007 10:18:37 +1100
From: David Gibson <david@gibson.dropbear.id.au>
To: Segher Boessenkool <segher@kernel.crashing.org>
Subject: Re: [PATCH 15/16] Add device tree for Ebony
Message-ID: <20070214231837.GD16279@localhost.localdomain>
References: <20070213061026.5837FDDDE9@ozlabs.org>
	<e9a2d2be6fe9006c1e2e0b65099a1854@kernel.crashing.org>
	<20070214002210.GE11491@localhost.localdomain>
	<1171417866.20192.126.camel@localhost.localdomain>
	<20070214044641.GB12402@localhost.localdomain>
	<edc24af3b7805333c579d72d22417180@kernel.crashing.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <edc24af3b7805333c579d72d22417180@kernel.crashing.org>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Wed, Feb 14, 2007 at 06:54:06PM +0100, Segher Boessenkool wrote:
> > Oh, btw, I take it you didn't think my method of placing the secondary
> > UICs under the node for UIC0 was insane.
> 
> You have to put it somewhere.  I would put them
> as siblings to the primary UIC since they aren't
> really children but really on an equal footing.

Well, what does "really children" mean.  The UICs exist on no MMIO
bus, they're DCR controlled.  Their primary connection to the system,
therefore, *is* the interrupt lines.

-- 
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson
