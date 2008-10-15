Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id D6469DDF05
	for <linuxppc-dev@ozlabs.org>; Thu, 16 Oct 2008 07:53:39 +1100 (EST)
Subject: Re: [PATCH] powerpc: Add legacy PCI access via sysfs (v3)
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Jesse Barnes <jbarnes@virtuousgeek.org>
In-Reply-To: <200810150516.29683.jbarnes@virtuousgeek.org>
References: <20081014005701.A17D2DDF6A@ozlabs.org>
	<200810150516.29683.jbarnes@virtuousgeek.org>
Content-Type: text/plain
Date: Thu, 16 Oct 2008 07:53:32 +1100
Message-Id: <1224104012.8157.471.camel@pasglop>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org
Reply-To: benh@kernel.crashing.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Wed, 2008-10-15 at 05:16 -0700, Jesse Barnes wrote:
> On Monday, October 13, 2008 5:55 pm Benjamin Herrenschmidt wrote:
> > This patch adds support for legacy_io and legacy_mem files in
> > bus class directories in sysfs for powerpc
> >
> > Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>
> 
> Ok, applied this one.  Should be pushing to Linus soon.

Thanks !

Ben.
