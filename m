Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 8D867DDEE3
	for <linuxppc-dev@ozlabs.org>; Thu, 12 Mar 2009 08:38:17 +1100 (EST)
Subject: Re: [PATCH 1/9] powerpc/kconfig: Kill PPC_MULTIPLATFORM
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Kumar Gala <galak@kernel.crashing.org>
In-Reply-To: <7FB04997-33E8-479C-B5EF-A1ECA8059A99@kernel.crashing.org>
References: <20090311035330.DDF1FDE153@ozlabs.org>
	<7FB04997-33E8-479C-B5EF-A1ECA8059A99@kernel.crashing.org>
Content-Type: text/plain
Date: Thu, 12 Mar 2009 08:38:10 +1100
Message-Id: <1236807490.7086.50.camel@pasglop>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Wed, 2009-03-11 at 07:04 -0500, Kumar Gala wrote:
> On Mar 10, 2009, at 10:53 PM, Benjamin Herrenschmidt wrote:
> 
> >
> > config PPC_NATIVE
> > 	bool
> > -	depends on PPC_MULTIPLATFORM
> > +	depends on 6xx || PPC64
> > 	help
> > 	  Support for running natively on the hardware, i.e. without
> > 	  a hypervisor. This option is not user-selectable but should
> > 	  be selected by all platforms that need it.
> 
> Should this really just be PPC64 && BOOK3S ?  It doesnt look to be  
> used for anything beyond using hash_native_64.S

Maybe... In this case I didn't want to change it from what it was but
you're right, it probably is hash64 only.

Ben
