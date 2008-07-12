Return-Path: <glikely@secretlab.ca>
Received: from an-out-0708.google.com (an-out-0708.google.com [209.85.132.242])
	by ozlabs.org (Postfix) with ESMTP id 20845DDE22
	for <linuxppc-dev@ozlabs.org>; Sun, 13 Jul 2008 04:13:53 +1000 (EST)
Received: by an-out-0708.google.com with SMTP id c34so1294221anc.78
	for <linuxppc-dev@ozlabs.org>; Sat, 12 Jul 2008 11:13:51 -0700 (PDT)
Message-ID: <fa686aa40807121113t3e713737v2fab74b066e1a73e@mail.gmail.com>
Date: Sat, 12 Jul 2008 12:13:51 -0600
From: "Grant Likely" <grant.likely@secretlab.ca>
Sender: glikely@secretlab.ca
To: "Grant Likely" <grant.likely@secretlab.ca>,
	"Liam Girdwood" <liam.girdwood@wolfsonmicro.com>,
	linuxppc-dev@ozlabs.org, alsa-devel@alsa-project.org, timur@freescale.com
Subject: Re: [alsa-devel] [PATCH 3/3] ALSA SoC: Add Texas Instruments
	TLV320AIC26 codec driver
In-Reply-To: <20080712173609.GA6523@sirena.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
References: <20080701235330.16923.67218.stgit@trillian.secretlab.ca>
	<20080701235340.16923.48024.stgit@trillian.secretlab.ca>
	<1214995713.4882.54.camel@localhost.localdomain>
	<20080712060018.GB23213@secretlab.ca>
	<20080712173609.GA6523@sirena.org.uk>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Sat, Jul 12, 2008 at 11:36 AM, Mark Brown
<broonie@opensource.wolfsonmicro.com> wrote:
> The power configuration should be fixed, though.  Normally drivers
> either fully implement DAPM (including set_bias_level()) or power
> everything in the codec up when the driver is loaded.  At the minute
> what the driver is doing appears to be powering the codec up in both
> _hw_params() and _probe() but never powering anything down - if that is
> the case then probably all you need to do is remove the extra power up
> from hw_params(), giving you the simple option.

Okay, cool.  I'll do this for the time being then.

Thanks,
g.

-- 
Grant Likely, B.Sc., P.Eng.
Secret Lab Technologies Ltd.
