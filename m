Return-Path: <greg@kroah.com>
Received: from pentafluge.infradead.org (pentafluge.infradead.org
	[213.146.154.40])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 5685FDDE22
	for <linuxppc-dev@ozlabs.org>; Thu, 20 Mar 2008 16:25:07 +1100 (EST)
Date: Wed, 19 Mar 2008 21:57:19 -0700
From: Greg KH <greg@kroah.com>
To: Stephen Rothwell <sfr@canb.auug.org.au>
Subject: Re: linux-next: Tree for March 20
Message-ID: <20080320045719.GA26938@kroah.com>
References: <20080320143953.8d6b5a60.sfr@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20080320143953.8d6b5a60.sfr@canb.auug.org.au>
Cc: Theodore Tso <tytso@MIT.EDU>, LKML <linux-kernel@vger.kernel.org>,
	linuxppc-dev@ozlabs.org, linux-next@vger.kernel.org,
	Paul Mackerras <paulus@samba.org>, Dan Williams <dan.j.williams@intel.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Thu, Mar 20, 2008 at 02:39:53PM +1100, Stephen Rothwell wrote:
> Hi all,
> 
> I have created today's linux-next tree at
> git://git.kernel.org/pub/scm/linux/kernel/git/sfr/linux-next.git
> (tar balls at
> http://www.kernel.org/pub/linux/kernel/people/sfr/linux-next/).
> 
> You can see which trees have been included by looking in the Next/Trees
> file in the source.  There are also quilt-import.log and merge.log files
> in the Next directory.  Between each merge, the tree was built with
> a ppc64_defconfig for powerpc and an allmodconfig for x86_64.
> 
> I have started this tree by reverting the following:
> driver-core/driver-core-remove-no-longer-used-struct-class_device.patch
> 	should be merged late
> driver-core/ib-convert-struct-class_device-to-struct-device.patch
> 	conflicts with the infiniband tree
> driver-core/pm-make-wakeup-flags-available-whenever-config_pm-is-set.patch
> 	breaks non CONFIG_PM builds of drivers/serial/serial_core.c

These should be fixed tomorrow, I have new ones in my inbox to solve
these issues (I hope...)

thanks,

greg k-h
