Return-Path: <robert.richter@amd.com>
Received: from WA4EHSOBE003.bigfish.com (outbound-wa4.frontbridge.com
	[216.32.181.16]) by ozlabs.org (Postfix) with ESMTP id E26FCDE08B
	for <linuxppc-dev@ozlabs.org>; Tue, 14 Oct 2008 02:22:05 +1100 (EST)
Date: Mon, 13 Oct 2008 17:21:39 +0200
From: Robert Richter <robert.richter@amd.com>
To: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH] powerpc/cell/oprofile: vma_map: fix test on
	overlay_tbl_offset
Message-ID: <20081013152139.GB23557@erda.amd.com>
References: <1223357268.8157.38.camel@pasglop>
	<200810071038.34085.arnd@arndb.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
In-Reply-To: <200810071038.34085.arnd@arndb.de>
Cc: linuxppc-dev@ozlabs.org, Paul Mackerras <paulus@samba.org>,
	Roel Kluin <12o3l@tiscali.nl>, oprofile-list@lists.sourceforge.net
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On 07.10.08 10:38:33, Arnd Bergmann wrote:
> From: Roel Kluin <12o3l@tiscali.nl>
> 
> Offset is unsigned and when an address isn't found in the vma map
> vma_map_lookup() returns the vma physical address + 0x10000000.
> 
> vma_map_lookup used to return 0xffffffff on a failed lookup, but
> a change was made to return the vma physical address + 0x10000000
> There are two callers of vam_map_lookup: one of them correctly 
> deals with this new return value, but the other (below) did not.  
> 
> Signed-off-by: Roel Kluin <12o3l@tiscali.nl>
> Acked-by: Maynard Johnson <maynardj@us.ibm.com>
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> Cc: oprofile-list@lists.sf.net
> Cc: Carl Love <cel@us.ibm.com>

The patch has been applied to the powerpc-for-paul branch of
git://git.kernel.org/pub/scm/linux/kernel/git/rric/oprofile.git

Thanks Roel and Arnd,

-Robert

-- 
Advanced Micro Devices, Inc.
Operating System Research Center
email: robert.richter@amd.com
