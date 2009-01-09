Return-Path: <cel@us.ibm.com>
Subject: Re: [Patch 0/3] Overview, OProfile SPU event profiling support for
	IBM Cell processor
From: Carl Love <cel@us.ibm.com>
To: Robert Richter <robert.richter@amd.com>
In-Reply-To: <20090108154835.GQ15411@erda.amd.com>
References: <1228177106.6509.285.camel@carll-linux-desktop>
	<20090108154835.GQ15411@erda.amd.com>
Content-Type: text/plain
Date: Thu, 08 Jan 2009 16:26:31 -0800
Message-Id: <1231460791.6621.54.camel@carll-linux-desktop>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org, cel <cel@linux.vnet.ibm.com>,
	linux-kernel <linux-kernel@vger.kernel.org>,
	oprofile-list@lists.sourceforge.net, cbe-oss-dev <cbe-oss-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On Thu, 2009-01-08 at 16:48 +0100, Robert Richter wrote:
> On 01.12.08 16:18:26, Carl Love wrote:
> > This is a rework of the previously posted set of patches.
> > 
> > Patch 1 is the user level patch to add the SPU events to the user
> > OProfile tool.  
> > 
> > Patch 2 is a kernel patch to do code clean up and restructuring to make
> > it easier to add the new SPU event profiling support.  This patch makes
> > no functional changes.
> > 
> > Patch 3 is a kernel patch to add the SPU event profiling support.
> 
> I applied patch 2 & 3 to:
> 
>  git://git.kernel.org/pub/scm/linux/kernel/git/rric/oprofile.git cell
> 
> The patches did not apply cleanly. I had to change the path to
> arch/powerpc/include/asm/, fix cell/pr_util.h and did some whitespace
> cleanups. Please run your tests on the cell branch.
> 
> Thanks,
> 
> -Robert
> 

I pulled down the git tree, compiled and installed it.  I tested it
against the OProfile testsuite, which includes SPU event profiling
tests.  Everything passed.  The patch I submitted was against a 2.6.26
tree.  You are now on a 2.6.28 tree so perhaps that is why the patch did
not apply cleanly.  The patch has been out there for some time.  

            Carl Love
