Return-Path: <jgarzik@pobox.com>
Received: from mail.dvmed.net (srv5.dvmed.net [207.36.208.214])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 232D8DE027
	for <linuxppc-dev@ozlabs.org>; Wed,  5 Dec 2007 07:07:09 +1100 (EST)
Message-ID: <4755B365.1010108@pobox.com>
Date: Tue, 04 Dec 2007 15:07:01 -0500
From: Jeff Garzik <jgarzik@pobox.com>
MIME-Version: 1.0
To: Grant Likely <grant.likely@secretlab.ca>
Subject: Re: [PATCH] gianfar: fix compile warning
References: <20071202050927.8827.27154.stgit@trillian.secretlab.ca>
In-Reply-To: <20071202050927.8827.27154.stgit@trillian.secretlab.ca>
Content-Type: text/plain; charset=UTF-8; format=flowed
Cc: linuxppc-dev@ozlabs.org, netdev@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Grant Likely wrote:
> From: Grant Likely <grant.likely@secretlab.ca>
> 
> Eliminate an uninitialized variable warning.  The code is correct, but
> a pointer to the automatic variable 'addr' is passed to dma_alloc_coherent.
> Since addr has never been initialized, and the compiler doesn't know
> what dma_alloc_coherent will do with it, it complains.
> 
> Signed-off-by: Grant Likely <grant.likely@secretlab.ca>
> ---
> 
> Jeff, this one should go in for 2.6.24

applied #upstream-fixes
