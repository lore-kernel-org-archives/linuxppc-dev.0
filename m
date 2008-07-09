Return-Path: <davej@codemonkey.org.uk>
Date: Tue, 8 Jul 2008 23:57:19 -0400
From: Dave Jones <davej@codemonkey.org.uk>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: powerpc/cell/cpufreq: add spu aware cpufreq governor
Message-ID: <20080709035719.GA27742@codemonkey.org.uk>
References: <200807071702.31240.arnd@arndb.de>
	<20080707213105.GD4997@codemonkey.org.uk>
	<200807080843.43674.arnd@arndb.de>
	<20080708152728.GF4997@codemonkey.org.uk>
	<1215574898.8970.308.camel@pasglop>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1215574898.8970.308.camel@pasglop>
Cc: Stephen Rothwell <sfr@canb.auug.org.au>, Arnd Bergmann <arnd@arndb.de>,
	cpufreq@lists.linux.org.uk, linuxppc-dev@ozlabs.org,
	Jeremy Kerr <jk@ozlabs.org>, cbe-oss-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Wed, Jul 09, 2008 at 01:41:38PM +1000, Ben Herrenschmidt wrote:
 > On Tue, 2008-07-08 at 11:27 -0400, Dave Jones wrote:
 > > On Tue, Jul 08, 2008 at 08:43:43AM +0200, Arnd Bergmann wrote:
 > >  > On Monday 07 July 2008, Dave Jones wrote:
 > >  > > One question I do have though, is how userspace scripts are supposed
 > >  > > to know they're to echo cbe_spu_governor into the relevant parts of
 > >  > > sysfs.  I've not used anything with a cell. Do they expose the SPUs
 > >  > > as regular CPUs, or do they show up in a different part of the tree?
 > >  > 
 > >  > An SPU is very different from a CPU from the user perspective.
 > >  > SPUs show up in /sys/devices/system/spus, and if a user wants to access
 > >  > them, the "spufs" file system needs to be mounted in the system, by
 > >  > convention on /spu. 
 > > 
 > > Ok, that should be fairly simple to write scripts for.
 > > All sounds good to me.
 > 
 > Can I add your Acked-by ?

Absolutely.

ACKed-by: Dave Jones <davej@redhat.com>

	Dave 

-- 
http://www.codemonkey.org.uk
