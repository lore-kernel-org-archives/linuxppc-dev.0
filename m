Return-Path: <mgreer@mvista.com>
Received: from zipcode.az.mvista.com (unknown [65.200.49.156])
	by ozlabs.org (Postfix) with ESMTP id 40ECCDDF67
	for <linuxppc-dev@ozlabs.org>; Wed, 21 Mar 2007 07:19:20 +1100 (EST)
Date: Tue, 20 Mar 2007 13:20:19 -0700
From: "Mark A. Greer" <mgreer@mvista.com>
To: "Mark A. Greer" <mgreer@mvista.com>
Subject: Re: [PATCH 8/15] zImage: Cleanup and improve zImage entry point
Message-ID: <20070320202019.GA30954@mag.az.mvista.com>
References: <20070305032307.GB31417@localhost.localdomain>
	<20070305032452.810C1DDF1B@ozlabs.org>
	<20070315223529.GA1314@mag.az.mvista.com>
	<20070316001429.GD6784@localhost.localdomain>
	<20070316010116.GC10786@mag.az.mvista.com>
	<20070316015023.GA6868@localhost.localdomain>
	<20070316033649.GA22233@mag.az.mvista.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20070316033649.GA22233@mag.az.mvista.com>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Thu, Mar 15, 2007 at 08:36:49PM -0700, Mark A. Greer wrote:
> On Fri, Mar 16, 2007 at 12:50:23PM +1100, David Gibson wrote:
> > On Thu, Mar 15, 2007 at 06:01:16PM -0700, Mark A. Greer wrote:
> > > On Fri, Mar 16, 2007 at 11:14:30AM +1100, David Gibson wrote:
> > > 
> > > What about something like this:
> > > 
> > > #define BSS_STACK(size) \
> > > 	static char _bss_stack[size]; \
> > > 	u32 _platform_stack_size = size;
> > > 
> > > Then in crt0.S add value of _platform_stack_size to _bss_stack to get r1?
> > > That should relocate correctly.
> > 
> > That sounds reasonable, though it's slightly more involved that the
> > current code.  I'm wrangling another stack of bootloader patches at
> > the moment, you want to send something to implement this?
> 
> Sure.  I want to get my current stack of patches working on top of yours
> & Scott's first then I'll make a patch for this (I've just hacked around
> this issue for now).  Stay tuned.

Just in case it wasn't noticed, Milton took care of this in

	"[PATCH 5/7] bootwrapper: missing relocation in crt0.S"

Thank you Milton.

Mark
