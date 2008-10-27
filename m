Return-Path: <neko@genesi-usa.com>
Received: from qw-out-2122.google.com (qw-out-2122.google.com [74.125.92.24])
	by ozlabs.org (Postfix) with ESMTP id 1DB15DDDDB
	for <linuxppc-dev@ozlabs.org>; Tue, 28 Oct 2008 04:49:29 +1100 (EST)
Received: by qw-out-2122.google.com with SMTP id 9so1687294qwb.15
	for <linuxppc-dev@ozlabs.org>; Mon, 27 Oct 2008 10:49:28 -0700 (PDT)
Message-ID: <4905FF2B.10007@genesi-usa.com>
Date: Mon, 27 Oct 2008 12:49:31 -0500
From: Matt Sealey <matt@genesi-usa.com>
MIME-Version: 1.0
To: Scott Wood <scottwood@freescale.com>
Subject: Re: GPIO - marking individual pins (not) available in device tree
References: <4900ED81.3040202@genesi-usa.com>
	<4900F90B.80703@firmworks.com>	<4901032F.3090805@genesi-usa.com>
	<49011C42.2020101@firmworks.com>	<49024646.3050300@genesi-usa.com>
	<49025DE0.6070403@firmworks.com>	<4904DD76.7070706@genesi-usa.com>	<20081026235303.GE22339@yookeroo.seuss>
	<4905E857.6040206@genesi-usa.com> <4905EDBE.8020105@freescale.com>
	<4905F4C4.4000309@genesi-usa.com> <4905F97B.60705@freescale.com>
In-Reply-To: <4905F97B.60705@freescale.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Sender: Matt Sealey <neko@genesi-usa.com>
Cc: Mitch Bradley <wmb@firmworks.com>,
	linuxppc-dev list <linuxppc-dev@ozlabs.org>,
	devicetree-discuss list <devicetree-discuss@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Scott Wood wrote:
>
>> They did always work. The real sore points here are device bindings and a
>> grand total of nothing changed between OF and now with that.
>>
>> The assertion in ePAPR that device_type is deprecated and ignored 
>> because ePAPR doesn't support FCode is naive at best.
> 
> It's deprecated *in the context of flat device trees*.  Anything not 
> using flat device trees is out-of-scope with respect to ePAPR.

Isn't the beauty of a device tree that every firmware no matter what
type can present it in whatever form it chooses, but still be describing
the same hardware in the same way?

Designing a tree for OF and one for U-Boot should be an absolutely
identical process, internal firmware methodologies notwithstanding
be it pure Forth in Firmworks, C API in Codegen, or output of dtc
for U-Boot, the exact same tree should be output, device_type and
all, within reason. I don't think "it's not real Open Firmware" is
a valid reason. Not as valid as "our firmware doesn't support this
hardware yet so we can't probe or initialize, only describe the bus",
for example (USB on Efika is filled out, USB on U-Boot for Lite5200B
is not).

I'm curious, is it the remit of the ePAPR TSC to publish and act as
a registration authority for device tree bindings for specific SoCs
or is that devolved to the SoC maker itself (be they a member of
Power.org or not) and, more prudent, two other questions; where are
Freescale and IBM publishing these if it is their responsibility,
are things like the mysterious i2c binding going to be published
under this TSC?

-- 
Matt Sealey <matt@genesi-usa.com>
Genesi, Manager, Developer Relations
