Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id C1CBFDE02A
	for <linuxppc-dev@ozlabs.org>; Fri, 21 Mar 2008 22:57:16 +1100 (EST)
Subject: Re: [PATCH] [POWERPC] Add AMCC Glacier 460GT eval board dts
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Segher Boessenkool <segher@kernel.crashing.org>
In-Reply-To: <011f73a2a2f33e075c20f0d0bb42d4a7@kernel.crashing.org>
References: <1205943310-26323-1-git-send-email-sr@denx.de>
	<1206090031.8420.67.camel@pasglop>
	<011f73a2a2f33e075c20f0d0bb42d4a7@kernel.crashing.org>
Content-Type: text/plain
Date: Fri, 21 Mar 2008 22:51:42 +1100
Message-Id: <1206100302.8420.71.camel@pasglop>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org, Stefan Roese <sr@denx.de>
Reply-To: benh@kernel.crashing.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On Fri, 2008-03-21 at 12:46 +0100, Segher Boessenkool wrote:
> > As for the DTS, maybe a "compatible" property in the CPU might make 
> > some
> > sense with a content along the lines of "ppc440x6" or whatever rev of
> > the 440 core it is.
> 
> Good idea, but please _also_ put the exact name in there, first; so
> something like
> 
> 	compatible = "AMCC,PowerPC,460GT", "AMCC,ppc440x6";
> 
> That way, you can still probe for specific versions where necessary.
> This is completely in line with the "generic naming" recommended
> practice; the PowerPC binding predates that RP, it really needs to
> be updated.
> 
> Any reason we keep the device_type here, btw?

BTW, Should we sort compatible from the most specific to the most
specific or the other way around ?

Ben.
