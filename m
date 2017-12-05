Return-Path: <nicoleotsuka@gmail.com>
Received: from mail-pg0-x241.google.com (mail-pg0-x241.google.com
 [IPv6:2607:f8b0:400e:c05::241])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3yrTVJ1p9QzDvJ2
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  5 Dec 2017 15:36:55 +1100 (AEDT)
Received: by mail-pg0-x241.google.com with SMTP id k134so9867634pga.3
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 04 Dec 2017 20:36:55 -0800 (PST)
Date: Mon, 4 Dec 2017 20:36:54 -0800
From: Nicolin Chen <nicoleotsuka@gmail.com>
To: Timur Tabi <timur@tabi.org>
Cc: broonie@kernel.org, linux-kernel@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org, alsa-devel@alsa-project.org,
 fabio.estevam@nxp.com, mail@maciej.szmigiero.name, caleb@crome.org,
 lgirdwood@gmail.com
Subject: Re: [PATCH 04/10] ASoC: fsl_ssi: Refine all comments
Message-ID: <20171205043653.GA13204@Asurada-Nvidia>
References: <1512420403-10164-1-git-send-email-nicoleotsuka@gmail.com>
 <1512420403-10164-5-git-send-email-nicoleotsuka@gmail.com>
 <8e5229a8-5f3f-d55f-95dc-2b33657b9c9a@tabi.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <8e5229a8-5f3f-d55f-95dc-2b33657b9c9a@tabi.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, Dec 04, 2017 at 10:04:57PM -0600, Timur Tabi wrote:
> On 12/4/17 2:46 PM, Nicolin Chen wrote:
> >This patch refines the comments by:
> >1) Removing all out-of-date comments
> >2) Removing all not-so-useful comments
> >3) Unifying the styles of all comments
> >4) Simplifying over-descriptive comments
> >5) Adding comments to improve code readablity
> >6) Moving all register related comments to fsl_ssi.h
> >7) Adding comments to all register and field defines
> >
> >Even after adding dozens of lines in fsl_ssi.h, this patch reduces
> >100 lines totally.
> 
> I'll review the other patches later, but I'm not keen on your
> removal of some of the comments in this patch.  I don't see why line
> count is so important, and you're removing some informative text.  I

That's okay. That's why I included recent contributors to review.

> can see removing trivial comments and outdated ones, but
> "no-so-useful" and "over-descriptive" are subjective.

I agree. I am just being very aggressive here to clean up the driver
in any inch that I feel it's possible to simplify. If any one has a
concern about certain parts of the removal, it's okay to justify for
it. I will revise it to get more informative while being concise.
