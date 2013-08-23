Return-Path: <gregkh@linuxfoundation.org>
Received: from mail.linuxfoundation.org (mail.linuxfoundation.org
 [140.211.169.12]) by ozlabs.org (Postfix) with ESMTP id 7F2F62C0089
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 23 Aug 2013 14:08:32 +1000 (EST)
Date: Thu, 22 Aug 2013 21:10:10 -0700
From: Greg KH <gregkh@linuxfoundation.org>
To: Rui Xiang <rui.xiang@huawei.com>
Subject: Re: [PATCH 0/2] fs: supply inode uid/gid setting interface
Message-ID: <20130823041010.GA12296@kroah.com>
References: <1377226118-43756-1-git-send-email-rui.xiang@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1377226118-43756-1-git-send-email-rui.xiang@huawei.com>
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

On Fri, Aug 23, 2013 at 10:48:36AM +0800, Rui Xiang wrote:
> This patchset implements an accessor functions to set uid/gid
> in inode struct. Just finish code clean up.

Why?
