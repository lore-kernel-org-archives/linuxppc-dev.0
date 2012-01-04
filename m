Return-Path: <greg@kroah.com>
Received: from out5.smtp.messagingengine.com (out5.smtp.messagingengine.com
 [66.111.4.29])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id 2739B1007D8
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  5 Jan 2012 10:16:24 +1100 (EST)
Received: from compute2.internal (compute2.nyi.mail.srv.osa [10.202.2.42])
 by gateway1.nyi.mail.srv.osa (Postfix) with ESMTP id B470F20D9A
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  4 Jan 2012 18:09:23 -0500 (EST)
Date: Wed, 4 Jan 2012 15:08:09 -0800
From: Greg KH <greg@kroah.com>
To: Stephen Rothwell <sfr@canb.auug.org.au>
Subject: Re: linux-next: manual merge of the driver-core tree with the
 powerpc tree
Message-ID: <20120104230809.GF24583@kroah.com>
References: <20111228165102.fbb6433fd94d11240134327e@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20111228165102.fbb6433fd94d11240134327e@canb.auug.org.au>
Cc: Deepthi Dharwar <deepthi@linux.vnet.ibm.com>,
 Trinabh Gupta <g.trinabh@gmail.com>, Kay Sievers <kay.sievers@vrfy.org>,
 linux-kernel@vger.kernel.org, linux-next@vger.kernel.org,
 Paul Mackerras <paulus@samba.org>, linuxppc-dev@lists.ozlabs.org,
 Arun R Bharadwaj <arun.r.bharadwaj@gmail.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, Dec 28, 2011 at 04:51:02PM +1100, Stephen Rothwell wrote:
> Hi Greg,
> 
> Today's linux-next merge of the driver-core tree got a conflict in
> arch/powerpc/kernel/sysfs.c between commit 595fe91447b0 ("powerpc: Export
> PIR data through sysfs") from the powerpc tree and commits 8a25a2fd126c
> ("cpu: convert 'cpu' and 'machinecheck' sysdev_class to a regular
> subsystem") and 707827f3387d ("powerpc/cpuidle: cpuidle driver for
> pSeries") from the driver-core tree.
> 
> I fixed it up (see below) and can carry the fix as necessary.

Looks good, thanks.

greg k-h
