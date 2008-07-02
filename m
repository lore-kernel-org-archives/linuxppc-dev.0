Return-Path: <lg@opensource.wolfsonmicro.com>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id A5BD4DE505
	for <linuxppc-dev@ozlabs.org>; Thu,  3 Jul 2008 02:06:30 +1000 (EST)
Subject: Re: [alsa-devel] [PATCH 1/3] ALSA SoC: Add OpenFirmware helper for
	matching bus and codec drivers
From: Liam Girdwood <lg@opensource.wolfsonmicro.com>
To: Grant Likely <grant.likely@secretlab.ca>
In-Reply-To: <20080702154804.GA23011@secretlab.ca>
References: <20080701235330.16923.67218.stgit@trillian.secretlab.ca>
	<s5hiqvod37w.wl%tiwai@suse.de>  <20080702154804.GA23011@secretlab.ca>
Content-Type: text/plain
Date: Wed, 02 Jul 2008 16:57:52 +0100
Message-Id: <1215014272.4882.91.camel@localhost.localdomain>
Mime-Version: 1.0
Cc: Takashi Iwai <tiwai@suse.de>, linuxppc-dev@ozlabs.org,
	alsa-devel@alsa-project.org, broonie@opensource.wolfsonmicro.com,
	timur@freescale.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Wed, 2008-07-02 at 09:48 -0600, Grant Likely wrote:
> On Wed, Jul 02, 2008 at 11:50:43AM +0200, Takashi Iwai wrote:
> > 
> > This is a helper module and not necessarily manually selectable.
> > Better to make the other driver selecting this.
> 
> Yes, you're right.  I hadn't put too much thought into the Kconfig stuff
> for this patch because, at the moment, I'm viewing this as a temporary
> solution until ASoCv2 is merged.
> 
> Which raises another question: Liam and Mark, what is your opinion on
> merging this driver?  Is it something that you would merge with the v1
> API and then rework it when v2 is merged?  Or would you rather it be
> kept out until v2 is ready?  I haven't even looked at the v2 API yet, so
> I don't know how much rework is involved.
> 

I'm happy with this atm for v1. We can then rework for V2.

Liam
