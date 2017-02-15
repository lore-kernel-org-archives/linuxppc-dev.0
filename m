Return-Path: <jonathan.derrick@intel.com>
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3vNqSB31JPzDq5W
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 16 Feb 2017 06:42:16 +1100 (AEDT)
From: Jon Derrick <jonathan.derrick@intel.com>
To: 
Cc: Jon Derrick <jonathan.derrick@intel.com>, linux-block@vger.kernel.org,
 linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 Scott Bauer <scott.bauer@intel.com>,
 Rafael Antognolli <rafael.antognolli@intel.com>,
 Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: [PATCHv3 0/4] OPAL patches
Date: Wed, 15 Feb 2017 12:42:05 -0700
Message-Id: <1487187731-10293-1-git-send-email-jonathan.derrick@intel.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Just a couple of fixes for sed-opal to prevent faulty firmware from
allowing us to go off in the weeds, and a helper to remove some
duplicate code.

v2->v3:
corrected the bad calculation on the response parser check and changed
it to only check the subpacket length

v1->v2:
left tok->len as a size_t
got everyone important on the same email thread


Jon Derrick (4):
  block/sed: Use ssize_t on atom parsers to return errors
  block/sed: Add helper to qualify response tokens
  block/sed: Check received header lengths
  MAINTAINERS: Remove powerpc's opal match

 MAINTAINERS      |   1 -
 block/sed-opal.c | 124 +++++++++++++++++++++++++++----------------------------
 2 files changed, 60 insertions(+), 65 deletions(-)

-- 
1.8.3.1
