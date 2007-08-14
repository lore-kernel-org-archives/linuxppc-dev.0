Return-Path: <dgibson@ozlabs.org>
Date: Tue, 14 Aug 2007 17:56:13 +1000
From: David Gibson <david@gibson.dropbear.id.au>
To: Greg KH <gregkh@suse.de>
Subject: Re: [patch 07/12] powerpc: Fix size check for hugetlbfs
Message-ID: <20070814075613.GH8791@localhost.localdomain>
References: <20070814072244.882283903@mini.kroah.org>
	<20070814072918.GG15025@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20070814072918.GG15025@kroah.com>
Cc: Theodore Ts'o <tytso@mit.edu>, Zwane Mwaikambo <zwane@arm.linux.org.uk>,
	torvalds@linux-foundation.org, Justin Forbes <jmforbes@linuxtx.org>,
	linux-kernel@vger.kernel.org, Chris Wedgwood <reviews@ml.cw.f00f.org>,
	Domenico Andreoli <cavokz@gmail.com>,
	linuxppc-dev list <linuxppc-dev@ozlabs.org>,
	Randy Dunlap <rdunlap@xenotime.net>, Paul Mackerras <paulus@samba.org>,
	Chuck Ebbert <cebbert@redhat.com>, Dave Jones <davej@redhat.com>,
	Michael Krufky <mkrufky@linuxtv.org>, akpm@linux-foundation.org,
	Chuck Wolber <chuckw@quantumlinux.com>, stable@kernel.org,
	alan@lxorguk.ukuu.org.uk
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Tue, Aug 14, 2007 at 12:29:18AM -0700, Greg KH wrote:
> -stable review patch.  If anyone has any objections, please let us know.
> 
> ------------------
> From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
> 
> My "slices" address space management code that was added in 2.6.22
> implementation of get_unmapped_area() doesn't properly check that the
> size is a multiple of the requested page size. This allows userland to
> create VMAs that aren't a multiple of the huge page size with hugetlbfs
> (since hugetlbfs entirely relies on get_unmapped_area() to do that
> checking) which leads to a kernel BUG() when such areas are torn down.
> 
> Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>
> Signed-off-by: Paul Mackerras <paulus@samba.org>
> Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>

Acked-by: David Gibson <david@gibson.dropbear.id.au>

-- 
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson
