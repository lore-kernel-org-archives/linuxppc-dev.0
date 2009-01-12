Return-Path: <robert.richter@amd.com>
Date: Mon, 12 Jan 2009 18:52:44 +0100
From: Robert Richter <robert.richter@amd.com>
To: Carl Love <cel@us.ibm.com>
Subject: Re: [Patch 0/3] Overview, OProfile SPU event profiling support for
	IBM Cell processor
Message-ID: <20090112175244.GJ15411@erda.amd.com>
References: <1228177106.6509.285.camel@carll-linux-desktop>
	<20090108154835.GQ15411@erda.amd.com>
	<1231460791.6621.54.camel@carll-linux-desktop>
	<1231630269.2142.91.camel@pasglop>
	<1231776927.6621.112.camel@carll-linux-desktop>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
In-Reply-To: <1231776927.6621.112.camel@carll-linux-desktop>
Cc: linux-kernel <linux-kernel@vger.kernel.org>, linuxppc-dev@ozlabs.org,
	oprofile-list@lists.sourceforge.net, cel <cel@linux.vnet.ibm.com>,
	cbe-oss-dev <cbe-oss-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On 12.01.09 08:15:27, Carl Love wrote:
> 
> On Sun, 2009-01-11 at 10:31 +1100, Benjamin Herrenschmidt wrote:
> > On Thu, 2009-01-08 at 16:26 -0800, Carl Love wrote:
> > > I pulled down the git tree, compiled and installed it.  I tested it
> > > against the OProfile testsuite, which includes SPU event profiling
> > > tests.  Everything passed.  The patch I submitted was against a 2.6.26
> > > tree.  You are now on a 2.6.28 tree so perhaps that is why the patch did
> > > not apply cleanly.  The patch has been out there for some time.  
> > 
> > When you submited it on Dec 2, it should have been against whatever was
> > the latest upstream at the time, not 2.6.26.
> > 
> > Cheers,
> > Ben.
> 
> Ben, Arnd and Robert:
> 
> The patch was against the latest Arnd Cell Kernel tree at the time it
> was posted. The OProfile for cell patches have all been submitted,
> accepted by Arnd (CELL Kernel maintainer) and pushed up stream by Arnd.
> Arnd has waited for the OProfile maintainer to review and approve the
> change before Arnd would push it upstream.  

The patches are already upstream in v2.6.29-rc1. Hope this is ok. I
had added them to the oprofile tree and the tree was merged be Linus.

-Robert

> So, at this point, Robert's (OProfile kernel maintainer) and Maynard's
> (OProfile user space maintainer) approval for the patches.  
> 
> The question now goes to Arnd and Robert, who is going to push the
> patches upstream?  Looks like Robert is ready to do it, so Arnd do you
> approve the patches?  Would you like to have Robert push the patches
> upstream or would you prefer to do it?  I think we need an
> answer/agreement on this.  

Arnd, I thought the patches were ok for you. If there are still some
concerns, we have to make delta patches.

See also here:

 git log -4 -p 25006644e6042aab4bb7cdc4bfc5777cd3141df7

-Robert

-- 
Advanced Micro Devices, Inc.
Operating System Research Center
email: robert.richter@amd.com
