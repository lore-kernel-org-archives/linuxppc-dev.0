Return-Path: <robert.richter@amd.com>
Date: Fri, 31 Oct 2008 16:14:13 +0100
From: Robert Richter <robert.richter@amd.com>
To: Carl Love <cel@us.ibm.com>
Subject: Re: [UPDATED PATCH VER2] Cell OProfile: Incorrect local array size
	in activate spu profiling function
Message-ID: <20081031151413.GE9785@erda.amd.com>
References: <1224874049.20229.5.camel@carll-linux-desktop>
	<1224909595.16090.5.camel@localhost>
	<1225207079.20229.32.camel@carll-linux-desktop>
	<1225241514.7799.2.camel@localhost>
	<1225292805.20229.52.camel@carll-linux-desktop>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
In-Reply-To: <1225292805.20229.52.camel@carll-linux-desktop>
Cc: acjohnso <acjohnso@us.ibm.com>, linux-kernel <linux-kernel@vger.kernel.org>,
	Hannsj_uhl <Hannsj_uhl@de.ibm.com>, linuxppc-dev@ozlabs.org,
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

On 29.10.08 08:06:45, Carl Love wrote:
> Updated the patch to address comments by Michael Ellerman.  
> Specifically, changed upper limit in for loop to 
> ARRAY_SIZE() macro and added a check to make sure the 
> number of events specified by the user, which is used as
> the max for indexing various arrays, is no bigger then the
> declared size of the arrays.
> 
> The size of the pm_signal_local array should be equal to the
> number of SPUs being configured in the array.  Currently, the
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
