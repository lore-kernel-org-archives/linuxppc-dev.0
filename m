Return-Path: <glikely@secretlab.ca>
Received: from ag-out-0708.google.com (ag-out-0708.google.com [72.14.246.251])
	by ozlabs.org (Postfix) with ESMTP id 92C1DDDEEA
	for <linuxppc-dev@ozlabs.org>; Sat,  5 Jul 2008 09:44:10 +1000 (EST)
Received: by ag-out-0708.google.com with SMTP id 8so8326679agc.0
	for <linuxppc-dev@ozlabs.org>; Fri, 04 Jul 2008 16:44:09 -0700 (PDT)
Message-ID: <fa686aa40807041644r2a71181q2bc522ec988820ab@mail.gmail.com>
Date: Fri, 4 Jul 2008 17:44:09 -0600
From: "Grant Likely" <grant.likely@secretlab.ca>
Sender: glikely@secretlab.ca
To: "Grant Likely" <grant.likely@secretlab.ca>, liam.girdwood@wolfsonmicro.com,
	alsa-devel@alsa-project.org, linuxppc-dev@ozlabs.org, timur@freescale.com
Subject: Re: [alsa-devel] [PATCH 3/3] ALSA SoC: Add Texas Instruments
	TLV320AIC26 codec driver
In-Reply-To: <20080704204927.GC20719@sirena.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
References: <20080701235330.16923.67218.stgit@trillian.secretlab.ca>
	<20080701235340.16923.48024.stgit@trillian.secretlab.ca>
	<20080704204927.GC20719@sirena.org.uk>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Fri, Jul 4, 2008 at 2:49 PM, Mark Brown
<broonie@opensource.wolfsonmicro.com> wrote:
> On Tue, Jul 01, 2008 at 05:53:40PM -0600, Grant Likely wrote:
>> +     /* Tell the of_soc helper about this codec */
>> +     of_snd_soc_register_codec(&aic26_soc_codec_dev, aic26, &aic26_dai,
>> +                               spi->dev.archdata.of_node);
>
> Does this need to be ifdefed out if of_snd_soc_register_codec() is not
> in use or is the function stubbed out if it's not in use?  Stubbing it
> out would be cleaner.

yeah, probably.  This is a stop-gap measure anyway until ASoC v2 is merged.

g.

-- 
Grant Likely, B.Sc., P.Eng.
Secret Lab Technologies Ltd.
