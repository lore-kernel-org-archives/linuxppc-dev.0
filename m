Return-Path: <gregkh@linuxfoundation.org>
Received: from mail-da0-f43.google.com (mail-da0-f43.google.com
 [209.85.210.43])
 (using TLSv1 with cipher ECDHE-RSA-RC4-SHA (128/128 bits))
 (Client CN "smtp.gmail.com", Issuer "Google Internet Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 3A6382C0326
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 11 Jan 2013 01:29:33 +1100 (EST)
Received: by mail-da0-f43.google.com with SMTP id u36so270333dak.30
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 10 Jan 2013 06:29:31 -0800 (PST)
Date: Thu, 10 Jan 2013 06:30:06 -0800
From: Greg KH <gregkh@linuxfoundation.org>
To: Felipe Balbi <balbi@ti.com>
Subject: Re: [BUILD BREAK] usb: gadget: fsl_mxc_udc can't compile on current
 v3.8-rc3
Message-ID: <20130110143006.GC15787@kroah.com>
References: <20130110100835.GB28920@arwen.pp.htv.fi>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20130110100835.GB28920@arwen.pp.htv.fi>
Cc: linuxppc-dev@lists.ozlabs.org, linux-usb@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, Jan 10, 2013 at 12:08:35PM +0200, Felipe Balbi wrote:
> Hi,
> 
> Some recent patch has caused fsl_mxc_udc.c driver to fail compilation
> because it can't find <mach/hardware.h> anymore.
> 
> I would like this to be fixed still during this -rc cycle.

Me too, who's sending a patch?  :)
