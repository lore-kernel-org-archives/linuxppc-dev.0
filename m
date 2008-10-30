Return-Path: <paulus@ozlabs.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Message-ID: <18697.5631.243048.551898@cargo.ozlabs.ibm.com>
Date: Thu, 30 Oct 2008 13:03:43 +1100
From: Paul Mackerras <paulus@samba.org>
To: akpm@linux-foundation.org
Subject: Re: [patch 1/1] powerpc: hugetlb pgtable cache access cleanup
In-Reply-To: <200810292118.m9TLIU7J018621@imap1.linux-foundation.org>
References: <200810292118.m9TLIU7J018621@imap1.linux-foundation.org>
Cc: linuxppc-dev@ozlabs.org, kniht@linux.vnet.ibm.com, nickpiggin@yahoo.com.au
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

akpm@linux-foundation.org writes:

> From: Jon Tollefson <kniht@linux.vnet.ibm.com>
> 
> Cleaned up use of macro.  We now reference the pgtable_cache array
> directly instead of using a macro.
> 
> Signed-off-by: Jon Tollefson <kniht@linux.vnet.ibm.com>
> Cc: Nick Piggin <nickpiggin@yahoo.com.au>
> Cc: Paul Mackerras <paulus@samba.org>
> Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>
> Signed-off-by: Andrew Morton <akpm@linux-foundation.org>

As David Gibson noted, the patch description fails to tell us why this
is a good thing to do (and it isn't immediately obvious to me why it
would be good to make this change).  Jon, please resubmit with a
description that includes the motivation for the change.

Paul.
