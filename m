Return-Path: <jdl@freescale.com>
Received: from de01egw02.freescale.net (de01egw02.freescale.net
	[192.88.165.103])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "de01egw02.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id EE8F6DDE22
	for <linuxppc-dev@ozlabs.org>; Tue, 22 May 2007 02:11:14 +1000 (EST)
Subject: Re: [PATCH 2/5] Add legacy devices to mpc8641_hpcn.dts
From: Jon Loeliger <jdl@freescale.com>
To: Wade Farnsworth <wfarnsworth@mvista.com>
In-Reply-To: <1179763484.8132.293.camel@rhino>
References: <1179245829.8132.100.camel@rhino> <1179246470.8132.112.camel@rhino>
	<1179333421.7018.17.camel@ld0161-tx32>
	<b77c4b3dd22795a73cd32a0623722e51@kernel.crashing.org>
	<1179346653.8132.223.camel@rhino>
	<0c3907573f12a0731d03335fe3334363@kernel.crashing.org>
	<1179506692.19188.2.camel@ld0161-tx32>
	<1179763484.8132.293.camel@rhino>
Content-Type: text/plain
Message-Id: <1179763854.13019.8.camel@ld0161-tx32>
Mime-Version: 1.0
Date: Mon, 21 May 2007 11:10:54 -0500
Cc: linuxppc-dev <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Mon, 2007-05-21 at 11:04, Wade Farnsworth wrote:

> I wonder if you're running into the locked RTC problem on the m1575.
> The version of u-boot that I'm using (recent pull from
> opensource.freescale.com)

Which repository?  I ask because it is highly likely that
I placed it there...

>  has a workaround for that.  Can you verify if
> this is the problem?

Can you point to "the workaround" to which you refer?

> For the benefit of those who aren't aware of the problem, the RTC on the
> m1575 is locked on boot until PCI memory space is read.

Hmmm.  I'm pretty sure this is being done already.

> Maybe we should put the workaround in the kernel instead.  Any opinions?

How are you getting it to work now as it is, then?

jdl
