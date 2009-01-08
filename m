Return-Path: <robert.richter@amd.com>
Date: Thu, 8 Jan 2009 16:48:35 +0100
From: Robert Richter <robert.richter@amd.com>
To: Carl Love <cel@us.ibm.com>
Subject: Re: [Patch 0/3] Overview, OProfile SPU event profiling support for
	IBM Cell processor
Message-ID: <20090108154835.GQ15411@erda.amd.com>
References: <1228177106.6509.285.camel@carll-linux-desktop>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
In-Reply-To: <1228177106.6509.285.camel@carll-linux-desktop>
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

On 01.12.08 16:18:26, Carl Love wrote:
> This is a rework of the previously posted set of patches.
> 
> Patch 1 is the user level patch to add the SPU events to the user
> OProfile tool.  
> 
> Patch 2 is a kernel patch to do code clean up and restructuring to make
> it easier to add the new SPU event profiling support.  This patch makes
> no functional changes.
> 
> Patch 3 is a kernel patch to add the SPU event profiling support.

I applied patch 2 & 3 to:

 git://git.kernel.org/pub/scm/linux/kernel/git/rric/oprofile.git cell

The patches did not apply cleanly. I had to change the path to
arch/powerpc/include/asm/, fix cell/pr_util.h and did some whitespace
cleanups. Please run your tests on the cell branch.

Thanks,

-Robert

-- 
Advanced Micro Devices, Inc.
Operating System Research Center
email: robert.richter@amd.com
