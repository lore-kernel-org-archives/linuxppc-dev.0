Return-Path: <broonie@opensource.wolfsonmicro.com>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
 [80.75.67.52])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id 426C52C0084
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 13 Sep 2012 14:27:51 +1000 (EST)
Date: Thu, 13 Sep 2012 12:27:39 +0800
From: Mark Brown <broonie@opensource.wolfsonmicro.com>
To: Eric Millbrandt <emillbrandt@dekaresearch.com>
Subject: Re: [PATCH 5/5] ASoC: fsl: mpc5200 remove pcm030 and efika audio
 fabric
Message-ID: <20120913042737.GC6732@opensource.wolfsonmicro.com>
References: <1347416089-23393-1-git-send-email-emillbrandt@dekaresearch.com>
 <1347416089-23393-6-git-send-email-emillbrandt@dekaresearch.com>
 <20120912032026.GI9162@opensource.wolfsonmicro.com>
 <0A40042D85E7C84DB443060EC44B3FD336D854FEE2@dekaexchange07.deka.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <0A40042D85E7C84DB443060EC44B3FD336D854FEE2@dekaexchange07.deka.local>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>,
 Anatolij Gustschin <agust@denx.de>,
 "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
 Liam Girdwood <lrg@ti.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, Sep 12, 2012 at 10:05:33AM -0400, Eric Millbrandt wrote:

Please fix your mailer to word wrap within paragraphs.

> On 2012-09-11 Mark Brown wrote:

> > I only noticed DT bindings being added for pcm030, not for efika?

> When I looked I didn't see the Efika (PPC 5200B) DT in-tree.  It only
> appears to exist out-of-tree,

Hrm, well - that's not terribly clever.  It'll mean a regression on
existing systems and since they're clearly taking advantage of the
ability to distribute the device tree separately...  we'd really want
some sort of backwards compatibility to avoid breaking upgrades.  Not
sure what the normal way of doing that is.
