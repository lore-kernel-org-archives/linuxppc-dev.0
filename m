Return-Path: <gregkh@suse.de>
Received: from mx1.suse.de (cantor.suse.de [195.135.220.2])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx1.suse.de", Issuer "CAcert Class 3 Root" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id AAB3DB6F0E
	for <linuxppc-dev@ozlabs.org>; Thu, 29 Jul 2010 04:55:19 +1000 (EST)
Date: Wed, 28 Jul 2010 11:46:47 -0700
From: Greg KH <gregkh@suse.de>
To: Grant Likely <grant.likely@secretlab.ca>
Subject: Re: [PATCH 2/3] USB: add of_platform glue driver for FSL USB DR
	controller
Message-ID: <20100728184647.GA7128@suse.de>
References: <1279815922-27198-1-git-send-email-agust@denx.de>
	<1279815922-27198-3-git-send-email-agust@denx.de>
	<AANLkTinSeFWM4bQK+o8nwStd6C-OcxMagC7TjwCBNn1v@mail.gmail.com>
	<20100728135858.5dc14484@wker>
	<AANLkTimrtR4yi0czotS_6K_njxiA4orj6SznpqWDGBpy@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <AANLkTimrtR4yi0czotS_6K_njxiA4orj6SznpqWDGBpy@mail.gmail.com>
Cc: David Brownell <dbrownell@users.sourceforge.net>,
	Wolfgang Denk <wd@denx.de>, Detlev Zundel <dzu@denx.de>,
	linux-usb@vger.kernel.org, linuxppc-dev@ozlabs.org,
	Anatolij Gustschin <agust@denx.de>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, Jul 28, 2010 at 12:14:14PM -0600, Grant Likely wrote:
> On Wed, Jul 28, 2010 at 5:58 AM, Anatolij Gustschin <agust@denx.de> wrote:
> > Hi Grant,
> >
> > On Wed, 28 Jul 2010 02:16:08 -0600
> > Grant Likely <grant.likely@secretlab.ca> wrote:
> >
> >> On Thu, Jul 22, 2010 at 10:25 AM, Anatolij Gustschin <agust@denx.de> wrote:
> >> > The driver creates platform devices based on the information
> >> > from USB nodes in the flat device tree. This is the replacement
> >> > for old arch fsl_soc usb code removed by the previous patch.
> >> > It uses usual of-style binding, available EHCI-HCD and UDC
> >> > drivers can be bound to the created devices. The new of-style
> >> > driver additionaly instantiates USB OTG platform device, as the
> >> > appropriate USB OTG driver will be added soon.
> >> >
> >> > Signed-off-by: Anatolij Gustschin <agust@denx.de>
> >> > Cc: Kumar Gala <galak@kernel.crashing.org>
> >> > Cc: Grant Likely <grant.likely@secretlab.ca>
> >>
> >> Hi Anatolij,
> >>
> >> Looks pretty good, but some comments below.
> >
> > Thanks for review and comments! Greg already merged this series and
> > therefore I'll submit an incremental cleanup patch to address
> > outstanding issues. My reply is below.
> 
> Greg maintains a patchwork tree IIRC.  I believe he drops patches from
> his linux-next branch if they need to be reworked.  Greg, do I have
> this right?

Yup.  I can easily drop all of these patches.

> Also, my preference would be to see some 3rd party testing before
> committing to having this merged.

Ok, I will go drop them all now, and wait for some that pass your
review.

thanks,

greg k-h
