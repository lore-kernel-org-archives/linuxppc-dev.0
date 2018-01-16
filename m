Return-Path: <nicoleotsuka@gmail.com>
Received: from mail-pl0-x22a.google.com (mail-pl0-x22a.google.com
 [IPv6:2607:f8b0:400e:c01::22a])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3zLn8R0gjMzF0X0
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 17 Jan 2018 10:52:38 +1100 (AEDT)
Received: by mail-pl0-x22a.google.com with SMTP id b96so7385337pli.2
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 16 Jan 2018 15:52:38 -0800 (PST)
Date: Tue, 16 Jan 2018 15:52:59 -0800
From: Nicolin Chen <nicoleotsuka@gmail.com>
To: "Maciej S. Szmigiero" <mail@maciej.szmigiero.name>
Cc: timur@tabi.org, broonie@kernel.org, linux-kernel@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org, alsa-devel@alsa-project.org,
 lgirdwood@gmail.com, fabio.estevam@nxp.com, caleb@crome.org,
 arnaud.mouiche@invoxia.com, lukma@denx.de, kernel@pengutronix.de
Subject: Re: [PATCH v4 00/17] ASoC: fsl_ssi: Clean up - program flow level
Message-ID: <20180116235258.GA6849@Asurada-Nvidia>
References: <1516058192-65519-1-git-send-email-nicoleotsuka@gmail.com>
 <56fb5b43-383f-c0f2-360c-eef0e4d0844f@maciej.szmigiero.name>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <56fb5b43-383f-c0f2-360c-eef0e4d0844f@maciej.szmigiero.name>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, Jan 17, 2018 at 12:38:09AM +0100, Maciej S. Szmigiero wrote:

> > Example of uncovered tests: AC97, PowerPC and FIQ.
> 
> I've tested the whole series in the AC'97 mode on an i.MX6 UDOO board
> and everything seems to work fine as long as few small changes are made
> to patches 13 and 16.

Thanks for the review and testing. Really appreciate that. I'll
take care of those issues in the next version.

And I believe those issues are confined to AC97. So Caleb should
be able to skip his test if only these two places get updated.
(Thanks for keeping testing on each version.)
