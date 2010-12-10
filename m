Return-Path: <greg@kroah.com>
Received: from coco.kroah.org (kroah.org [198.145.64.141])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "coco.kroah.org", Issuer "Greg KH" (not verified))
	by ozlabs.org (Postfix) with ESMTPS id D0199B70AA
	for <linuxppc-dev@lists.ozlabs.org>;
	Sat, 11 Dec 2010 09:15:40 +1100 (EST)
Date: Fri, 10 Dec 2010 14:13:27 -0800
From: Greg KH <greg@kroah.com>
To: Tirumala Marri <tmarri@apm.com>
Subject: Re: [PATCH V6 09/10] USB/ppc4xx:Synopsys DWC OTG driver enable
	gadget support
Message-ID: <20101210221327.GB4620@kroah.com>
References: <1291854755-25103-1-git-send-email-tmarri@apm.com>
	<4D00D89B.6020208@ru.mvista.com>
	<AANLkTimp8iF2PxApA2kXF64TM47_EeGM9BZrfi1uEVJj@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
In-Reply-To: <AANLkTimp8iF2PxApA2kXF64TM47_EeGM9BZrfi1uEVJj@mail.gmail.com>
Cc: Mark Miesfeld <mmiesfeld@apm.com>, linux-usb@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org, Fushen Chen <fchen@apm.com>,
	Sergei Shtylyov <sshtylyov@mvista.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, Dec 09, 2010 at 08:52:45AM -0800, Tirumala Marri wrote:
> On Thu, Dec 9, 2010 at 5:24 AM, Sergei Shtylyov <sshtylyov@mvista.com> wrote:
> > Hello.
> >
> > On 09-12-2010 3:32, tmarri@apm.com wrote:
> >
> >> From: Tirumala Marri<tmarri@apm.com>
> >
> >> Enable gadget support
> >
> >> Signed-off-by: Tirumala R Marri<tmarri@apm.com>
> >> Signed-off-by: Fushen Chen<fchen@apm.com>
> >> Signed-off-by: Mark Miesfeld<mmiesfeld@apm.com>
> >
> > [...]
> >
> >> diff --git a/drivers/usb/gadget/Kconfig b/drivers/usb/gadget/Kconfig
> >> index 747b0d3..b2bcc4e 100644
> >> --- a/drivers/usb/gadget/Kconfig
> >> +++ b/drivers/usb/gadget/Kconfig
> >> @@ -365,6 +365,28 @@ config USB_GADGET_MUSB_HDRC
> >
> > [...]
> >>
> >> +config USB_OTG
> >> +       boolean "OTG Support"
> >
> >   This symbol is already defined in drivers/usb/core/Kconfig.
> >
> > WBR, Sergei
> >
> Sure I will fix that.

Other than this minor thing, the patches look good.  I'll go apply
patches 1-8 for now, care to resend 9 and 10 with this change made?

thanks,

greg k-h
