Return-Path: <guangyu.chen@freescale.com>
Received: from co9outboundpool.messaging.microsoft.com
 (co9ehsobe003.messaging.microsoft.com [207.46.163.26])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "MSIT Machine Auth CA 2" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id F38D92C007E
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 15 Nov 2013 14:23:00 +1100 (EST)
Date: Fri, 15 Nov 2013 11:15:37 +0800
From: Nicolin Chen <b42378@freescale.com>
To: Shawn Guo <shawn.guo@linaro.org>
Subject: Re: [PATCH 0/2] Add monaural audio support for fsl_ssi.c
Message-ID: <20131115031536.GB745@MrMyself>
References: <1384427230-979-1-git-send-email-b42378@freescale.com>
 <20131115030247.GC11014@S2101-09.ap.freescale.net>
 <20131115025956.GA745@MrMyself>
 <20131115032250.GD11014@S2101-09.ap.freescale.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
In-Reply-To: <20131115032250.GD11014@S2101-09.ap.freescale.net>
Cc: mark.rutland@arm.com, devicetree@vger.kernel.org,
 alsa-devel@alsa-project.org, linux@arm.linux.org.uk, pawel.moll@arm.com,
 ijc+devicetree@hellion.org.uk, lgirdwood@gmail.com, swarren@wwwdotorg.org,
 timur@tabi.org, rob.herring@calxeda.com, linux-kernel@vger.kernel.org,
 broonie@kernel.org, linuxppc-dev@lists.ozlabs.org,
 linux-arm-kernel@lists.infradead.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, Nov 15, 2013 at 11:22:52AM +0800, Shawn Guo wrote:
> On Fri, Nov 15, 2013 at 10:59:57AM +0800, Nicolin Chen wrote:
> > Hi Shawn,
> >    
> > On Fri, Nov 15, 2013 at 11:02:49AM +0800, Shawn Guo wrote:
> > > On Thu, Nov 14, 2013 at 07:07:08PM +0800, Nicolin Chen wrote:
> > > > This series of patches need to be applied into one single tree because
> > > > the second patch depends on the first one. Without it, SSI would playback
> > > > constant noise to the right channel when playback monaural audio files on
> > > > i.MX6 Series board.
> > > 
> > > Let me try to understand if the dependency is true.
> > > 
> > > Saying I apply the DTS patch on IMX tree while Mark apply the fsl_ssi
> > > patch on his tree, will there be any regression on either IMX tree or
> > > Mark's tree?  The monaural playback on imx6qdl never worked, so it's not
> > > a regression.  If there is no regression on either tree, there is no
> > > dependency to maintain.
> > 
> > It's fair enough to understand in this way. It looks like I misunderstood
> > the dependency here.
> > 
> > Do I need to resend them separately?
> 
> No, I will just pick up the DTS patch with some testing.
> 
> Shawn

Thank you.
Nicolin Chen
