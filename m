Return-Path: <htejun@gmail.com>
Received: from mail-yw0-x234.google.com (mail-yw0-x234.google.com
 [IPv6:2607:f8b0:4002:c05::234])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3vkh7G0Cf9zDqYt
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 17 Mar 2017 08:14:34 +1100 (AEDT)
Received: by mail-yw0-x234.google.com with SMTP id p77so41666234ywg.1
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 16 Mar 2017 14:14:33 -0700 (PDT)
Sender: Tejun Heo <htejun@gmail.com>
Date: Thu, 16 Mar 2017 17:14:30 -0400
From: Tejun Heo <tj@kernel.org>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Vaibhav Jain <vaibhav@linux.vnet.ibm.com>, linux-kernel@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org, Frederic Barrat <fbarrat@linux.vnet.ibm.com>
Subject: Re: [PATCH] kernfs: Check KERNFS_HAS_RELEASE before calling
 kernfs_release_file()
Message-ID: <20170316211430.GC1480@htj.duckdns.org>
References: <20170314024700.6167-1-vaibhav@linux.vnet.ibm.com>
 <20170314030829.GA26049@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20170314030829.GA26049@kroah.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hello, Greg.

On Tue, Mar 14, 2017 at 11:08:29AM +0800, Greg Kroah-Hartman wrote:
> Tejun, want to take this through your tree, or at the least, give me an
> ack for this?

Just acked.  I think going through your tree is better for this one.

Thanks!

-- 
tejun
