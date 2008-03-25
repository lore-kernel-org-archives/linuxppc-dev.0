Return-Path: <greg@kroah.com>
Received: from pentafluge.infradead.org (pentafluge.infradead.org
	[213.146.154.40])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 7FE0ADDE41
	for <linuxppc-dev@ozlabs.org>; Tue, 25 Mar 2008 18:27:47 +1100 (EST)
Date: Tue, 25 Mar 2008 00:31:11 -0700
From: Greg KH <greg@kroah.com>
To: Stephen Rothwell <sfr@canb.auug.org.au>
Subject: Re: linux-next: Tree for March 20
Message-ID: <20080325073111.GA17879@kroah.com>
References: <20080320143953.8d6b5a60.sfr@canb.auug.org.au>
	<20080320045719.GA26938@kroah.com>
	<20080325174817.6018edd8.sfr@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20080325174817.6018edd8.sfr@canb.auug.org.au>
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

On Tue, Mar 25, 2008 at 05:48:17PM +1100, Stephen Rothwell wrote:
> Hi Greg,
> 
> On Wed, 19 Mar 2008 21:57:19 -0700 Greg KH <greg@kroah.com> wrote:
> >
> > On Thu, Mar 20, 2008 at 02:39:53PM +1100, Stephen Rothwell wrote:
> > > 
> > > driver-core/driver-core-remove-no-longer-used-struct-class_device.patch
> > > 	should be merged late
> 
> I still need to revert this so that the scsi tree can build (st.c).

I'll be sending this to Linus after -rc1 comes out, so it's fine that it
needs to be reverted for now.

> > > driver-core/ib-convert-struct-class_device-to-struct-device.patch
> > > 	conflicts with the infiniband tree
> 
> This still has the same conflicts, but they are papered over by my use of
> git-rerere (which remembers my previous merge fixup and applies it for
> me).

Yeah, __FUNCTION__ fun :(

> > > driver-core/pm-make-wakeup-flags-available-whenever-config_pm-is-set.patch
> > > 	breaks non CONFIG_PM builds of drivers/serial/serial_core.c
> 
> This one seems to be fixed.

Glad to hear it.

greg k-h
