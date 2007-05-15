Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 99BAEDDEE4
	for <linuxppc-dev@ozlabs.org>; Tue, 15 May 2007 16:04:10 +1000 (EST)
Subject: Re: [RFC/PATCH] powerpc: Rewrite IO allocation & mapping on powerpc64
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Segher Boessenkool <segher@kernel.crashing.org>
In-Reply-To: <66b16b11858147b8790b70416fd3833a@kernel.crashing.org>
References: <20070514075415.7999BDDEC8@ozlabs.org>
	<246be0d2277753c0c0b61d0f4131c092@kernel.crashing.org>
	<17992.64515.797925.855510@cargo.ozlabs.ibm.com>
	<66b16b11858147b8790b70416fd3833a@kernel.crashing.org>
Content-Type: text/plain
Date: Tue, 15 May 2007 16:04:00 +1000
Message-Id: <1179209041.32247.149.camel@localhost.localdomain>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org, Paul Mackerras <paulus@samba.org>,
	Anton Blanchard <anton@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Tue, 2007-05-15 at 06:33 +0200, Segher Boessenkool wrote:
> 
> Ben, can we have a config option to _not_ create a
> mapping for the legacy hardcoded stuff, even if there
> is an "isa" device node?  Some platforms do not need
> it or want it, and it can help find the remaining
> drivers that do this x86 nastiness.

Maybe separately... let's not introduce too much breakage in one
patch :-)

Ben.
