Return-Path: <mail@maciej.szmigiero.name>
Received: from vps-vb.mhejs.net (vps-vb.mhejs.net [37.28.154.113])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3zLnZL2MLZzF0Xb
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 17 Jan 2018 11:11:37 +1100 (AEDT)
Subject: Re: [PATCH v4 00/17] ASoC: fsl_ssi: Clean up - program flow level
To: Nicolin Chen <nicoleotsuka@gmail.com>
Cc: timur@tabi.org, broonie@kernel.org, linux-kernel@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org, alsa-devel@alsa-project.org,
 lgirdwood@gmail.com, fabio.estevam@nxp.com, caleb@crome.org,
 arnaud.mouiche@invoxia.com, lukma@denx.de, kernel@pengutronix.de
References: <1516058192-65519-1-git-send-email-nicoleotsuka@gmail.com>
 <56fb5b43-383f-c0f2-360c-eef0e4d0844f@maciej.szmigiero.name>
 <20180116235258.GA6849@Asurada-Nvidia>
From: "Maciej S. Szmigiero" <mail@maciej.szmigiero.name>
Message-ID: <301c4cb1-d0ad-4fe8-0388-059d355b4c2e@maciej.szmigiero.name>
Date: Wed, 17 Jan 2018 01:11:29 +0100
MIME-Version: 1.0
In-Reply-To: <20180116235258.GA6849@Asurada-Nvidia>
Content-Type: text/plain; charset=utf-8
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 17.01.2018 00:52, Nicolin Chen wrote:
> On Wed, Jan 17, 2018 at 12:38:09AM +0100, Maciej S. Szmigiero wrote:
> 
>>> Example of uncovered tests: AC97, PowerPC and FIQ.
>>
>> I've tested the whole series in the AC'97 mode on an i.MX6 UDOO board
>> and everything seems to work fine as long as few small changes are made
>> to patches 13 and 16.
> 
> Thanks for the review and testing. Really appreciate that. I'll
> take care of those issues in the next version.
Thanks for these cleanups Nicolin!

> And I believe those issues are confined to AC97. So Caleb should
> be able to skip his test if only these two places get updated.
> (Thanks for keeping testing on each version.)

Yes, these required changes only affect the AC'97 mode, there
shouldn't be any functionality change in the I2S mode.

Maciej
