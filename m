Return-Path: <timur.tabi@gmail.com>
Received: from qw-out-2122.google.com (qw-out-2122.google.com [74.125.92.25])
	by ozlabs.org (Postfix) with ESMTP id A46ABDDD0B
	for <linuxppc-dev@ozlabs.org>; Mon,  6 Apr 2009 05:25:15 +1000 (EST)
Received: by qw-out-2122.google.com with SMTP id 9so1245613qwb.15
	for <linuxppc-dev@ozlabs.org>; Sun, 05 Apr 2009 12:25:13 -0700 (PDT)
MIME-Version: 1.0
Sender: timur.tabi@gmail.com
In-Reply-To: <85829FCA-D181-4992-9889-640B3329D023@kernel.crashing.org>
References: <20090404183319.GA22203@oksana.dev.rtsoft.ru>
	<fa686aa40904042259h4c69e632x47a9e82393e8faef@mail.gmail.com>
	<20090405085243.GA16005@oksana.dev.rtsoft.ru>
	<fa686aa40904050739g219a9143v7bbc8cd673e52f4e@mail.gmail.com>
	<85829FCA-D181-4992-9889-640B3329D023@kernel.crashing.org>
Date: Sun, 5 Apr 2009 14:18:20 -0500
Message-ID: <ed82fe3e0904051218i60edfe42o879ee5f7063a2e4c@mail.gmail.com>
Subject: Re: [PATCH] ASoC: fsl_dma: Pass the proper device for dma mapping
	routines
From: Timur Tabi <timur@freescale.com>
To: Kumar Gala <galak@kernel.crashing.org>
Content-Type: text/plain; charset=ISO-8859-1
Cc: Becky Bruce <Becky.Bruce@freescale.com>, alsa-devel@alsa-project.org,
	Mark Brown <broonie@opensource.wolfsonmicro.com>,
	linuxppc-dev@ozlabs.org, Liam Girdwood <lrg@slimlogic.co.uk>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Sun, Apr 5, 2009 at 9:59 AM, Kumar Gala <galak@kernel.crashing.org> wrot=
e:

> No, I think we should just fix drivers. =A0There aren't that many SoC dri=
vers
> and once they are fixed this will resolve itself.

I agree.  The only reason I passed NULL when I wrote the drivers was
because I was too lazy to figure out what the right dev pointer was.
ASoC is kinda screwy in that many fields are not initialized when you
think they should be.  More than once I passed a pointer to a wrong
object without realizing it, even though the code worked.

I'll check out these two patches on Monday.

--=20
Timur Tabi
Linux kernel developer at Freescale
