Return-Path: <hch@lst.de>
Received: from newverein.lst.de (verein.lst.de [213.95.11.211])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3vPJjY00vDzDq60
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 17 Feb 2017 01:40:32 +1100 (AEDT)
Date: Thu, 16 Feb 2017 15:40:30 +0100
From: Christoph Hellwig <hch@lst.de>
To: Jon Derrick <jonathan.derrick@intel.com>
Cc: linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org, Scott Bauer <scott.bauer@intel.com>,
 Rafael Antognolli <rafael.antognolli@intel.com>,
 Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: [PATCHv4 2/4] block/sed: Add helper to qualify response tokens
Message-ID: <20170216144030.GA32375@lst.de>
References: <1487195159-12599-1-git-send-email-jonathan.derrick@intel.com>
 <1487195159-12599-3-git-send-email-jonathan.derrick@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1487195159-12599-3-git-send-email-jonathan.derrick@intel.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, Feb 15, 2017 at 02:45:55PM -0700, Jon Derrick wrote:
> Add helper which verifies the response token is valid and matches the
> expected value. Merges token_type and response_get_token.
> 
> Signed-off-by: Jon Derrick <jonathan.derrick@intel.com>
> Reviewed-by: Scott Bauer <scott.bauer@intel.com>

Looks fine,

Reviewed-by: Christoph Hellwig <hch@lst.de>
