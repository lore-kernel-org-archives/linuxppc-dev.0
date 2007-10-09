Return-Path: <timur@freescale.com>
Message-ID: <470BA6ED.3020504@freescale.com>
Date: Tue, 09 Oct 2007 11:06:05 -0500
From: Timur Tabi <timur@freescale.com>
MIME-Version: 1.0
To: David Gibson <david@gibson.dropbear.id.au>
Subject: Re: Build failure on treeboot-walnut.cg
References: <fa686aa40709251546p725e66dcsbc0483cadb3ec3fb@mail.gmail.com>
	<470AA224.7050709@freescale.com>
	<20071009030729.GI12499@localhost.localdomain>
In-Reply-To: <20071009030729.GI12499@localhost.localdomain>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: linuxppc-dev@ozlabs.com, Paul Mackerras <paulus@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

David Gibson wrote:

> Policy.  Compiling everything means build bugs - like this one - can
> be found by everybody, not just those building for the specific
> obscure platform.

Is this a new policy?  Modules in the kernel are not built unless you want 
them.  Even in arch/powerpc/platforms, only the specific platform file I'm 
targeting is built.  So I don't really understand why you claim it's normal 
for platform-specific files to be built, regardless of the actual platform.

And frankly, I don't like this "policy".  Build bugs for 4xx should not 
interfere in my 83xx development.  I can't build any kernels now because of 
this bug!

-- 
Timur Tabi
Linux Kernel Developer @ Freescale
