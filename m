Return-Path: <B29397@freescale.com>
Received: from co9outboundpool.messaging.microsoft.com
 (co9ehsobe003.messaging.microsoft.com [207.46.163.26])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "Microsoft Secure Server Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 3BE422C0156
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 11 Jan 2013 12:37:19 +1100 (EST)
Date: Fri, 11 Jan 2013 09:37:06 +0800
From: Peter Chen <peter.chen@freescale.com>
To: Greg KH <gregkh@linuxfoundation.org>
Subject: Re: [BUILD BREAK] usb: gadget: fsl_mxc_udc can't compile on
 current v3.8-rc3
Message-ID: <20130111013705.GB27399@nchen-desktop>
References: <20130110100835.GB28920@arwen.pp.htv.fi>
 <20130110143006.GC15787@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
In-Reply-To: <20130110143006.GC15787@kroah.com>
Cc: linuxppc-dev@lists.ozlabs.org, linux-usb@vger.kernel.org,
 Felipe Balbi <balbi@ti.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, Jan 10, 2013 at 06:30:06AM -0800, Greg KH wrote:
> On Thu, Jan 10, 2013 at 12:08:35PM +0200, Felipe Balbi wrote:
> > Hi,
> > 
> > Some recent patch has caused fsl_mxc_udc.c driver to fail compilation
> > because it can't find <mach/hardware.h> anymore.
> > 
> > I would like this to be fixed still during this -rc cycle.
> 
> Me too, who's sending a patch?  :)
Let me have a look, and try to send a patch as soon as possible
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-usb" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 

-- 

Best Regards,
Peter Chen
