Return-Path: <paulus@ozlabs.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Message-ID: <18744.25000.311915.697199@cargo.ozlabs.ibm.com>
Date: Fri, 5 Dec 2008 10:03:04 +1100
From: Paul Mackerras <paulus@samba.org>
To: Brian King <brking@linux.vnet.ibm.com>
Subject: Re: [PATCH 1/1] powerpc: Check for valid hugepage size in
	hugetlb_get_unmapped_area
In-Reply-To: <200812041408.mB4E8fRV002401@d01av03.pok.ibm.com>
References: <200812041408.mB4E8fRV002401@d01av03.pok.ibm.com>
Cc: linuxppc-dev@ozlabs.org, kniht@linux.vnet.ibm.com, agl@linux.vnet.ibm.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Brian King writes:

> It looks like most of the hugetlb code is doing the correct thing if
> hugepages are not supported, but the mmap code is not. If we get into
> the mmap code when hugepages are not supported, such as in an LPAR
> which is running Active Memory Sharing, we can oops the kernel. This
> patch fixes the oops being seen in this path.

Sounds like this is a regression since 2.6.27 - is it?  In any case, I
assume this needs to go to Linus for 2.6.28.  Do you agree?

Paul.
