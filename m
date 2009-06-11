Return-Path: <ncase@xes-inc.com>
Received: from ozlabs.org (ozlabs.org [203.10.76.45])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.ozlabs.org",
	Issuer "CA Cert Signing Authority" (verified OK))
	by bilbo.ozlabs.org (Postfix) with ESMTPS id B9AF8B7158
	for <linuxppc-dev@lists.ozlabs.org>;
	Thu, 11 Jun 2009 10:35:30 +1000 (EST)
Received: from xes-mad.com (xes-mad.com [216.165.139.214])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 1AFFDDDD01
	for <linuxppc-dev@ozlabs.org>; Thu, 11 Jun 2009 10:35:29 +1000 (EST)
Subject: Re: [PATCH v2 -next] powerpc/85xx: Add support for X-ES MPC85xx boards
From: Nate Case <ncase@xes-inc.com>
To: Kumar Gala <galak@kernel.crashing.org>
In-Reply-To: <DF329655-9763-42EA-8170-645337949CF3@kernel.crashing.org>
References: <1244673039-1089-1-git-send-email-ncase@xes-inc.com>
	<DF329655-9763-42EA-8170-645337949CF3@kernel.crashing.org>
Content-Type: text/plain
Date: Wed, 10 Jun 2009 19:35:23 -0500
Message-Id: <1244680523.29684.1628.camel@localhost.localdomain>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, 2009-06-10 at 18:24 -0500, Kumar Gala wrote:
> > +	form-factor = "6U cPCI";
> > +	boot-bank = <0x0>;	/* 0: Primary flash, 1: Secondary flash */
> 
> I'm not a fan of taking device trees with properties that are  
> specified anywhere.

I can just delete them for now.  They're purely informational at this
point, but might be used in the future.

> > +	soc8572@ef000000 {
> > +		#address-cells = <1>;
> > +		#size-cells = <1>;
> > +		device_type = "soc";
> > +		compatible = "simple-bus";
> 
> should have a compat like:
> 
>                  compatible = "fsl,mpc8572-immr", "simple-bus";

Are you sure about this?  I only see "simple-bus" in the mpc8572ds.dts
files in mainline and your next branch -- so I was just following your
lead here.

I'll split up the patch as well.  It's not obvious where the 4-line boot
wrapper change should go, so I can make that one separate as well unless
you object.

-- 
Nate Case <ncase@xes-inc.com>
