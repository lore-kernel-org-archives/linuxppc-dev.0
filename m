Return-Path: <nicoleotsuka@gmail.com>
Received: from mail-pa0-x22c.google.com (mail-pa0-x22c.google.com
 [IPv6:2607:f8b0:400e:c03::22c])
 (using TLSv1 with cipher ECDHE-RSA-RC4-SHA (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 5BF9A1A003B
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 10 Sep 2014 07:18:50 +1000 (EST)
Received: by mail-pa0-f44.google.com with SMTP id kx10so6213915pab.17
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 09 Sep 2014 14:18:46 -0700 (PDT)
Date: Tue, 9 Sep 2014 14:09:50 -0700
From: Nicolin Chen <nicoleotsuka@gmail.com>
To: Timur Tabi <timur@tabi.org>,
	Shengjiu Wang <shengjiu.wang@freescale.com>
Subject: Re: [PATCH V1] ASoC: fsl_ssi: refine ipg clock usage in this module
Message-ID: <20140909210949.GA1816@Asurada>
References: <e5a50d8bfde3aea5fcd092118da5aea4072c7e2f.1410254125.git.shengjiu.wang@freescale.com>
 <20140909183804.GA6944@Asurada> <540F5706.1050303@tabi.org>
 <20140909195928.GA5224@Asurada> <540F5D29.7040309@tabi.org>
 <20140909202710.GB5224@Asurada> <540F6506.4060302@tabi.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <540F6506.4060302@tabi.org>
Cc: alsa-devel@alsa-project.org, tiwai@suse.de, Li.Xiubo@freescale.com,
 lgirdwood@gmail.com, perex@perex.cz, broonie@kernel.org, mpa@pengutronix.de,
 linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, Sep 09, 2014 at 03:37:26PM -0500, Timur Tabi wrote:
> >However, my approach doesn't need any check. The open() or pm_resume()
> >can just call clk_prepare_enable() directly. The __clk_enable() will
> >then handle the 'clk == NULL' case:
> 
> Yes, I was thinking the same thing.

Because that's following your suggestion :)

@Shengjiu
Another thing I forgot to mention is we still need a return check for
clk_prepare_enable() which isn't in the current version. And I said
"doesn't need any check" is indicating the pre-check of the call.

Thank you
Nicolin
