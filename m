Return-Path: <gregkh@linuxfoundation.org>
Received: from mail.linuxfoundation.org (mail.linuxfoundation.org
 [140.211.169.12])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3vknjY5VyyzDqfx
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 17 Mar 2017 12:26:09 +1100 (AEDT)
Date: Fri, 17 Mar 2017 10:25:53 +0900
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Tejun Heo <tj@kernel.org>
Cc: Vaibhav Jain <vaibhav@linux.vnet.ibm.com>, linux-kernel@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org, Frederic Barrat <fbarrat@linux.vnet.ibm.com>
Subject: Re: [PATCH] kernfs: Check KERNFS_HAS_RELEASE before calling
 kernfs_release_file()
Message-ID: <20170317012553.GA31878@kroah.com>
References: <20170314024700.6167-1-vaibhav@linux.vnet.ibm.com>
 <20170314030829.GA26049@kroah.com>
 <20170316211430.GC1480@htj.duckdns.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20170316211430.GC1480@htj.duckdns.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, Mar 16, 2017 at 05:14:30PM -0400, Tejun Heo wrote:
> Hello, Greg.
> 
> On Tue, Mar 14, 2017 at 11:08:29AM +0800, Greg Kroah-Hartman wrote:
> > Tejun, want to take this through your tree, or at the least, give me an
> > ack for this?
> 
> Just acked.  I think going through your tree is better for this one.

Ok, will take it in my tree, thanks.

greg k-h
