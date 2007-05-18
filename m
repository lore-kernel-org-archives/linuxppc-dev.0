Return-Path: <jdl@freescale.com>
Received: from de01egw02.freescale.net (de01egw02.freescale.net
	[192.88.165.103])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "de01egw02.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 8773EDDF2C
	for <linuxppc-dev@ozlabs.org>; Sat, 19 May 2007 02:45:06 +1000 (EST)
Subject: Re: [PATCH 2/5] Add legacy devices to mpc8641_hpcn.dts
From: Jon Loeliger <jdl@freescale.com>
To: Segher Boessenkool <segher@kernel.crashing.org>
In-Reply-To: <0c3907573f12a0731d03335fe3334363@kernel.crashing.org>
References: <1179245829.8132.100.camel@rhino> <1179246470.8132.112.camel@rhino>
	<1179333421.7018.17.camel@ld0161-tx32>
	<b77c4b3dd22795a73cd32a0623722e51@kernel.crashing.org>
	<1179346653.8132.223.camel@rhino>
	<0c3907573f12a0731d03335fe3334363@kernel.crashing.org>
Content-Type: text/plain
Message-Id: <1179506692.19188.2.camel@ld0161-tx32>
Mime-Version: 1.0
Date: Fri, 18 May 2007 11:44:52 -0500
Cc: linuxppc-dev <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Wed, 2007-05-16 at 18:40, Segher Boessenkool wrote:

> > Is there a recommended "compatible" property for a standard PC-like 
> > CMOS
> > RTC?
> 
> None in the bindings that I know of.  It typically would
> be the model name/number of the oldest chip used, or one
> that is very commonly used.

And I haven't actually gotten it to work yet either...
Am I missing something?  Like a CONFIG_ option beyond
the RTC and CMOS variant that is necessary?

Dumbly,
jdl
