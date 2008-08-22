Return-Path: <martyn.welch@gefanuc.com>
Received: from ext-cn0ut-4.online-age.net (ext-cn0ut-4.online-age.net
	[63.210.253.233])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "ext-cn0ut.online-age.net",
	Issuer "Savvis Communications Root CA" (not verified))
	by ozlabs.org (Postfix) with ESMTPS id 83CCBDE9AE
	for <linuxppc-dev@ozlabs.org>; Fri, 22 Aug 2008 21:26:56 +1000 (EST)
Received: from int-cn0ut-4.online-age.net (int-cn0ut-4.online-age.net
	[3.159.252.73])
	by ext-cn0ut-4.online-age.net (8.13.6/8.13.6/20051114-SVVS-TLS-DNSBL)
	with ESMTP id m7MBQqxF007397
	for <linuxppc-dev@ozlabs.org>; Fri, 22 Aug 2008 07:26:52 -0400
Received: from alpmlip01.e2k.ad.ge.com (int-cn0ut-4.online-age.net
	[3.159.252.73])
	by int-cn0ut-4.online-age.net (8.13.6/8.13.6/20050510-SVVS) with ESMTP
	id m7MBQqiX015831
	for <linuxppc-dev@ozlabs.org>; Fri, 22 Aug 2008 07:26:52 -0400
Date: Fri, 22 Aug 2008 12:26:01 +0100
From: Martyn Welch <martyn.welch@gefanuc.com>
To: Martyn Welch <martyn.welch@gefanuc.com>
Subject: Re: [PATCH v2 1/2] powerpc: Board support for GE Fanuc SBC610
Message-Id: <20080822122601.162dddd4.martyn.welch@gefanuc.com>
In-Reply-To: <20080822121152.70f01597.martyn.welch@gefanuc.com>
References: <20080822104615.11984.93838.stgit@ubuntu8041.localdomain>
	<20080822104620.11984.30369.stgit@ubuntu8041.localdomain>
	<72120CFB-62D9-44B0-AD4F-26332C90F3C9@kernel.crashing.org>
	<20080822121152.70f01597.martyn.welch@gefanuc.com>
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

On Fri, 22 Aug 2008 12:11:52 +0100
Martyn Welch <martyn.welch@gefanuc.com> wrote:

> On Fri, 22 Aug 2008 05:56:53 -0500
> Kumar Gala <galak@kernel.crashing.org> wrote:
> 
> > >
> > > +		PowerPC,8641@0 {
> > > +			device_type = "cpu";
> > > +			reg = <0x00000000>;
> > > +			d-cache-line-size = <32>;	// 32 bytes
> > > +			i-cache-line-size = <32>;	// 32 bytes
> > > +			d-cache-size = <32768>;		// L1, 32K
> > > +			i-cache-size = <32768>;		// L1, 32K
> > > +			timebase-frequency = <0>;	// From uboot
> > > +			bus-frequency = <0>;		// From uboot
> > > +			clock-frequency = <0>;		// From uboot
> > > +			l2cr = <0x80000000>;		// Enable L2
> > 
> > do you expect the 'l2cr' prop to do anything?  Not sure if this is  
> > something apple invented or you did?
> > 
> 
> TBH, it was in the dts file that I based this on - I thought it was in the others as well - my mistake, I shall remove it.
> 
> > 
> > >
> > > +		i2c1: i2c@3000 {
> > > +			#address-cells = <1>;
> > > +			#size-cells = <0>;
> > > +			device_type = "i2c";
> > 
> > drop device_type.
> > 
> 
> Ah - _all_ device_type!
> 

Um, not all - just the ones where the name of the block matches the device type(?)

Martyn

-- 
Martyn Welch MEng MPhil MIET (Principal Software Engineer)   T:+44(0)1327322748
GE Fanuc Intelligent Platforms Ltd,        |Registered in England and Wales
Tove Valley Business Park, Towcester,      |(3828642) at 100 Barbirolli Square,
Northants, NN12 6PF, UK T:+44(0)1327359444 |Manchester,M2 3AB  VAT:GB 729849476
