Return-Path: <paulus@ozlabs.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Message-ID: <17982.41898.515331.184888@cargo.ozlabs.ibm.com>
Date: Mon, 7 May 2007 13:57:30 +1000
From: Paul Mackerras <paulus@samba.org>
To: Stuart Yoder <b08248@freescale.com>
Subject: Re: [PATCH] powerpc: Support new property called interrupt-parents
In-Reply-To: <200703201917.l2KJHO51015104@ld0164-tx32.am.freescale.net>
References: <200703201917.l2KJHO51015104@ld0164-tx32.am.freescale.net>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Stuart Yoder writes:

> Support new property called interrupt-parents.  This enables the
> description of devices that have multiple interrupts that are routed to
> different interrupt controllers.

I think we can get the same effect by using an interrupt-map property
in the node, with the node's interrupt-parent pointing to itself.
That way we can just use the existing interrupt-map parsing code.

Paul.
