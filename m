Return-Path: <jonsmirl@gmail.com>
Received: from mail-qy0-f196.google.com (mail-qy0-f196.google.com
	[209.85.221.196]) by ozlabs.org (Postfix) with ESMTP id AA3A2DE0D6
	for <linuxppc-dev@ozlabs.org>; Mon, 25 May 2009 01:32:51 +1000 (EST)
Received: by qyk34 with SMTP id 34so4746338qyk.17
	for <linuxppc-dev@ozlabs.org>; Sun, 24 May 2009 08:32:48 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <9e4733910905240828q4b4cfd96xe840f3ae983143dc@mail.gmail.com>
References: <20090523231148.17919.46103.stgit@terra>
	<20090523231257.17919.4483.stgit@terra>
	<20090524111118.GC4933@sirena.org.uk>
	<9e4733910905240828q4b4cfd96xe840f3ae983143dc@mail.gmail.com>
Date: Sun, 24 May 2009 11:32:48 -0400
Message-ID: <9e4733910905240832pbcb78adh5e3708d010263f6c@mail.gmail.com>
Subject: Re: [alsa-devel] [PATCH V2 1/9] Register the wm9712 DAIs on module
	load
From: Jon Smirl <jonsmirl@gmail.com>
To: Mark Brown <broonie@opensource.wolfsonmicro.com>
Content-Type: text/plain; charset=ISO-8859-1
Cc: linuxppc-dev@ozlabs.org, alsa-devel@alsa-project.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Output with SOC DEBUG turned on:

Advanced Linux Sound Architecture Driver Version 1.0.19.
No device for DAI stac9766 analog
Registered DAI 'stac9766 analog'
No device for DAI stac9766 IEC958
Registered DAI 'stac9766 IEC958'
No device for DAI tas5504
Registered DAI 'tas5504'
Registered platform 'mpc5200-psc-audio'
irq: irq 129 on host /soc5200@f0000000/interrupt-controller@500 mapped
to virtual irq 129
irq: irq 194 on host /soc5200@f0000000/interrupt-controller@500 mapped
to virtual irq 194
irq: irq 195 on host /soc5200@f0000000/interrupt-controller@500 mapped
to virtual irq 195
Registered DAI 'AC97'
Registered DAI 'SPDIF'
mpc5200-psc-ac97 f0002000.ac97: Codec ID is 574d 4c12
soc-audio soc-audio.1: DAI AC97 HiFi not registered
soc-audio soc-audio.1: Registered card 'pcm030'
ALSA device list:
  No soundcards found.


-- 
Jon Smirl
jonsmirl@gmail.com
