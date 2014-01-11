Return-Path: <greg@kroah.com>
Received: from out3-smtp.messagingengine.com (out3-smtp.messagingengine.com
 [66.111.4.27])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 5E8312C007A
 for <linuxppc-dev@ozlabs.org>; Sat, 11 Jan 2014 11:58:44 +1100 (EST)
Date: Fri, 10 Jan 2014 16:52:56 -0800
From: Greg KH <greg@kroah.com>
To: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Subject: Re: [PATCH 4/8] IBM Akebono: Add support to the OHCI platform driver
 for PPC476GTR
Message-ID: <20140111005256.GB29302@kroah.com>
References: <1385086057-10884-1-git-send-email-alistair@popple.id.au>
 <1385086116-10972-4-git-send-email-alistair@popple.id.au>
 <52D09E19.9030302@cogentembedded.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <52D09E19.9030302@cogentembedded.com>
Cc: linuxppc-dev@ozlabs.org, Alistair Popple <alistair@popple.id.au>,
 linux-usb@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Sat, Jan 11, 2014 at 04:27:53AM +0300, Sergei Shtylyov wrote:
> Hello.
> 
> On 11/22/2013 05:08 AM, Alistair Popple wrote:
> 
> >The IBM Akebono board uses the PPC476GTR SoC which has a OHCI
> >compliant USB host interface. This patch adds support for it to the
> >OHCI platform driver.
> 
> >As we use device tree to pass platform specific data instead of
> >platform data we remove the check for platform data and instead
> >provide reasonable defaults if no platform data is present. This is
> >similar to what is currently done in ehci-platform.c.
> >
> >Signed-off-by: Alistair Popple <alistair@popple.id.au>
> >Acked-by: Alan Stern <stern@rowland.harvard.edu>
> >Cc: linux-usb@vger.kernel.org
> 
>    Greg, why this patch hasn't been merged? Because it wasn't addressed to
> you (but BenH)? The other, ehci-platform.c patch didn't even get posted to
> linux-usb that time, but this one?

Probably, yes, if it's not sent to me, I'm guessing that the person
doesn't want it applied by me, especially if it's written by someone who
knows what they are doing.

I thought this was going through the PPC tree.  My USB patch queue is
empty, and closed, for 3.14-rc1.

thanks,

greg k-h
