Return-Path: <timur@tabi.org>
Received: from muin.pair.com (muin.pair.com [209.68.1.55])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3yzFL25nsrzDrWf
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 16 Dec 2017 15:53:14 +1100 (AEDT)
Subject: Re: [PATCH v3 00/11] ASoC: fsl_ssi: Clean up - coding style level
To: Nicolin Chen <nicoleotsuka@gmail.com>, broonie@kernel.org
Cc: linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 alsa-devel@alsa-project.org, fabio.estevam@nxp.com,
 mail@maciej.szmigiero.name, caleb@crome.org, lgirdwood@gmail.com,
 arnaud.mouiche@invoxia.com, lukma@denx.de, kernel@pengutronix.de
References: <1513207108-30430-1-git-send-email-nicoleotsuka@gmail.com>
From: Timur Tabi <timur@tabi.org>
Message-ID: <19ce4850-5561-45b1-3c16-1dd5591ab88a@tabi.org>
Date: Fri, 15 Dec 2017 22:53:09 -0600
MIME-Version: 1.0
In-Reply-To: <1513207108-30430-1-git-send-email-nicoleotsuka@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 12/13/17 5:18 PM, Nicolin Chen wrote:
> Additionally, in order to fix/work-around hardware bugs and design
> flaws, the driver made a lot of compromise so now its program flow
> looks very complicated and it's getting hard to maintain or update.
> 
> So I am going to clean up the driver on both coding style level and
> program flow level.

I'm okay with everything except patch #3.
