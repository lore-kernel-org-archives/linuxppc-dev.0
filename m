Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id D36DCDDF66
	for <linuxppc-dev@ozlabs.org>; Tue, 14 Oct 2008 07:51:48 +1100 (EST)
Subject: Re: [PATCH] powerpc/cell/oprofile: vma_map: fix test on
	overlay_tbl_offset
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Robert Richter <robert.richter@amd.com>
In-Reply-To: <20081013152139.GB23557@erda.amd.com>
References: <1223357268.8157.38.camel@pasglop>
	<200810071038.34085.arnd@arndb.de>
	<20081013152139.GB23557@erda.amd.com>
Content-Type: text/plain
Date: Tue, 14 Oct 2008 07:51:08 +1100
Message-Id: <1223931068.8157.274.camel@pasglop>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org, Paul Mackerras <paulus@samba.org>,
	Roel Kluin <12o3l@tiscali.nl>, oprofile-list@lists.sourceforge.net,
	Arnd Bergmann <arnd@arndb.de>
Reply-To: benh@kernel.crashing.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Mon, 2008-10-13 at 17:21 +0200, Robert Richter wrote:
> On 07.10.08 10:38:33, Arnd Bergmann wrote:
> > From: Roel Kluin <12o3l@tiscali.nl>
> > 
> > Offset is unsigned and when an address isn't found in the vma map
> > vma_map_lookup() returns the vma physical address + 0x10000000.
> > 
> > vma_map_lookup used to return 0xffffffff on a failed lookup, but
> > a change was made to return the vma physical address + 0x10000000
> > There are two callers of vam_map_lookup: one of them correctly 
> > deals with this new return value, but the other (below) did not.  
> > 
> > Signed-off-by: Roel Kluin <12o3l@tiscali.nl>
> > Acked-by: Maynard Johnson <maynardj@us.ibm.com>
> > Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> > Cc: oprofile-list@lists.sf.net
> > Cc: Carl Love <cel@us.ibm.com>
> 
> The patch has been applied to the powerpc-for-paul branch of
> git://git.kernel.org/pub/scm/linux/kernel/git/rric/oprofile.git

I think I already put it in the powerpc next branch.

Cheers,
Ben.
