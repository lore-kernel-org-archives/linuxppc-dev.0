Return-Path: <benh@kernel.crashing.org>
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Paul Mackerras <paulus@samba.org>
In-Reply-To: <17145.12993.672427.466466@cargo.ozlabs.ibm.com>
References: <17136.13558.773102.465379@cargo.ozlabs.ibm.com>
	<42F79D89.3040709@austin.ibm.com>
	<bb9b1e9e1ebdc3ac5b23b3cab327bfd5@kernel.crashing.org>
	<17145.12993.672427.466466@cargo.ozlabs.ibm.com>
Content-Type: text/plain
Date: Wed, 10 Aug 2005 12:51:25 +0200
Message-Id: <1123671086.30257.231.camel@gaston>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org, linuxppc64-dev@ozlabs.org
Subject: Re: Merging ppc32 and ppc64
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


> Having the flattened device tree doesn't mean that we will be using
> the device tree less, it means we will be using it _more_.

The reason Segher is freaking out is because he wants to keep OF alive
in the future while the kernel is running.... (at least with SLOF)

I think that would require a different entry point with no flattened
tree, and changing of all the OF accessors to call OF instead of walking
an in-kernel tree. That is far from our current target though.

Ben.
