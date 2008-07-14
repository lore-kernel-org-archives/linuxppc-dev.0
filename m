Return-Path: <glikely@secretlab.ca>
Received: from an-out-0708.google.com (an-out-0708.google.com [209.85.132.243])
	by ozlabs.org (Postfix) with ESMTP id 767E0DDF13
	for <linuxppc-dev@ozlabs.org>; Tue, 15 Jul 2008 03:11:29 +1000 (EST)
Received: by an-out-0708.google.com with SMTP id c34so1380004anc.78
	for <linuxppc-dev@ozlabs.org>; Mon, 14 Jul 2008 10:11:27 -0700 (PDT)
Message-ID: <fa686aa40807141011s1b2efff5vdc1d0bd04e42c953@mail.gmail.com>
Date: Mon, 14 Jul 2008 11:11:25 -0600
From: "Grant Likely" <grant.likely@secretlab.ca>
Sender: glikely@secretlab.ca
To: avorontsov@ru.mvista.com
Subject: Re: [PATCH v2 1/3] ALSA SoC: Add OpenFirmware helper for matching bus
	and codec drivers
In-Reply-To: <20080714141606.GA22478@polina.dev.rtsoft.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
References: <20080712083929.15025.47682.stgit@trillian.secretlab.ca>
	<20080714141606.GA22478@polina.dev.rtsoft.ru>
Cc: linuxppc-dev@ozlabs.org, alsa-devel@alsa-project.org,
	liam.girdwood@wolfsonmicro.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Mon, Jul 14, 2008 at 8:16 AM, Anton Vorontsov
<avorontsov@ru.mvista.com> wrote:
> On Sat, Jul 12, 2008 at 02:39:29AM -0600, Grant Likely wrote:
>> --- /dev/null
>> +++ b/sound/soc/soc-of.c
>
> It's quite inconvenient to spread the firmware-specific bits over the
> whole kernel source tree. So, can we place this in driver/of/, just as
> we did for i2c, spi and gpio?

This isn't any more specific than say how device drivers are specific
for particular devices.  This is an ASoC machine driver and should
live with all the other ASoC machine drivers.

g.

-- 
Grant Likely, B.Sc., P.Eng.
Secret Lab Technologies Ltd.
