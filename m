Return-Path: <greg@kroah.com>
Received: from out5-smtp.messagingengine.com (out5-smtp.messagingengine.com
 [66.111.4.29])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id 98B2BB6EF7
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 17 Feb 2012 03:24:41 +1100 (EST)
Received: from compute6.internal (compute6.nyi.mail.srv.osa [10.202.2.46])
 by gateway1.nyi.mail.srv.osa (Postfix) with ESMTP id 009C721147
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 16 Feb 2012 11:24:38 -0500 (EST)
Date: Thu, 16 Feb 2012 08:19:00 -0800
From: Greg KH <greg@kroah.com>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [PATCH] powerpc/usb: fix bug of kernel hang when initializing usb
Message-ID: <20120216161900.GA20827@kroah.com>
References: <1329386540-12341-1-git-send-email-Shengzhou.Liu@freescale.com>
 <1329388755.2892.15.camel@pasglop>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1329388755.2892.15.camel@pasglop>
Cc: linux-usb@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 Shengzhou Liu <Shengzhou.Liu@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, Feb 16, 2012 at 09:39:15PM +1100, Benjamin Herrenschmidt wrote:
> On Thu, 2012-02-16 at 18:02 +0800, Shengzhou Liu wrote:
> > If USB UTMI PHY is not enable, writing to portsc register will lead to
> > kernel hang during boot up.
> 
> Thanks, I'll try that tomorrow.
> 
> Greg, you're picking that up or should I ?

I can, if you let me know that this fixes your problem :)

thanks,

greg k-h
