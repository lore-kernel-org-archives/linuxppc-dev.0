Return-Path: <rui.xiang@huawei.com>
Received: from szxga03-in.huawei.com (szxga03-in.huawei.com [119.145.14.66])
 (using TLSv1 with cipher DES-CBC3-SHA (168/168 bits))
 (Client CN "myname.my.domain", Issuer "www.mirapoint.com" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id AD8262C0090
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 23 Aug 2013 17:43:37 +1000 (EST)
Message-ID: <5217100E.6080506@huawei.com>
Date: Fri, 23 Aug 2013 15:32:30 +0800
From: Rui Xiang <rui.xiang@huawei.com>
MIME-Version: 1.0
To: Greg KH <gregkh@linuxfoundation.org>
Subject: Re: [PATCH 0/2] fs: supply inode uid/gid setting interface
References: <1377226118-43756-1-git-send-email-rui.xiang@huawei.com>
 <20130823041010.GA12296@kroah.com>
In-Reply-To: <20130823041010.GA12296@kroah.com>
Content-Type: text/plain; charset="ISO-8859-1"
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

On 2013/8/23 12:10, Greg KH wrote:
> On Fri, Aug 23, 2013 at 10:48:36AM +0800, Rui Xiang wrote:
>> This patchset implements an accessor functions to set uid/gid
>> in inode struct. Just finish code clean up.
> 
> Why?
> 
It can introduce a new function to reduce some codes. 
 Just clean up. 


Thanks.
