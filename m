Return-Path: <guangyu.chen@freescale.com>
Received: from tx2outboundpool.messaging.microsoft.com
 (tx2ehsobe001.messaging.microsoft.com [65.55.88.11])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "MSIT Machine Auth CA 2" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 9BB812C00A9
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  4 Dec 2013 18:46:17 +1100 (EST)
Date: Wed, 4 Dec 2013 15:27:03 +0800
From: Nicolin Chen <b42378@freescale.com>
To: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH] ASoC: fsl_ssi: Implement symmetric_channels and
 symmetric_samplebits
Message-ID: <20131204072702.GE8609@MrMyself>
References: <1386067087-12243-1-git-send-email-b42378@freescale.com>
 <20131203145833.GV27568@sirena.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
In-Reply-To: <20131203145833.GV27568@sirena.org.uk>
Cc: alsa-devel@alsa-project.org, lgirdwood@gmail.com, tiwai@suse.de,
 timur@tabi.org, perex@perex.cz, linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, Dec 03, 2013 at 02:58:33PM +0000, Mark Brown wrote:
> On Tue, Dec 03, 2013 at 06:38:07PM +0800, Nicolin Chen wrote:
> > Since we introduced symmetric_channels and symmetric_samplebits, we implement
> > these two features to fsl_ssi so as to drop some no-more-needed code and make
> > the driver neat and clean.
> 
> Applied, thanks.

Sir, shall we also implement these two to other drivers like codecs?
I know this symmetry is a new feature and might be still immature.
By implementing it might bring some side effects. But meanwhile, it
would also allows us to engage more people to test it, although myself
have done a branch of tests with different user cases on my platform.

Or we just wait for people engaging by themselves?

Thank you,
Nicolin Chen
