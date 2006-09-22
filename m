Return-Path: <mgreer@mvista.com>
Received: from gateway-1237.mvista.com (gateway-1237.mvista.com
	[63.81.120.158]) by ozlabs.org (Postfix) with ESMTP id 4C10E67BD3
	for <linuxppc-dev@ozlabs.org>; Fri, 22 Sep 2006 11:23:23 +1000 (EST)
Date: Thu, 21 Sep 2006 18:24:08 -0700
From: "Mark A. Greer" <mgreer@mvista.com>
To: Segher Boessenkool <segher@kernel.crashing.org>
Subject: Re: [PATCH] Start arch/powerpc/boot code reorganization
Message-ID: <20060922012408.GA13820@mag.az.mvista.com>
References: <17680.30367.157642.674242@cargo.ozlabs.ibm.com>
	<20060920012042.GA28489@mag.az.mvista.com>
	<1158721828.3043.13.camel@vader.jdub.homelinux.org>
	<A6FD3E5E-94EF-4E12-A0FB-8700F0DF8151@kernel.crashing.org>
	<1158787957.6002.307.camel@localhost.localdomain>
	<20060920215738.GC24809@mag.az.mvista.com>
	<C2AFCB31-CFC2-4B0E-ADAE-380A612D1053@kernel.crashing.org>
	<20060921133707.GA29137@gate.crashing.org>
	<1CA5168F-9ECA-4AA2-92AE-F86579245855@kernel.crashing.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1CA5168F-9ECA-4AA2-92AE-F86579245855@kernel.crashing.org>
Cc: Paul Mackerras <paulus@samba.org>, Matt Porter <mporter@embeddedalley.com>,
	linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Thu, Sep 21, 2006 at 05:31:18PM +0200, Segher Boessenkool wrote:
> >Regardless of the name of the
> >new property, it should be defined to allow a different number of
> >address cells to represent an address in virtual address space.
> 
> How about you check whether the "64-bit" property exists in the CPU
> nodes?

That seemed like the right thing until I realized, its still specifying
the physical size, not the virtual size.

I don't think we can avoid making a new xxx-cells property for the virt
addr size.  Ben suggested adding #virt-address-cells to the root node.

I like the name but prefer putting it directly under "/cpus" because
the virt addr size is really determined by the cpu.  It doesn't matter
that much to me, though.

Comments?

Mark
