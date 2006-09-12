Return-Path: <paulus@ozlabs.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Message-ID: <17671.12953.147098.637600@cargo.ozlabs.ibm.com>
Date: Wed, 13 Sep 2006 08:20:09 +1000
From: Paul Mackerras <paulus@samba.org>
To: Arnd Bergmann <arnd.bergmann@de.ibm.com>
Subject: Re: [PATCH] powerpc: allow PHBs anywhere in the device tree
In-Reply-To: <200609121952.04779.arnd.bergmann@de.ibm.com>
References: <200609121952.04779.arnd.bergmann@de.ibm.com>
Cc: linuxppc-dev@ozlabs.org, cbe-oss-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Arnd Bergmann writes:

> The rtas_pci code currently restricts pci host bridges to
> locations directly under the device tree root. In order to
> correctly model a north bridge that has multiple PCI buses,
> that restriction needs to be relaxed.

Ummm, how do you think we've managed on pSeries all this time?

I could understand this if you said you needed to represent multiple
north bridges, though that would be a rather peculiar system
topology.  Having multiple PCI domains hanging off a single north
bridge can be represented perfectly well with the host bridges being
children of the root, because the root node represents the address
space directly accessible to the processor(s), and it is the north
bridge that implements that address space.

What specifically do you want this for?

Paul.
