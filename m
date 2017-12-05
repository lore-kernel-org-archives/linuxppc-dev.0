Return-Path: <timur@tabi.org>
Received: from muin.pair.com (muin.pair.com [209.68.1.55])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3yrSzV0s0lzDrpk
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  5 Dec 2017 15:13:41 +1100 (AEDT)
Subject: Re: [PATCH 04/10] ASoC: fsl_ssi: Refine all comments
To: Nicolin Chen <nicoleotsuka@gmail.com>, broonie@kernel.org
Cc: linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 alsa-devel@alsa-project.org, fabio.estevam@nxp.com,
 mail@maciej.szmigiero.name, caleb@crome.org, lgirdwood@gmail.com
References: <1512420403-10164-1-git-send-email-nicoleotsuka@gmail.com>
 <1512420403-10164-5-git-send-email-nicoleotsuka@gmail.com>
From: Timur Tabi <timur@tabi.org>
Message-ID: <8e5229a8-5f3f-d55f-95dc-2b33657b9c9a@tabi.org>
Date: Mon, 4 Dec 2017 22:04:57 -0600
MIME-Version: 1.0
In-Reply-To: <1512420403-10164-5-git-send-email-nicoleotsuka@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 12/4/17 2:46 PM, Nicolin Chen wrote:
> This patch refines the comments by:
> 1) Removing all out-of-date comments
> 2) Removing all not-so-useful comments
> 3) Unifying the styles of all comments
> 4) Simplifying over-descriptive comments
> 5) Adding comments to improve code readablity
> 6) Moving all register related comments to fsl_ssi.h
> 7) Adding comments to all register and field defines
> 
> Even after adding dozens of lines in fsl_ssi.h, this patch reduces
> 100 lines totally.

I'll review the other patches later, but I'm not keen on your removal of 
some of the comments in this patch.  I don't see why line count is so 
important, and you're removing some informative text.  I can see 
removing trivial comments and outdated ones, but "no-so-useful" and 
"over-descriptive" are subjective.
