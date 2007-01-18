Return-Path: <rdreier@cisco.com>
Received: from sj-iport-5.cisco.com (sj-iport-5.cisco.com [171.68.10.87])
	by ozlabs.org (Postfix) with ESMTP id D6F57DDE35
	for <linuxppc-dev@ozlabs.org>; Fri, 19 Jan 2007 05:56:08 +1100 (EST)
To: Hoang-Nam Nguyen <hnguyen@linux.vnet.ibm.com>
Subject: Re: [PATCH/RFC 2.6.21] ehca: ehca_uverbs.c: refactor ehca_mmap() for
	better readability
References: <200701172312.14840.hnguyen@linux.vnet.ibm.com>
From: Roland Dreier <rdreier@cisco.com>
Date: Thu, 18 Jan 2007 10:56:01 -0800
In-Reply-To: <200701172312.14840.hnguyen@linux.vnet.ibm.com> (Hoang-Nam
	Nguyen's message of "Wed, 17 Jan 2007 23:12:13 +0100")
Message-ID: <adavej4b1vi.fsf@cisco.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: linux-kernel@vger.kernel.org, openib-general@openib.org,
	openfabrics-ewg@openib.org, hch@infradead.org,
	linuxppc-dev@ozlabs.org, raisch@de.ibm.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

I've kind of lost the plot here.  How does this patch fit in with the
previous series of patches you posted?  Does it replace them or go on
top of them?

Can please you resend me the full series of patch that remove the use
of do_mmap(), with all cleanups and bug fixes included?  And please
roll up the fixes, I don't want one patch that adds a yield() inside a
spinlock and then a later patch to fix it -- there's no sense in
adding landmines for people potentially doing git bisect in the
future.

And also please try to split the patches so that they don't mix
together two things -- please try to make the "remove obsolete
prototypes" patch separate from the mmap fixes.

Thanks...
