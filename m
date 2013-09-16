Return-Path: <B07421@freescale.com>
Received: from co9outboundpool.messaging.microsoft.com
 (co9ehsobe003.messaging.microsoft.com [207.46.163.26])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "MSIT Machine Auth CA 2" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 952512C00E8
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 17 Sep 2013 08:46:43 +1000 (EST)
Message-ID: <1379371590.2536.187.camel@snotra.buserror.net>
Subject: Re: [PATCH v9 2/3] DMA: Freescale: Add new 8-channel DMA engine
 device tree nodes
From: Scott Wood <scottwood@freescale.com>
To: Mark Rutland <mark.rutland@arm.com>
Date: Mon, 16 Sep 2013 17:46:30 -0500
In-Reply-To: <20130912171541.GH22013@e106331-lin.cambridge.arm.com>
References: <1377861980-7027-1-git-send-email-hongbo.zhang@freescale.com>
 <1377861980-7027-3-git-send-email-hongbo.zhang@freescale.com>
 <20130902155636.GA18206@e106331-lin.cambridge.arm.com>
 <5225A57E.4030003@freescale.com>
 <20130912171541.GH22013@e106331-lin.cambridge.arm.com>
Content-Type: text/plain; charset="UTF-8"
MIME-Version: 1.0
Cc: "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
 "ian.campbell@citrix.com" <ian.campbell@citrix.com>,
 Pawel Moll <Pawel.Moll@arm.com>,
 "swarren@wwwdotorg.org" <swarren@wwwdotorg.org>,
 Hongbo Zhang <hongbo.zhang@freescale.com>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "rob.herring@calxeda.com" <rob.herring@calxeda.com>,
 "vinod.koul@intel.com" <vinod.koul@intel.com>, "djbw@fb.com" <djbw@fb.com>,
 "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, 2013-09-12 at 18:15 +0100, Mark Rutland wrote:
> On Tue, Sep 03, 2013 at 10:01:50AM +0100, Hongbo Zhang wrote:
> > On 09/02/2013 11:58 PM, Mark Rutland wrote:
> > > May some channels be unusable for some reason, or will all eight
> > > channels be wired on any given Elo3 DMA?
> > Sorry, not get your point clearly, maybe you are clear now because of my
> > previous explanations.
> 
> I assume that on any El03 DMA, there won't be a case where you can't
> describe the channel at 0x80, for instance. It will always be present
> (but it might not be wired up to anything any therefore be useful)?
> 
> This was related to my concerns about the status register description --
> if the channels at 0x0,0x80,0x100,0x180 weren't wired, what would get
> described in the dt? I guess that would never actually happen because
> all 8 channels must always be present in the Elo3 IP block.

If a channel is not usable for whatever reason (other than that "used
for a different fixed purpose and thus described with a different
compatible" thing that was mentioned earlier in these threads), wouldn't
it just have status = "disabled" or similar, or be absent?

-Scott
