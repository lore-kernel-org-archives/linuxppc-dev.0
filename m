Return-Path: <gregkh@suse.de>
Received: from mx2.suse.de (mx2.suse.de [195.135.220.15])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx2.suse.de",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 930A6DDEFF
	for <linuxppc-dev@ozlabs.org>; Fri, 11 May 2007 00:11:35 +1000 (EST)
Date: Thu, 10 May 2007 07:12:21 -0700
From: Greg KH <gregkh@suse.de>
To: Andy Whitcroft <apw@shadowen.org>
Subject: Re: [PATCH] update sysfs kset initialisation in PPC64 DLPAR IO driver
Message-ID: <20070510141221.GA26709@suse.de>
References: <464322F3.3010808@shadowen.org>
	<2c705c055fcd12202673ee8a3056153b@pinky>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <2c705c055fcd12202673ee8a3056153b@pinky>
Cc: Andrew Morton <akpm@osdl.org>,
	Linus Torvalds <torvalds@linux-foundation.org>, paulus@samba.org,
	linux-kernel@vger.kernel.org, linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Thu, May 10, 2007 at 03:00:50PM +0100, Andy Whitcroft wrote:
> 
> Move the rpadlpar device from "struct subsystem" to "struct kset"
> following the changes in sysfs.
> 
> Signed-off-by: Andy Whitcroft <apw@shadowen.org>
> ---
> 
> 	Ok, this patch seems to sort out the compile problem
> 	here and indeed boots and runs kernbench.  Perhaps
> 	you could confirm this is sufficient.

As per the discussion on the pci hotplug list, no, this doesn't seem to
fix the problem.  The developers there are looking into it.  If you can
test out patches for this, I'm sure the people there would appreciate
the help.

thanks,

greg k-h
