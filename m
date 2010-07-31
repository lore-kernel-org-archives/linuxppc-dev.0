Return-Path: <greg@kroah.com>
Received: from coco.kroah.org (kroah.org [198.145.64.141])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "coco.kroah.org", Issuer "Greg KH" (not verified))
	by ozlabs.org (Postfix) with ESMTPS id D2D49B70A4
	for <linuxppc-dev@ozlabs.org>; Sun,  1 Aug 2010 05:58:42 +1000 (EST)
Date: Sat, 31 Jul 2010 12:55:06 -0700
From: Greg KH <greg@kroah.com>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [PATCH 0/8] v3 De-couple sysfs memory directories from memory
	sections
Message-ID: <20100731195506.GC4644@kroah.com>
References: <4C451BF5.50304@austin.ibm.com> <1280554584.1902.31.camel@pasglop>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1280554584.1902.31.camel@pasglop>
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org,
	KAMEZAWA Hiroyuki <kamezawa.hiroyu@jp.fujitsu.com>, linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Sat, Jul 31, 2010 at 03:36:24PM +1000, Benjamin Herrenschmidt wrote:
> On Mon, 2010-07-19 at 22:45 -0500, Nathan Fontenot wrote:
> > This set of patches de-couples the idea that there is a single
> > directory in sysfs for each memory section.  The intent of the
> > patches is to reduce the number of sysfs directories created to
> > resolve a boot-time performance issue.  On very large systems
> > boot time are getting very long (as seen on powerpc hardware)
> > due to the enormous number of sysfs directories being created.
> > On a system with 1 TB of memory we create ~63,000 directories.
> > For even larger systems boot times are being measured in hours.
> 
> Greg, Kame, how do we proceed with these ? I'm happy to put them in
> powerpc.git with appropriate acks or will you take them ?

I thought there would be at least one more round of these patches based
on the review comments, right?

I'll be glad to take them when everyone agrees with them.

thanks,

greg k-h
