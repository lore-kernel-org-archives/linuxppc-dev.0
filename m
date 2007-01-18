Return-Path: <HNGUYEN@de.ibm.com>
In-Reply-To: <adavej4b1vi.fsf@cisco.com>
Subject: Re: [PATCH/RFC 2.6.21] ehca: ehca_uverbs.c: refactor ehca_mmap()
	for	better readability
To: Roland Dreier <rdreier@cisco.com>
Message-ID: <OF2AD534B2.A4948D9F-ONC1257267.006D39E5-85257267.006DAB06@de.ibm.com>
From: Hoang-Nam Nguyen <HNGUYEN@de.ibm.com>
Date: Thu, 18 Jan 2007 14:57:54 -0500
MIME-Version: 1.0
Content-type: text/plain; charset=US-ASCII
Cc: linux-kernel@vger.kernel.org, openib-general@openib.org,
	openfabrics-ewg@openib.org, hch@infradead.org,
	linuxppc-dev@ozlabs.org, Christoph Raisch <raisch@de.ibm.com>,
	linuxppc-dev-bounces+hnguyen=de.ibm.com@ozlabs.org,
	Hoang-Nam Nguyen <hnguyen@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

No problem. Will resend the full patch set for 2.6.21.
Thanks
Nam

linuxppc-dev-bounces+hnguyen=de.ibm.com@ozlabs.org wrote on 18.01.2007
13:56:01:

> I've kind of lost the plot here.  How does this patch fit in with the
> previous series of patches you posted?  Does it replace them or go on
> top of them?
>
> Can please you resend me the full series of patch that remove the use
> of do_mmap(), with all cleanups and bug fixes included?  And please
> roll up the fixes, I don't want one patch that adds a yield() inside a
> spinlock and then a later patch to fix it -- there's no sense in
> adding landmines for people potentially doing git bisect in the
> future.
>
> And also please try to split the patches so that they don't mix
> together two things -- please try to make the "remove obsolete
> prototypes" patch separate from the mmap fixes.
>
> Thanks...
> _______________________________________________
> Linuxppc-dev mailing list
> Linuxppc-dev@ozlabs.org
> https://ozlabs.org/mailman/listinfo/linuxppc-dev
