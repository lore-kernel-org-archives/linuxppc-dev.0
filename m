Return-Path: <SRS0+9585c4e39412ddbfd682+1236+infradead.org+hch@pentafluge.srs.infradead.org>
Received: from pentafluge.infradead.org (pentafluge.infradead.org
	[213.146.154.40])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 4B2A6DE13B
	for <linuxppc-dev@ozlabs.org>; Fri, 12 Jan 2007 06:22:36 +1100 (EST)
Date: Thu, 11 Jan 2007 19:22:29 +0000
From: Christoph Hellwig <hch@infradead.org>
To: Roland Dreier <rdreier@cisco.com>
Subject: Re: [PATCH/RFC 2.6.21 1/5] ehca: declaration of queue structures
Message-ID: <20070111192229.GD24623@infradead.org>
References: <200701112007.49620.hnguyen@linux.vnet.ibm.com>
	<20070111191425.GA24623@infradead.org> <adaac0pl6f2.fsf@cisco.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <adaac0pl6f2.fsf@cisco.com>
Cc: linux-kernel@vger.kernel.org, openib-general@openib.org,
	openfabrics-ewg@openib.org,
	Christoph Hellwig <hch@infradead.org>, linuxppc-dev@ozlabs.org,
	raisch@de.ibm.com, Hoang-Nam Nguyen <hnguyen@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Thu, Jan 11, 2007 at 11:17:21AM -0800, Roland Dreier wrote:
>  > This indentation changes moves away from the preffered form.
> 
> I will fix when I merge it -- no need to resend.
> 
>  > Except for that the patch looks fine.
> 
> Christoph, did you look over all 5 or just this one so far?

I've looked over all briefly, but I need a few more minutes to understand
everything that's going on in patch 2.
