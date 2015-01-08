Return-Path: <segher@gate.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id DED7C1A0EC7
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  8 Jan 2015 11:49:37 +1100 (AEDT)
Date: Wed, 7 Jan 2015 18:49:08 -0600
From: Segher Boessenkool <segher@kernel.crashing.org>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [RFC] PPC: MPIC: necessary readback after EOI?
Message-ID: <20150108004908.GA11770@gate.crashing.org>
References: <54AA9C4D.3000001@freescale.com>
 <1420641610.5830.29.camel@kernel.crashing.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1420641610.5830.29.camel@kernel.crashing.org>
Cc: linuxppc-dev@lists.ozlabs.org, Purcareata Bogdan <b43198@freescale.com>,
 linux-kernel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, Jan 07, 2015 at 03:40:10PM +0100, Benjamin Herrenschmidt wrote:
> One way to work around the performance loss for you would be to add some
> DT property to indicate to the guest that the read isn't necessary.

Or KVM could use a virtual interrupt controller better suited to its
needs.


Segher
