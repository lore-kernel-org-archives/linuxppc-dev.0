Return-Path: <tmarri@apm.com>
Received: from exprod5og105.obsmtp.com (exprod5og105.obsmtp.com [64.18.0.180])
	by ozlabs.org (Postfix) with SMTP id 03636B7162
	for <linuxppc-dev@lists.ozlabs.org>;
	Sat, 12 Feb 2011 05:33:08 +1100 (EST)
Received: by mail-vw0-f45.google.com with SMTP id 12so1845806vws.18
	for <linuxppc-dev@lists.ozlabs.org>;
	Fri, 11 Feb 2011 10:33:04 -0800 (PST)
From: Tirumala Marri <tmarri@apm.com>
References: <1295477852-14735-1-git-send-email-tmarri@apm.com>
	<20110126191734.5dff9641@desktopvm.lvknet>
	<4d3a1de3bf1ff8a4f69bf2d90da0a1cf@mail.gmail.com>
	<20110208031925.60bd1118@apollo.gnet> <20110208013025.GA3151@kroah.com>
In-Reply-To: <20110208013025.GA3151@kroah.com>
MIME-Version: 1.0
Date: Fri, 11 Feb 2011 10:33:03 -0800
Message-ID: <4f99d54a42d4f13663c88b0b081f047b@mail.gmail.com>
Subject: RE: [PATCH V8 03/10] USB/ppc4xx: Add Synopsys DWC OTG Core Interface
	Layer
To: Greg KH <greg@kroah.com>, Alexander Gordeev <lasaine@lvk.cs.msu.su>
Content-Type: text/plain; charset=ISO-8859-1
Cc: Mark Miesfeld <mmiesfeld@apm.com>, linux-usb@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org, Fushen Chen <fchen@apm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

>
> > dwc_read_reg32 is used nowhere throughout the code. One of dwc_read32
> > and
> > dwc_read_reg32 should be removed IMO. There was once only
> > dwc_read_reg32. In
> > version 5 of your patchset I believe. Why did you add another function?
> > AFAIK it is not correct to store pointers in u32 because they need 8
> > bytes
> > on 64-bit archs. So it was ok with the old dwc_read_reg32.
> > [Marri] If u32 is 8bytes isn't pointer type would be 8bytes as well.
>
> Sorry, I don't understand that. I think u32 is always 32bit = 4byte on
> all archs. Right?

Yes.

Use an unsigned long if you want to hold a pointer correctly on all
arches.

[Marri] I see your point.
