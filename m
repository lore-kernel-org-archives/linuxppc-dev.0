Return-Path: <hch@lst.de>
Received: from newverein.lst.de (verein.lst.de [213.95.11.211])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 41BB1N2wwKzF0mQ
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 21 Jun 2018 16:02:09 +1000 (AEST)
Date: Thu, 21 Jun 2018 08:11:22 +0200
From: Christoph Hellwig <hch@lst.de>
To: Breno Leitao <leitao@debian.org>
Cc: linuxppc-dev@lists.ozlabs.org, Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH] powerpc: Wire up io_pgetevents
Message-ID: <20180621061122.GA2607@lst.de>
References: <1529523316-25027-1-git-send-email-leitao@debian.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1529523316-25027-1-git-send-email-leitao@debian.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, Jun 20, 2018 at 04:35:16PM -0300, Breno Leitao wrote:
> Wire up io_pgetevents system call on powerpc.
> 
> io_pgetevents is a new syscall to read asynchronous I/O events from the
> completion queue.
> 
> Tested with libaio branch aio-poll[1] and the io_pgetevents test (#22) passed
> on both ppc64 LE and BE modes.

Looks good to me:

Acked-by: Christoph Hellwig <hch@lst.de>
