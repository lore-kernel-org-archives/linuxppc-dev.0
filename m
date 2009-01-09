Return-Path: <robert.richter@amd.com>
Date: Fri, 9 Jan 2009 15:30:43 +0100
From: Robert Richter <robert.richter@amd.com>
To: Carl Love <cel@us.ibm.com>
Subject: Re: [Patch 0/3] Overview, OProfile SPU event profiling support for
	IBM Cell processor
Message-ID: <20090109143042.GU15411@erda.amd.com>
References: <1228177106.6509.285.camel@carll-linux-desktop>
	<20090108154835.GQ15411@erda.amd.com>
	<1231460791.6621.54.camel@carll-linux-desktop>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
In-Reply-To: <1231460791.6621.54.camel@carll-linux-desktop>
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

On 08.01.09 16:26:31, Carl Love wrote:
> >  git://git.kernel.org/pub/scm/linux/kernel/git/rric/oprofile.git cell
> > 
> > The patches did not apply cleanly. I had to change the path to
> > arch/powerpc/include/asm/, fix cell/pr_util.h and did some whitespace
> > cleanups. Please run your tests on the cell branch.

Thanks Carl, could you also test the 'next' branch on your
architecture, please? This is the latest version of patches to go
upstream (containing your patches also).

Thanks,

-Robert

-- 
Advanced Micro Devices, Inc.
Operating System Research Center
email: robert.richter@amd.com
