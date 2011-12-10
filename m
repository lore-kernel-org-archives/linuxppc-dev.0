Return-Path: <greg@kroah.com>
Received: from out2.smtp.messagingengine.com (out2.smtp.messagingengine.com
 [66.111.4.26])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id 27A221007D9
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 10 Dec 2011 14:21:37 +1100 (EST)
Received: from compute5.internal (compute5.nyi.mail.srv.osa [10.202.2.45])
 by gateway1.nyi.mail.srv.osa (Postfix) with ESMTP id 8A63020A4B
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  9 Dec 2011 22:21:34 -0500 (EST)
Date: Fri, 9 Dec 2011 19:14:54 -0800
From: Greg KH <greg@kroah.com>
To: Paul Gortmaker <paul.gortmaker@windriver.com>
Subject: Re: [GIT PULL] tty-next: Fix Fsl 8250 BRK bug
Message-ID: <20111210031454.GA8265@kroah.com>
References: <20111207033957.GB20556@windriver.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20111207033957.GB20556@windriver.com>
Cc: gregkh@suse.de, linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org, alan@linux.intel.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, Dec 06, 2011 at 10:39:57PM -0500, Paul Gortmaker wrote:
> Hi Greg,
> 
> This is the Freescale hardware bug fix which turned into a
> six-pack of 8250 updates.  This is exactly what was posted
> in the v2 review, with just Alan's ack added[1].  Since nobody
> else has had any follow-on comments since then, I'm assuming
> that it is now good to go.
> 
> [1] https://lkml.org/lkml/2011/12/5/156
> 
> Thanks,
> Paul.
> ---
> 
> Please pull for tty-next to get:
> 
> The following changes since commit 5611cc4572e889b62a7b4c72a413536bf6a9c416:
> 
>   Linux 3.2-rc4 (2011-12-01 14:56:01 -0800)
> 
> are available in the git repository at:
>   git://git.kernel.org/pub/scm/linux/kernel/git/paulg/linux fsl-uart-fix

I took the "raw" patches from the emails, so you can delete this branch
now.

thanks,

greg k-h
