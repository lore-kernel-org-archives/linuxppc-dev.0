Return-Path: <segher@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 78084DDF6C
	for <linuxppc-dev@ozlabs.org>; Fri, 21 Mar 2008 22:47:10 +1100 (EST)
In-Reply-To: <1206090031.8420.67.camel@pasglop>
References: <1205943310-26323-1-git-send-email-sr@denx.de>
	<1206090031.8420.67.camel@pasglop>
Mime-Version: 1.0 (Apple Message framework v623)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <011f73a2a2f33e075c20f0d0bb42d4a7@kernel.crashing.org>
From: Segher Boessenkool <segher@kernel.crashing.org>
Subject: Re: [PATCH] [POWERPC] Add AMCC Glacier 460GT eval board dts
Date: Fri, 21 Mar 2008 12:46:01 +0100
To: benh@kernel.crashing.org
Cc: linuxppc-dev@ozlabs.org, Stefan Roese <sr@denx.de>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

> As for the DTS, maybe a "compatible" property in the CPU might make 
> some
> sense with a content along the lines of "ppc440x6" or whatever rev of
> the 440 core it is.

Good idea, but please _also_ put the exact name in there, first; so
something like

	compatible = "AMCC,PowerPC,460GT", "AMCC,ppc440x6";

That way, you can still probe for specific versions where necessary.
This is completely in line with the "generic naming" recommended
practice; the PowerPC binding predates that RP, it really needs to
be updated.

Any reason we keep the device_type here, btw?


Segher
