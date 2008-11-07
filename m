Return-Path: <martyn.welch@gefanuc.com>
Received: from ext-nj2ut-13.online-age.net (ext-nj2ut-13.online-age.net
	[64.14.54.246])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "ext-nj2ut.online-age.net",
	Issuer "Savvis Communications Root CA" (not verified))
	by ozlabs.org (Postfix) with ESMTPS id 0429DDDED1
	for <linuxppc-dev@ozlabs.org>; Sat,  8 Nov 2008 02:12:53 +1100 (EST)
Received: from int-nj2ut-7.online-age.net (int-nj2ut-7.online-age.net
	[3.159.237.76])
	by ext-nj2ut-13.online-age.net (8.13.6/8.13.6/20051114-SVVS-TLS-DNSBL)
	with ESMTP id mA7FClTk005297
	for <linuxppc-dev@ozlabs.org>; Fri, 7 Nov 2008 10:12:48 -0500
Received: from alpmlip01.e2k.ad.ge.com (int-nj2ut-7.online-age.net
	[3.159.237.76])
	by int-nj2ut-7.online-age.net (8.13.6/8.13.6/20050510-SVVS) with ESMTP
	id mA7FClfP032238
	for <linuxppc-dev@ozlabs.org>; Fri, 7 Nov 2008 10:12:47 -0500
Date: Fri, 7 Nov 2008 15:13:16 +0000
From: Martyn Welch <martyn.welch@gefanuc.com>
To: Kumar Gala <galak@kernel.crashing.org>
Subject: Re: [PATCH] powerpc/86xx: Correct SOC bus-frequency in GE Fanuc
	SBC610 DTS
Message-Id: <20081107151316.90e05968.martyn.welch@gefanuc.com>
In-Reply-To: <01A072FA-4E81-4C96-96F8-0BF2BE2977C9@kernel.crashing.org>
References: <20081107134343.7844.77855.stgit@ubuntu8041.localdomain>
	<01A072FA-4E81-4C96-96F8-0BF2BE2977C9@kernel.crashing.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: linuxppc-dev@ozlabs.org, paulus@samba.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Fri, 7 Nov 2008 08:45:11 -0600
Kumar Gala <galak@kernel.crashing.org> wrote:
> 
> On Nov 7, 2008, at 7:43 AM, Martyn Welch wrote:
> 
> > This patch corrects the bus-frequency value provided in the SBC610's  
> > dts.
> >
> > Signed-off-by: Martyn Welch <martyn.welch@gefanuc.com>
> > ---
> >
> > arch/powerpc/boot/dts/gef_sbc610.dts |    2 +-
> > 1 files changed, 1 insertions(+), 1 deletions(-)
> >
> > diff --git a/arch/powerpc/boot/dts/gef_sbc610.dts b/arch/powerpc/ 
> > boot/dts/gef_sbc610.dts
> > index fd2b606..1f7833c 100644
> > --- a/arch/powerpc/boot/dts/gef_sbc610.dts
> > +++ b/arch/powerpc/boot/dts/gef_sbc610.dts
> > @@ -114,7 +114,7 @@
> > 		compatible = "simple-bus";
> > 		ranges = <0x0 0xfef00000 0x00100000>;
> > 		reg = <0xfef00000 0x100000>;	// CCSRBAR 1M
> > -		bus-frequency = <0>;
> > +		bus-frequency = <33333333>;
> >
> > 		i2c1: i2c@3000 {
> > 			#address-cells = <1>;
> 
> are we not fixing this up in u-boot?
> 

The SBC610 has uboot 1.2.0, which doesn't seem to be changing this.

> - k


-- 
Martyn Welch MEng MPhil MIET (Principal Software Engineer)   T:+44(0)1327322748
GE Fanuc Intelligent Platforms Ltd,        |Registered in England and Wales
Tove Valley Business Park, Towcester,      |(3828642) at 100 Barbirolli Square,
Northants, NN12 6PF, UK T:+44(0)1327359444 |Manchester,M2 3AB  VAT:GB 729849476
