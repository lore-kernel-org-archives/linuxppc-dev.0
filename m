Return-Path: <mgreer@mvista.com>
Received: from gateway-1237.mvista.com (gateway-1237.mvista.com
	[63.81.120.158]) by ozlabs.org (Postfix) with ESMTP id 1062F67B69
	for <linuxppc-dev@ozlabs.org>; Thu, 21 Sep 2006 07:56:52 +1000 (EST)
Date: Wed, 20 Sep 2006 14:57:38 -0700
From: "Mark A. Greer" <mgreer@mvista.com>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [PATCH] Start arch/powerpc/boot code reorganization
Message-ID: <20060920215738.GC24809@mag.az.mvista.com>
References: <17680.30367.157642.674242@cargo.ozlabs.ibm.com>
	<20060920012042.GA28489@mag.az.mvista.com>
	<1158721828.3043.13.camel@vader.jdub.homelinux.org>
	<A6FD3E5E-94EF-4E12-A0FB-8700F0DF8151@kernel.crashing.org>
	<1158787957.6002.307.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1158787957.6002.307.camel@localhost.localdomain>
Cc: linuxppc-dev@ozlabs.org, Paul Mackerras <paulus@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Thu, Sep 21, 2006 at 07:32:37AM +1000, Benjamin Herrenschmidt wrote:
> 
> > So please comment the nastiness with a big "HACK HACK HACK" comment and
> > make sure it only ever gets used on systems where nothing better is
> > available, and all should be fine.
> 
> An option is to call it something like fw,address to avoid confusion and
> make it somewhat clearer that it's really a firmware address useable
> within the context of the firmware...

Okay.  We did talk about that but then we realized that "address"
was for vaddrs.  We thought of other names like "bootwrapper-vaddr"
etc. but "fw,address" or "fw,vaddr" are probably better--they show that
the vaddr was setup by the fw.

Comments?

Mark
