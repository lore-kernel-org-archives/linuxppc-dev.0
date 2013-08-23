Return-Path: <davem@davemloft.net>
Received: from shards.monkeyblade.net (unknown
 [IPv6:2001:4f8:3:36:211:85ff:fe63:a549])
 by ozlabs.org (Postfix) with ESMTP id B941B2C0091
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 23 Aug 2013 15:21:45 +1000 (EST)
Date: Thu, 22 Aug 2013 22:21:42 -0700 (PDT)
Message-Id: <20130822.222142.765878355588087442.davem@davemloft.net>
To: rui.xiang@huawei.com
Subject: Re: [PATCH 2/2] fs: use inode_set_user to set uid/gid of inode
From: David Miller <davem@davemloft.net>
In-Reply-To: <1377226118-43756-3-git-send-email-rui.xiang@huawei.com>
References: <1377226118-43756-1-git-send-email-rui.xiang@huawei.com>
 <1377226118-43756-3-git-send-email-rui.xiang@huawei.com>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Cc: linux-s390@vger.kernel.org, linux-ia64@vger.kernel.org,
 linux-rdma@vger.kernel.org, netdev@vger.kernel.org, linux-usb@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-mm@kvack.org, viro@zeniv.linux.org.uk,
 cgroups@vger.kernel.org, linux-fsdevel@vger.kernel.org,
 v9fs-developer@lists.sourceforge.net, linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

From: Rui Xiang <rui.xiang@huawei.com>
Date: Fri, 23 Aug 2013 10:48:38 +0800

> Use the new interface to set i_uid/i_gid in inode struct.
> 
> Signed-off-by: Rui Xiang <rui.xiang@huawei.com>

For the networking bits:

Acked-by: David S. Miller <davem@davemloft.net>
