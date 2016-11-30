Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3tTCgn4frqzDvpH
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 30 Nov 2016 19:07:17 +1100 (AEDT)
From: Michael Ellerman <mpe@ellerman.id.au>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 linuxppc dev list <linuxppc-dev@lists.ozlabs.org>,
 stewart@linux.vnet.ibm.com <stewart@linux.vnet.ibm.com>
Subject: Re: [PATCH] powerpc/opal-irqchip: Use interrupt names if present
In-Reply-To: <1480463779.11342.79.camel@kernel.crashing.org>
References: <1480463779.11342.79.camel@kernel.crashing.org>
Date: Wed, 30 Nov 2016 19:07:16 +1100
Message-ID: <87d1hdpf0r.fsf@concordia.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Benjamin Herrenschmidt <benh@kernel.crashing.org> writes:

> Recent versions of OPAL will be able to provide names for the various
> OPAL interrupts via a new "opal-interrupt-names" property. So let's
> use them to make /proc/interrupts more informative.

I guess there's no point asking whether there's a generic device tree
spec for this sort of thing, and if so whether we should use it?

cheers
