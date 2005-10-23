Return-Path: <olh@suse.de>
Received: from mx1.suse.de (ns.suse.de [195.135.220.2])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx1.suse.de",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id CDFDC68601
	for <linuxppc-dev@ozlabs.org>; Sun, 23 Oct 2005 18:12:46 +1000 (EST)
Date: Sun, 23 Oct 2005 10:12:40 +0200
From: Olaf Hering <olh@suse.de>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Message-ID: <20051023081240.GA20134@suse.de>
References: <20051022213037.GA6097@suse.de> <1130022347.7919.39.camel@gaston>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
In-Reply-To: <1130022347.7919.39.camel@gaston>
Cc: Andrew Morton <akpm@osdl.org>, linuxppc-dev@ozlabs.org
Subject: Re: [PATCH] hide pmac specific drivers if CONFIG_ADB is not set
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

 On Sun, Oct 23, Benjamin Herrenschmidt wrote:

> On Sat, 2005-10-22 at 23:30 +0200, Olaf Hering wrote:
> > This started out as a fix for https://bugzilla.novell.com/show_bug.cgi?id=119606
> > 
> > Hiding a few pmac specific drivers when ADB is disabled can not hurt:
> > 
> > AGP_UNINORTH exist only on systems with ADB_PMU
> 
> No. SMU machines too

arch/ppc64/configs/g5_defconfig has CONFIG_ADB_PMU enabled.
It compiles ok with that option disabled.
Is there a pmu in early G5 models?

-- 
short story of a lazy sysadmin:
 alias appserv=wotan
