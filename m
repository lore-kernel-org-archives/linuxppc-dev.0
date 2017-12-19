Return-Path: <timur@tabi.org>
Received: from muin.pair.com (muin.pair.com [209.68.1.55])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3z1Q5L3TtczDqRQ
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 20 Dec 2017 04:34:45 +1100 (AEDT)
Subject: Re: [PATCH v1 00/15] ASoC: fsl_ssi: Clean up - program flow level
To: Nicolin Chen <nicoleotsuka@gmail.com>, broonie@kernel.org
Cc: linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 alsa-devel@alsa-project.org, lgirdwood@gmail.com, fabio.estevam@nxp.com,
 mail@maciej.szmigiero.name, caleb@crome.org, arnaud.mouiche@invoxia.com,
 lukma@denx.de, kernel@pengutronix.de
References: <1513702819-42310-1-git-send-email-nicoleotsuka@gmail.com>
From: Timur Tabi <timur@tabi.org>
Message-ID: <5fb9a02a-e438-be5e-da02-084b5c5613c1@tabi.org>
Date: Tue, 19 Dec 2017 11:34:39 -0600
MIME-Version: 1.0
In-Reply-To: <1513702819-42310-1-git-send-email-nicoleotsuka@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 12/19/17 11:00 AM, Nicolin Chen wrote:
> This series of patches is the second set to clean up fsl_ssi driver
> in the program flow level. Any patch here may impact a fundamental
> test case like playback or record.

With Christmas happening over the next two weeks, I don't think I'll be 
able to review these patches until January.
