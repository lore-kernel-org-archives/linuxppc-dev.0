Return-Path: <benh@kernel.crashing.org>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 84E081A0997
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  2 Oct 2014 08:08:53 +1000 (EST)
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id A84C614016B
 for <linuxppc-dev@ozlabs.org>; Thu,  2 Oct 2014 08:08:52 +1000 (EST)
Message-ID: <1412201282.4285.232.camel@pasglop>
Subject: Re: [PATCH 4/4] sounds/hda/radeon: Disable 64-bit DMA on radeon
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Alex Deucher <alexdeucher@gmail.com>
Date: Thu, 02 Oct 2014 08:08:02 +1000
In-Reply-To: <CADnq5_P1qTkedSuFfgJ=dd5cWji1-OUbmKoUyq+kLQgPGYYaQw@mail.gmail.com>
References: <1412129393.4285.195.camel@pasglop>
 <s5htx3o44tv.wl-tiwai@suse.de> <1412149289.4285.204.camel@pasglop>
 <s5hr3ys43ev.wl-tiwai@suse.de> <s5hoatw42f6.wl-tiwai@suse.de>
 <CADnq5_P1qTkedSuFfgJ=dd5cWji1-OUbmKoUyq+kLQgPGYYaQw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org, Takashi Iwai <tiwai@suse.de>,
 Linux PCI <linux-pci@vger.kernel.org>, Brian King <brking@linux.vnet.ibm.com>,
 Anton Blanchard <anton@au1.ibm.com>, Dave Airlie <airlied@linux.ie>,
 Yijing Wang <wangyijing@huawei.com>, Bjorn Helgaas <bhelgaas@google.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, 2014-10-01 at 13:58 -0400, Alex Deucher wrote:
> Patch looks good.  Audio DMAs are limited to 40 bits, same as the GPU
> side.  I'm still waiting to hear back on the MSIs for audio, but they
> probably follow the GPU side, so I expect they should be fixed on Sea
> Islands as well.

In the audio driver we don't have the "family names", just a list of
PCI IDs, do you happen to know which ones are unaffected ?

Cheers,
Ben.
