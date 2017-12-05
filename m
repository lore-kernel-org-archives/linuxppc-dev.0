Return-Path: <mail@maciej.szmigiero.name>
Received: from vps-vb.mhejs.net (vps-vb.mhejs.net [37.28.154.113])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3yrhhW15GCzDrYp
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  6 Dec 2017 00:01:28 +1100 (AEDT)
Subject: Re: [PATCH 00/10] ASoC: fsl_ssi: Clean up - coding style level
To: Nicolin Chen <nicoleotsuka@gmail.com>
Cc: broonie@kernel.org, linux-kernel@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org, alsa-devel@alsa-project.org,
 fabio.estevam@nxp.com, timur@tabi.org, caleb@crome.org, lgirdwood@gmail.com
References: <1512420403-10164-1-git-send-email-nicoleotsuka@gmail.com>
From: "Maciej S. Szmigiero" <mail@maciej.szmigiero.name>
Message-ID: <81e17b9c-e878-1fe9-bb6f-b074d5766232@maciej.szmigiero.name>
Date: Tue, 5 Dec 2017 14:01:17 +0100
MIME-Version: 1.0
In-Reply-To: <1512420403-10164-1-git-send-email-nicoleotsuka@gmail.com>
Content-Type: text/plain; charset=utf-8
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi Nicolin,

On 04.12.2017 21:46, Nicolin Chen wrote:
> ==Background==
> The fsl_ssi driver was designed for PPC originally and then it has
> been updated to support different modes for i.MX Series, including
> SDMA, I2S Master mode, AC97 and older i.MXs with FIQ, by different
> contributors for different use cases in different coding styles.
> 
> Additionally, in order to fix/work-around hardware bugs and design
> flaws, the driver made a lot of compromise so now its program flow
> looks very complicated and it's getting hard to maintain or update.
> 
> So I am going to clean up the driver in both coding style level and
> program flow level.
> 
> ==Introduction==
> This series of patches is the first set to clean up fsl_ssi driver
> in the coding style level. Any patch here is not supposed to change
> the program flow.
> 
> ==Verification==
> Theoretically, it only needs code review, build and sanity tests. I
> have done build and sanity tests on an i.MX 6 platform by building
> using imx_v6_v7_defconfig and testing with I2S slave/master mode.

Thanks for your cleanup work.

Due to my current workload I will be able to go through this and test
the AC'97 mode on a UDOO board only in about a week.

Maciej
