Return-Path: <nicoleotsuka@gmail.com>
Received: from mail-pf0-x244.google.com (mail-pf0-x244.google.com
 [IPv6:2607:f8b0:400e:c00::244])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3yrsWN1VJJzDr5J
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  6 Dec 2017 06:39:11 +1100 (AEDT)
Received: by mail-pf0-x244.google.com with SMTP id d23so908309pfe.9
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 05 Dec 2017 11:39:11 -0800 (PST)
Date: Tue, 5 Dec 2017 11:39:13 -0800
From: Nicolin Chen <nicoleotsuka@gmail.com>
To: Mark Brown <broonie@kernel.org>
Cc: linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 alsa-devel@alsa-project.org, fabio.estevam@nxp.com, timur@tabi.org,
 mail@maciej.szmigiero.name, caleb@crome.org, lgirdwood@gmail.com
Subject: Re: [PATCH 01/10] ASoC: fsl_ssi: Remove unused struct device
Message-ID: <20171205193912.GB11039@Asurada-Nvidia>
References: <1512420403-10164-1-git-send-email-nicoleotsuka@gmail.com>
 <1512420403-10164-2-git-send-email-nicoleotsuka@gmail.com>
 <20171205130446.GI11658@finisterre>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20171205130446.GI11658@finisterre>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, Dec 05, 2017 at 01:04:46PM +0000, Mark Brown wrote:
> On Mon, Dec 04, 2017 at 12:46:34PM -0800, Nicolin Chen wrote:
> > struct device is defined in system level header files any way.
> > As long as fsl_ssi.h is included after those header files, it
> > should be safe to remove this line.
> 
> It's better practice to either directly include those headers or have a
> forward declaration like this, it means there's no way things can go
> wrong.

I see. I will drop this patch then.
