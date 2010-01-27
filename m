Return-Path: <gregkh@suse.de>
Received: from mx2.suse.de (cantor2.suse.de [195.135.220.15])
	by ozlabs.org (Postfix) with ESMTP id 20DA3B7F89
	for <linuxppc-dev@ozlabs.org>; Thu, 28 Jan 2010 01:55:25 +1100 (EST)
Date: Wed, 27 Jan 2010 06:50:54 -0800
From: Greg KH <gregkh@suse.de>
To: Anton Vorontsov <avorontsov@ru.mvista.com>
Subject: Re: [PATCH 0/3 for 2.6.33] Some fixes for kfifo and FHCI
Message-ID: <20100127145054.GA24673@suse.de>
References: <20100127140809.GA27906@oksana.dev.rtsoft.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20100127140809.GA27906@oksana.dev.rtsoft.ru>
Cc: Stefani Seibold <stefani@seibold.net>, linux-usb@vger.kernel.org,
	linux-kernel@vger.kernel.org, linuxppc-dev@ozlabs.org,
	Andrew Morton <akpm@linux-foundation.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, Jan 27, 2010 at 05:08:09PM +0300, Anton Vorontsov wrote:
> Hi all,
> 
> FHCI no longer builds after kfifo rework, this patch set is
> used to fix the issues.

If there are no objections to these, I'll queue these up and send them
through my tree as they affect the FHCI driver.

thanks,

greg k-h
