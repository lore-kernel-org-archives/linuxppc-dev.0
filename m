Return-Path: <nicoleotsuka@gmail.com>
Received: from mail-pd0-x234.google.com (mail-pd0-x234.google.com
 [IPv6:2607:f8b0:400e:c02::234])
 (using TLSv1 with cipher ECDHE-RSA-RC4-SHA (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 1CC851A0155
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 28 Oct 2014 04:42:10 +1100 (AEDT)
Received: by mail-pd0-f180.google.com with SMTP id ft15so4075028pdb.25
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 27 Oct 2014 10:42:08 -0700 (PDT)
Date: Mon, 27 Oct 2014 10:42:02 -0700
From: Nicolin Chen <nicoleotsuka@gmail.com>
To: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH] ASoC: fsl-asoc-card: Don't bypass settings if cpu-dai is
 Master
Message-ID: <20141027174201.GA3408@Asurada>
References: <cover.1414193668.git.nicoleotsuka@gmail.com>
 <1414194502-14052-1-git-send-email-nicoleotsuka@gmail.com>
 <20141027173031.GA18557@sirena.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20141027173031.GA18557@sirena.org.uk>
Cc: alsa-devel@alsa-project.org, lgirdwood@gmail.com, b02247@freescale.com,
 linux-kernel@vger.kernel.org, timur@tabi.org, Li.Xiubo@freescale.com,
 linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, Oct 27, 2014 at 05:30:31PM +0000, Mark Brown wrote:
> On Fri, Oct 24, 2014 at 04:48:11PM -0700, Nicolin Chen wrote:
> > When cpu-dai is the DAI Master (CBM_CFx), it may need some configurations,
> > set_sysclk() call for eample, for cpu-dai side in the hw_params(), even if
> > the set_bias_level() has already taken care of the codec-dai side.
> > 
> > So this patch just simply adds an additional condition.
> 
> This was threaded with another patch series - did you intend to submit
> this or did it get sent by accident?

I created this one without "--thread" (separately from that series) but
accidentally sent the patch along with the series in one git-send-mail
command. So I think I don't need to resend it since it's already there.

Please regard this one as one single patch.

Thank you.
Nicolin
