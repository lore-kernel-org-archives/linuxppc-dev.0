Return-Path: <martyn.welch@gefanuc.com>
Received: from ext-cn0ut-8.online-age.net (Ext-cn0ut-8.online-age.net
	[63.210.253.238])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "ext-cn0ut.online-age.net",
	Issuer "Savvis Communications Root CA" (not verified))
	by ozlabs.org (Postfix) with ESMTPS id C5492DDF38
	for <linuxppc-dev@ozlabs.org>; Mon,  1 Sep 2008 18:35:44 +1000 (EST)
Received: from int-cn0ut-6.online-age.net (int-cn0ut-6.online-age.net
	[3.159.252.75])
	by ext-cn0ut-8.online-age.net (8.13.6/8.13.6/20051114-SVVS-TLS-DNSBL)
	with ESMTP id m818Ze5D008533
	for <linuxppc-dev@ozlabs.org>; Mon, 1 Sep 2008 04:35:40 -0400
Received: from alpmlip01.e2k.ad.ge.com (int-cn0ut-6.online-age.net
	[3.159.252.75])
	by int-cn0ut-6.online-age.net (8.13.6/8.13.6/20050510-SVVS) with ESMTP
	id m818ZemQ017283
	for <linuxppc-dev@ozlabs.org>; Mon, 1 Sep 2008 04:35:40 -0400
Date: Mon, 1 Sep 2008 09:35:29 +0100
From: Martyn Welch <martyn.welch@gefanuc.com>
To: Kumar Gala <galak@kernel.crashing.org>
Subject: Re: [PATCH v3 1/2] powerpc: Board support for GE Fanuc SBC610
Message-Id: <20080901093529.3a4371f7.martyn.welch@gefanuc.com>
In-Reply-To: <7E18A542-EA62-4F5B-992C-8AC3D9562F72@kernel.crashing.org>
References: <20080826131339.12883.61796.stgit@ubuntu8041.localdomain>
	<20080826131344.12883.60435.stgit@ubuntu8041.localdomain>
	<7E18A542-EA62-4F5B-992C-8AC3D9562F72@kernel.crashing.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Fri, 29 Aug 2008 07:04:18 -0500
Kumar Gala <galak@kernel.crashing.org> wrote:

> 
> On Aug 26, 2008, at 8:13 AM, Martyn Welch wrote:
> 
> > +
> > +		PowerPC,8641@0 {
> > +			device_type = "cpu";
> > +			reg = <0x00000000>;
> > +			d-cache-line-size = <32>;	// 32 bytes
> > +			i-cache-line-size = <32>;	// 32 bytes
> > +			d-cache-size = <32768>;		// L1, 32K
> > +			i-cache-size = <32768>;		// L1, 32K
> 
> >
> > +			timebase-frequency = <0>;	// From uboot
> > +			bus-frequency = <0>;		// From uboot
> > +			clock-frequency = <0>;		// From uboot
> 
> you can remove these since u-boot will set them.
> 

Ok.

> >
> > +		};
> > +		PowerPC,8641@1 {
> > +			device_type = "cpu";
> > +			reg = <0x00000001>;
> > +			d-cache-line-size = <32>;	// 32 bytes
> > +			i-cache-line-size = <32>;	// 32 bytes
> > +			d-cache-size = <32768>;		// L1, 32K
> > +			i-cache-size = <32768>;		// L1, 32K
> 
> >
> > +			timebase-frequency = <0>;	// From uboot
> > +			bus-frequency = <0>;		// From uboot
> > +			clock-frequency = <0>;		// From uboot
> 
> you can remove these since u-boot will set them.
> 

Will do.

> >
> > +		};
> > +	};
> > +
> > +	memory {
> > +		device_type = "memory";
> > +		reg = <0x00000000 0x40000000>;	// set by u-boot
> 
> if the comment is zero just set it to <0 0>;
> 

So "reg = <0x0 0x40000000>;" ?

> >
> > +	};
> > +
> 
> what u-boot version are you using/shipping with these boards?

U-boot 1.2.0

> Wondering if other props (like cache info, is set by u-boot for you).
> 
> - k

Martyn

-- 
Martyn Welch MEng MPhil MIET (Principal Software Engineer)   T:+44(0)1327322748
GE Fanuc Intelligent Platforms Ltd,        |Registered in England and Wales
Tove Valley Business Park, Towcester,      |(3828642) at 100 Barbirolli Square,
Northants, NN12 6PF, UK T:+44(0)1327359444 |Manchester,M2 3AB  VAT:GB 729849476
