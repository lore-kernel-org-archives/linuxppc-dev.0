Return-Path: <vbordug@ru.mvista.com>
Received: from buildserver.ru.mvista.com (unknown [85.21.88.6])
	by ozlabs.org (Postfix) with ESMTP id 4570167C00
	for <linuxppc-dev@ozlabs.org>; Wed, 15 Nov 2006 01:00:44 +1100 (EST)
Date: Tue, 14 Nov 2006 15:48:41 +0300
From: Vitaly Bordug <vbordug@ru.mvista.com>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [PATCH 3/5] [POWERPC] 8xx: platform-related changes to the
	fsl_soc.c
Message-ID: <20061114154841.3ce0125d@vitb.ru.mvista.com>
In-Reply-To: <1163470874.5940.48.camel@localhost.localdomain>
References: <20061114012504.17455.13833.stgit@localhost.localdomain>
	<20061114012819.17455.53319.stgit@localhost.localdomain>
	<1163470874.5940.48.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: linuxppc-dev <linuxppc-dev@ozlabs.org>, Paul Mackerras <paulus@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Tue, 14 Nov 2006 13:21:14 +1100
Benjamin Herrenschmidt <benh@kernel.crashing.org> wrote:

> On Tue, 2006-11-14 at 04:28 +0300, Vitaly Bordug wrote:
> > Added 8xx SoC peripherials: fec for Ethernet and smc for UARTs.
> > Ordinary routines to extract values from the device tree and insert respective
> > platform devices
> 
> Note that imho, that's at best a temporary thing. It would be much
> better to have these drivers register as of_platform_driver's and have
> the platform code publish of_platform_device's for all SoC nodes.
> 
The platform device way will persist until we haven't care about arch/ppc stuff anymore. 
As for now, I'm trying to keep both powerpc and ppc approaches sane.

Hence it is temporary, but it is the way of merge. of_platform_device rework is not a big deal - we'll do
it later.


-- 
Sincerely, 
Vitaly
