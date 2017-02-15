Return-Path: <scott.bauer@intel.com>
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3vNsVl0Z1nzDq5s
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 16 Feb 2017 08:14:36 +1100 (AEDT)
Date: Wed, 15 Feb 2017 14:04:56 -0700
From: Scott Bauer <scott.bauer@intel.com>
To: Jon Derrick <jonathan.derrick@intel.com>
Cc: linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org,
 Rafael Antognolli <rafael.antognolli@intel.com>,
 Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: [PATCHv3 1/4] block/sed: Use ssize_t on atom parsers to return
 errors
Message-ID: <20170215210456.GA2178@sbauer-Z170X-UD5>
References: <1487187731-10293-1-git-send-email-jonathan.derrick@intel.com>
 <1487187731-10293-2-git-send-email-jonathan.derrick@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1487187731-10293-2-git-send-email-jonathan.derrick@intel.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, Feb 15, 2017 at 12:42:06PM -0700, Jon Derrick wrote:
> The short atom parser can return an errno from decoding but does not
> currently return the error as a signed value. Convert all of the parsers
> to ssize_t.
> 
> Signed-off-by: Jon Derrick <jonathan.derrick@intel.com>
Reviewed-by: Scott Bauer <scott.bauer@intel.com>
