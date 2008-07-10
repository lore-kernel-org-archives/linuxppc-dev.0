Return-Path: <linux@dominikbrodowski.net>
Received: from linta.de (isilmar.linta.de [213.133.102.198])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 5A764DDFEF
	for <linuxppc-dev@ozlabs.org>; Fri, 11 Jul 2008 04:12:37 +1000 (EST)
Date: Thu, 10 Jul 2008 20:05:53 +0200
From: Dominik Brodowski <linux@dominikbrodowski.net>
To: Dave Jones <davej@codemonkey.org.uk>
Subject: Re: powerpc/cell/cpufreq: add spu aware cpufreq governor
Message-ID: <20080710180553.GB13890@isilmar.linta.de>
References: <200807071702.31240.arnd@arndb.de>
	<20080707213105.GD4997@codemonkey.org.uk>
	<200807080843.43674.arnd@arndb.de>
	<20080708152728.GF4997@codemonkey.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
In-Reply-To: <20080708152728.GF4997@codemonkey.org.uk>
Cc: Stephen Rothwell <sfr@canb.auug.org.au>, Arnd Bergmann <arnd@arndb.de>,
	linuxppc-dev@ozlabs.org, Jeremy Kerr <jk@ozlabs.org>,
	cpufreq@lists.linux.org.uk, cbe-oss-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Tue, Jul 08, 2008 at 11:27:28AM -0400, Dave Jones wrote:
> On Tue, Jul 08, 2008 at 08:43:43AM +0200, Arnd Bergmann wrote:
>  > On Monday 07 July 2008, Dave Jones wrote:
>  > > One question I do have though, is how userspace scripts are supposed
>  > > to know they're to echo cbe_spu_governor into the relevant parts of
>  > > sysfs.  I've not used anything with a cell. Do they expose the SPUs
>  > > as regular CPUs, or do they show up in a different part of the tree?
>  > 
>  > An SPU is very different from a CPU from the user perspective.
>  > SPUs show up in /sys/devices/system/spus, and if a user wants to access
>  > them, the "spufs" file system needs to be mounted in the system, by
>  > convention on /spu. 
> 
> Ok, that should be fairly simple to write scripts for.

Actually, "cpufreq-set -g spu_governor" should be enough. (BTW, do we really
want this name?)

Best,
	Dominik
