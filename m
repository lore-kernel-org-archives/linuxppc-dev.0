Return-Path: <sam@ravnborg.org>
Received: from pqueueb.post.tele.dk (pqueueb.post.tele.dk [193.162.153.10])
	by ozlabs.org (Postfix) with ESMTP id 0E098DDEF8
	for <linuxppc-dev@ozlabs.org>; Wed, 17 Dec 2008 18:48:57 +1100 (EST)
Received: from pfepb.post.tele.dk (pfepb.post.tele.dk [195.41.46.236])
	by pqueueb.post.tele.dk (Postfix) with ESMTP id 6F6678109
	for <linuxppc-dev@ozlabs.org>; Wed, 17 Dec 2008 08:26:57 +0100 (CET)
Date: Wed, 17 Dec 2008 08:28:23 +0100
From: Sam Ravnborg <sam@ravnborg.org>
To: Kamalesh Babulal <kamalesh@linux.vnet.ibm.com>
Subject: Re: next-20081216 - powerpc link error 'dynreloc miscount'
Message-ID: <20081217072823.GB3551@uranus.ravnborg.org>
References: <20081216223754.0c8e21d4.sfr@canb.auug.org.au>
	<20081217070858.GA7424@linux.vnet.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20081217070858.GA7424@linux.vnet.ibm.com>
Cc: Stephen Rothwell <sfr@canb.auug.org.au>, linux-kbuild@vger.kernel.org,
	mel@csn.ul.ie, LKML <linux-kernel@vger.kernel.org>,
	linuxppc-dev@ozlabs.org, linux-next@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Wed, Dec 17, 2008 at 12:38:58PM +0530, Kamalesh Babulal wrote:
> Hi,
> 	next-20081216 build breaks on powerpc
> 
> ld: dynreloc miscount for kernel/built-in.o, section .opd
> ld: can not edit opd Bad value
> make: *** [vmlinux.o] Error 1

Could it be this:

     http://sourceware.org/ml/binutils/2005-10/msg00334.html

	Sam
