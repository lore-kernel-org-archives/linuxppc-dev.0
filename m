Return-Path: <greg@kroah.com>
Received: from coco.kroah.org (kroah.org [198.145.64.141])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "coco.kroah.org", Issuer "Greg KH" (not verified))
	by ozlabs.org (Postfix) with ESMTPS id 80AC31007D1
	for <linuxppc-dev@lists.ozlabs.org>;
	Tue, 29 Mar 2011 05:41:32 +1100 (EST)
Date: Mon, 28 Mar 2011 11:39:14 -0700
From: Greg KH <greg@kroah.com>
To: Sergei Shtylyov <sshtylyov@mvista.com>
Subject: Re: [PATCH V9 10/10] USB ppc4xx: Add Synopsys DWC OTG driver kernel
	configuration and Makefile
Message-ID: <20110328183914.GA5072@kroah.com>
References: <1297119242-28562-1-git-send-email-tmarri@apm.com>
	<4D518B2D.3090603@ru.mvista.com>
	<5540911d2e000414054d989bbdc32f2c@mail.gmail.com>
	<4D90C78C.3050607@ru.mvista.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <4D90C78C.3050607@ru.mvista.com>
Cc: Tirumala Marri <tmarri@apm.com>, Mark Miesfeld <mmiesfeld@apm.com>,
	linux-usb@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
	Fushen Chen <fchen@apm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, Mar 28, 2011 at 09:38:20PM +0400, Sergei Shtylyov wrote:
> Hello.
> 
> Tirumala Marri wrote:
> 
> >>>+config DWC_DEVICE_ONLY
> >>>+	bool "DWC Device Only Mode"
> >>>+	select USB_GADGET_SELECTED
> >>>+
> >>>+endchoice
> 
> >>    So this is tri-modal driver after all... how come we place it in
> >>drivers/usb/otg/dwc/, while the same tri-modal MUSB driver was placed in
> >>drivers/usb/musb/?
> 
>    You still have quoting broken in your mailer -- I've fixed it up by hand...
> 
> >[Marri] Initially this was how the patch created. Greg KH, suggested to
> >move under OTG.
> 
>    Well, I know that. So this was a question to Greg...

Well, if that's not the right place to put it, Sergei, where do you
suggest that it go?  drivers/usb/dwc/ ?

thanks,

greg k-h
