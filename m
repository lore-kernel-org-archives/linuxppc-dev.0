Return-Path: <davem@redhat.com>
Received: from mx1.redhat.com (mx1.redhat.com [209.132.183.28])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 5ED981A09A6
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 18 Mar 2015 06:00:51 +1100 (AEDT)
Date: Tue, 17 Mar 2015 15:00:45 -0400 (EDT)
Message-Id: <20150317.150045.2177571124929326883.davem@redhat.com>
To: fabf@skynet.be
Subject: Re: [PATCH 00/16 linux-next] drivers/net: constify of_device_id array
From: David Miller <davem@redhat.com>
In-Reply-To: <1426617469-781-1-git-send-email-fabf@skynet.be>
References: <1426617469-781-1-git-send-email-fabf@skynet.be>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Cc: netdev@vger.kernel.org, linux-wireless@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-can@vger.kernel.org,
 soren.brinkmann@xilinx.com, nios2-dev@lists.rocketboards.org,
 linuxppc-dev@lists.ozlabs.org, linux-arm-kernel@lists.infradead.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

From: Fabian Frederick <fabf@skynet.be>
Date: Tue, 17 Mar 2015 19:37:31 +0100

> This small patchset adds const to of_device_id arrays in
> drivers/net branch.

Series applied, thanks.
