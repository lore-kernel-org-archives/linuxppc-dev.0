Return-Path: <colin@colino.net>
Received: from paperstreet.colino.net (colino.net [213.41.131.56])
	(using TLSv1 with cipher EDH-RSA-DES-CBC3-SHA (168/168 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 5175767A6F
	for <linuxppc-dev@ozlabs.org>; Thu, 17 Mar 2005 18:12:41 +1100 (EST)
Date: Thu, 17 Mar 2005 07:51:57 +0100
From: Colin Leroy <colin@colino.net>
To: Paul Mackerras <paulus@samba.org>
Message-ID: <20050317075157.19aa4df0@jack.colino.net>
In-Reply-To: <16953.5968.397116.341920@cargo.ozlabs.ibm.com>
References: <16953.5968.397116.341920@cargo.ozlabs.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: linuxppc-dev@ozlabs.org, linux-usb-devel@lists.sourceforge.net
Subject: Re: [PATCH] Make sleep/wakeup work with USB on powerbooks
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On 17 Mar 2005 at 16h03, Paul Mackerras wrote:

Hi, 

> I am currently using this patch on my powerbook to fix the problems
> that USB was causing with sleep and wakeup.  Basically one of the USB
> controllers was getting a spurious wakeup immediately when put it
> into the suspend state.  This would cause the resume routine to be run
> after we had turned off the device, causing a machine check.
> 
> Also we had some races where we would turn off the clock to the apple
> OHCI cell(s) and then try to access them.  With this patch, sleep and
> wakeup are quite reliable.  The patch is against 2.6.11.

Would it be the "proper" patch I was looking for in the thread named
"[PATCH] Re-power USB ports on wakeup" ?

Or does it fix different issues ? Mine fixed, with a hack I think, the
fact that USB ports kept being powered down after one wakeup out of
two. I never got any machine check, however.

Thanks,
-- 
Colin
