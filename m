Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 7EFA0DDEDF
	for <linuxppc-dev@ozlabs.org>; Fri, 30 May 2008 15:45:54 +1000 (EST)
Subject: Re: [PATCH] [POWERPC] Fix rpadlpar pci hotplug driver sysfs usage
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Jesse Barnes <jbarnes@virtuousgeek.org>
In-Reply-To: <200805292102.17387.jbarnes@virtuousgeek.org>
References: <20080530034134.E2D81DDEE1@ozlabs.org>
	<200805292102.17387.jbarnes@virtuousgeek.org>
Content-Type: text/plain
Date: Fri, 30 May 2008 15:45:47 +1000
Message-Id: <1212126347.15633.62.camel@pasglop>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org, Paul Mackerras <paulus@samba.org>
Reply-To: benh@kernel.crashing.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Thu, 2008-05-29 at 21:02 -0700, Jesse Barnes wrote:
> On Thursday, May 29, 2008 8:39 pm Benjamin Herrenschmidt wrote:
> > When Greg "fixed" the sysfs usage of that driver a while back, he seem
> > to have introduced a bug where the quotes are added around the name of
> > our specific sysfs files, thus breaking the user space tool.
> >
> > This fixes it. Tested DLPAR operations on a POWER6 machine successfully.
> 
> Do you think this is important enough for 2.6.26?

Yes and .25 too in fact. I'll send it to -stable once it's upstream.

Cheers,
Ben.
