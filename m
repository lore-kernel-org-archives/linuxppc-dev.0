Return-Path: <glikely@secretlab.ca>
Received: from an-out-0708.google.com (an-out-0708.google.com [209.85.132.241])
	by ozlabs.org (Postfix) with ESMTP id 5F76FDE109
	for <linuxppc-dev@ozlabs.org>; Mon,  9 Jun 2008 23:57:02 +1000 (EST)
Received: by an-out-0708.google.com with SMTP id c34so432258anc.78
	for <linuxppc-dev@ozlabs.org>; Mon, 09 Jun 2008 06:57:00 -0700 (PDT)
Message-ID: <fa686aa40806090657x37ff8432j21f6db2c0fce08b9@mail.gmail.com>
Date: Mon, 9 Jun 2008 07:57:00 -0600
From: "Grant Likely" <grant.likely@secretlab.ca>
Sender: glikely@secretlab.ca
To: "Juergen Beisert" <jbe@pengutronix.de>
Subject: Re: Comments on device tree for pcm030
In-Reply-To: <200806090956.32160.jbe@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
References: <9e4733910806081208r1a8d0987j6eab0d73bc446640@mail.gmail.com>
	<fa686aa40806081628s2632bcb3he21b26e49873a65f@mail.gmail.com>
	<200806090956.32160.jbe@pengutronix.de>
Cc: linuxppc-dev@ozlabs.org, wsa@pengutronix.de
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Mon, Jun 9, 2008 at 1:56 AM, Juergen Beisert <jbe@pengutronix.de> wrote:
> On Monday 09 June 2008 01:28, Grant Likely wrote:
>> On Sun, Jun 8, 2008 at 1:08 PM, Jon Smirl <jonsmirl@gmail.com> wrote:
>> > Device tree has an entry for AC97 on PSC1. I don't think the Phytec
>> > module or carrier board has AC97 hardware.
>>
>> Might be a bug
>
> NACK. The baseboard for the pcm030 CPU board has AC97 hardware connected to
> PSC1. And it plays audio...

Okay, I didn't know.

>> > The RTC chip says pcf8563, phytec doc says it is a pcf8564.
>>
>> Sounds like a bug
>
> These devices are mostly the same. You can use the pcf8563 driver for the
> pcf8564.

Then compatible should be something 'compatible = "nxp,pcf8564", "nxp,pcf8563";'

Cheers,
g.

-- 
Grant Likely, B.Sc., P.Eng.
Secret Lab Technologies Ltd.
