Return-Path: <benh@kernel.crashing.org>
Subject: Re: [PATCH 1/2] Add MPC52xx Interrupt controller support
	for	ARCH=powerpc
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Nicolas DET <nd@bplan-gmbh.de>
In-Reply-To: <4547086D.2050808@bplan-gmbh.de>
References: <200610292310.k9TNAHXZ013852@post.webmailer.de>
	<7BDB728E-0CC2-4940-9856-B496022F3482@kernel.crashing.org>
	<4546F7DE.6070104@bplan-gmbh.de>
	<1162280335.25682.302.camel@localhost.localdomain>
	<4547086D.2050808@bplan-gmbh.de>
Content-Type: text/plain
Date: Tue, 31 Oct 2006 19:42:55 +1100
Message-Id: <1162284176.25682.320.camel@localhost.localdomain>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org, sl@bplan-gmbh.de, sha@pengutronix.de,
	linuxppc-embedded@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Tue, 2006-10-31 at 09:25 +0100, Nicolas DET wrote:

> Ok. By the way, the mbar is include as property in our OpenFrimware. 
> Moreover, the G2CORE CPU has a new SPR 'MBAR' which is the MBAR ;-). It 
> would maybe make sense to create a new file 
> (arch/powerpc/sysdev/mpc52xx.c) which would contain chip specific code.
> 
> Like mpc52xx_get_mbar(), mpc52xx_get_ipbfreq(), etc...
> 
> I updated a bit the patches. I applied Dale requests.
> My kernel still compiles and boots. ;-)
> 
> Should I post the new patches?

Sure.

> About the headers thingy. Should I split them directly in the patch, or 
> this should be done by others later on?

Don't bother that much about splitting the headers. I personally don't
mind.

> About the serials and USB part. Have anyone already do some work (moving 
> to of_platform, etc...)?

I think Grant has.

> As far as I see, the Efika platform patch did not get any comment, 
> should I assume it is good enough for inclusion in the main stream kernel?

It looked ok at a very very quick glance. I'll give a better look.

Ben.
