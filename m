Return-Path: <guangyu.chen@freescale.com>
Received: from db8outboundpool.messaging.microsoft.com
 (mail-db8lp0187.outbound.messaging.microsoft.com [213.199.154.187])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "MSIT Machine Auth CA 2" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 724492C00CA
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  4 Dec 2013 21:50:07 +1100 (EST)
Date: Wed, 4 Dec 2013 18:33:07 +0800
From: Nicolin Chen <b42378@freescale.com>
To: Mark Brown <broonie@kernel.org>
Subject: Re: [alsa-devel] [PATCH] ASoC: fsl_ssi: Implement symmetric_channels
 and symmetric_samplebits
Message-ID: <20131204103306.GF8609@MrMyself>
References: <1386067087-12243-1-git-send-email-b42378@freescale.com>
 <20131203145833.GV27568@sirena.org.uk>
 <20131204072702.GE8609@MrMyself>
 <20131204104230.GD29268@sirena.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
In-Reply-To: <20131204104230.GD29268@sirena.org.uk>
Cc: tiwai@suse.de, alsa-devel@alsa-project.org, linuxppc-dev@lists.ozlabs.org,
 lgirdwood@gmail.com, timur@tabi.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, Dec 04, 2013 at 10:42:30AM +0000, Mark Brown wrote:
> On Wed, Dec 04, 2013 at 03:27:03PM +0800, Nicolin Chen wrote:
> 
> > Sir, shall we also implement these two to other drivers like codecs?
> > I know this symmetry is a new feature and might be still immature.
> > By implementing it might bring some side effects. But meanwhile, it
> > would also allows us to engage more people to test it, although myself
> > have done a branch of tests with different user cases on my platform.
> 
> > Or we just wait for people engaging by themselves?
> 
> It makes sense to roll it out, since it's in the core if there is a
> problem we only need to fix it in one place to fix all the users which
> makes life easier.

Fully Agreed. I'll try to generate patches to do the rolling job and send
them later.

Thank you for your reply,
Nicolin Chen
