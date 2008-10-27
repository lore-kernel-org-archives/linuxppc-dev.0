Return-Path: <robert.richter@amd.com>
Date: Mon, 27 Oct 2008 19:26:02 +0100
From: Robert Richter <robert.richter@amd.com>
To: Carl Love <cel@us.ibm.com>
Subject: Re: [Cbe-oss-dev] [PATCH] Cell OProfile: Incorrect local array
	size in activate spu profiling function
Message-ID: <20081027182602.GE9785@erda.amd.com>
References: <1224874049.20229.5.camel@carll-linux-desktop>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
In-Reply-To: <1224874049.20229.5.camel@carll-linux-desktop>
Cc: linux-kernel <linux-kernel@vger.kernel.org>, linuxppc-dev@ozlabs.org,
	oprofile-list@lists.sourceforge.net, Ingo Molnar <mingo@elte.hu>,
	cel@linux.vnet.ibm.com, cbe-oss-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On 24.10.08 11:47:29, Carl Love wrote:
> 
> The size of the pm_signal_local array should be equal to the
> number of SPUs being configured in the call.  Currently, the
> array is of size 4 (NR_PHYS_CTRS) but being indexed by a for 
> loop from 0 to 7 (NUM_SPUS_PER_NODE).  
> 
> Signed-off-by: Carl Love <carll@us.ibm.com>

I applied your patch to oprofile/oprofile-for-tip. Thanks Carl.

-Robert

-- 
Advanced Micro Devices, Inc.
Operating System Research Center
email: robert.richter@amd.com
