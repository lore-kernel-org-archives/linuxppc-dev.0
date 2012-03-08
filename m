Return-Path: <gregkh@linuxfoundation.org>
Received: from mail-yw0-f51.google.com (mail-yw0-f51.google.com
 [209.85.213.51])
 (using TLSv1 with cipher ECDHE-RSA-RC4-SHA (128/128 bits))
 (Client CN "smtp.gmail.com", Issuer "Google Internet Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 6C4AEB6EE6
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  9 Mar 2012 04:59:49 +1100 (EST)
Received: by yhnn12 with SMTP id n12so421904yhn.38
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 08 Mar 2012 09:59:47 -0800 (PST)
Date: Thu, 8 Mar 2012 09:59:41 -0800
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Stephen Rothwell <sfr@canb.auug.org.au>
Subject: Re: [PATCH 0/7] powerpc: remove the legacy iSeries platform specific
 drivers
Message-ID: <20120308175941.GB26516@kroah.com>
References: <20120308152853.b5010336abbb8f90e8a2500c@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20120308152853.b5010336abbb8f90e8a2500c@canb.auug.org.au>
Cc: Jens Axboe <axboe@kernel.dk>, linux-scsi@vger.kernel.org,
 LKML <linux-kernel@vger.kernel.org>,
 "James E.J. Bottomley" <JBottomley@parallels.com>,
 linux-serial@vger.kernel.org, netdev@vger.kernel.org,
 Brian King <brking@linux.vnet.ibm.com>,
 ppc-dev <linuxppc-dev@lists.ozlabs.org>, David Miller <davem@davemloft.net>,
 Alan Cox <alan@linux.intel.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, Mar 08, 2012 at 03:28:53PM +1100, Stephen Rothwell wrote:
> Hi all,
> 
> This series of patches removes all the legacy iSeries platform specific
> drivers (and the iSeries specific part of one).  The legacy iSeries
> platform main code has already bee removed along with CONFIG_PPC_ISERIES,
> so none of this code is selectable or needed any more.
> 
> It would probably be easiest if all these patches were merged via the
> powerpc tree to eliminate any dependencies between them.  Their impact on
> generic code is very small.

No objection from me at all.

greg k-h
