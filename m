Return-Path: <laurent.pinchart@technotrade.biz>
Received: from outmx015.isp.belgacom.be (outmx015.isp.belgacom.be
	[195.238.4.87])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 6EEE3DDEC4
	for <linuxppc-embedded@ozlabs.org>;
	Wed, 24 Jan 2007 22:06:31 +1100 (EST)
Received: from outmx015.isp.belgacom.be (localhost [127.0.0.1])
	by outmx015.isp.belgacom.be (8.12.11.20060308/8.12.11/Skynet-OUT-2.22)
	with ESMTP id l0OB6PME019578
	for <linuxppc-embedded@ozlabs.org>; Wed, 24 Jan 2007 12:06:25 +0100
	(envelope-from <laurent.pinchart@technotrade.biz>)
From: Laurent Pinchart <laurent.pinchart@technotrade.biz>
To: Eugene Surovegin <ebs@ebshome.net>
Subject: Re: JTAG emulator for MPC8548E (v2)
Date: Wed, 24 Jan 2007 12:06:17 +0100
References: <BD261180E6D35F4D9D32F3E44FD3D901062D1E42@EMPBEDEX.empirix.com>
	<200701240857.19428.laurent.pinchart@technotrade.biz>
	<20070124103548.GA31703@gate.ebshome.net>
In-Reply-To: <20070124103548.GA31703@gate.ebshome.net>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200701241206.18167.laurent.pinchart@technotrade.biz>
Cc: "Morrison, Tom" <tmorrison@empirix.com>, linuxppc-embedded@ozlabs.org
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Hi Eugene,

> > The new unit works *mostly* fine. No debugging issue (not that I use it
> > that much anyway, now that the board boots Linux), but still a flash
> > programming issue. Programming the target parallel NOR flash works in
> > slow JTAG mode, but not in faster mode using the internal workspace. I
> > reported the problem several months ago and still haven't received any
> > solution.
>
> Most likely problem isn't in BDI but in your setup. Depending on
> the particular chip model, to be able use workspace you must have
> initialized memory first. In fact, I'm pretty sure you haven't
> configured chip correctly to make workspace usable. I've been using
> BDI with various PowerPC and MIPS SoCs for many years. It's an excellent
> tool, you just have to use it correctly.

I wish it was that simple. It is probably a target processor configuration 
issue, as I can use the workspace if

a) the target flash has already been programmed with U-Boot
b) the BDI-2000 is misconfigured and fails to stop the target processor at 
startup.

I can thus use the workspace when U-Boot initializes the processor.

I had a look at U-Boot code and tried to initialize the processor registers 
with the same values, without luck. I asked Abatron's French distributor for 
technical support, and they haven't been able to help me. They made me try 
lots of different initialization sequences. Several people online sent me 
their configuration file, and none of them worked for me.

So, there must be a configuration problem somewhere, but even Abatron's 
technical support haven't been able to find it. That's why I complained about 
their support in my e-mail.

Best regards,

Laurent Pinchart
