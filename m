Return-Path: <smaclennan@pikatech.com>
Received: from yow.seanm.ca (toronto-hs-216-138-233-67.s-ip.magma.ca
	[216.138.233.67]) by ozlabs.org (Postfix) with SMTP id E2E5DDDED6
	for <linuxppc-dev@ozlabs.org>; Thu,  2 Apr 2009 15:39:07 +1100 (EST)
Date: Thu, 2 Apr 2009 00:39:05 -0400
From: Sean MacLennan <smaclennan@pikatech.com>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: Problem with module_init?
Message-ID: <20090402003905.317431e5@lappy.seanm.ca>
In-Reply-To: <1238646362.17330.186.camel@pasglop>
References: <20090331143742.083c6cb0@lappy.seanm.ca>
	<20090331231153.256d1bf4@lappy.seanm.ca>
	<20090401112756.GA14171@yoda.jdub.homelinux.org>
	<1238624683.17330.138.camel@pasglop>
	<20090402000803.087600da@lappy.seanm.ca>
	<1238646362.17330.186.camel@pasglop>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Thu, 02 Apr 2009 15:26:02 +1100
Benjamin Herrenschmidt <benh@kernel.crashing.org> wrote:

> The proper fix is for PAGE_KERNEL_X to have _PAGE_HWEXEC. I'll fix
> that.

That may not be enough. I made that change (adding _PAGE_HWEXEC to
PAGE_KERNEL_X) and it works for some drivers, but I am still crashing in
one driver. Although, that *could* be unrelated bug.

Cheers,
   Sean
