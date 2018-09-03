Return-Path: <vkoul@kernel.org>
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 423n1h4RYFzF36f
 for <linuxppc-dev@lists.ozlabs.org>; Mon,  3 Sep 2018 20:55:33 +1000 (AEST)
Date: Mon, 3 Sep 2018 16:25:22 +0530
From: Vinod <vkoul@kernel.org>
To: Barry Song <21cnbao@gmail.com>
Cc: leoyang.li@nxp.com, zw@zh-kernel.org, dan.j.williams@intel.com,
 linuxppc-dev@lists.ozlabs.org, dmaengine@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/3] dmaengine: fsldma: move spin_lock_bh to spin_lock in
 tasklet
Message-ID: <20180903105522.GH2322@vkoul-mobl>
References: <1534510826-7603-1-git-send-email-21cnbao@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1534510826-7603-1-git-send-email-21cnbao@gmail.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 17-08-18, 06:00, Barry Song wrote:
> as you are already in a tasklet, it is unnecessary to call spin_lock_bh.

Applied all, thanks

You may want to check you send-mail options, they patches were all over
my inbox and npot threaded

-- 
~Vinod
