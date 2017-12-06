Return-Path: <nicoleotsuka@gmail.com>
Received: from mail-pf0-x242.google.com (mail-pf0-x242.google.com
 [IPv6:2607:f8b0:400e:c00::242])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3ys18L612czDrZt
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  6 Dec 2017 12:23:14 +1100 (AEDT)
Received: by mail-pf0-x242.google.com with SMTP id n6so1560206pfa.4
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 05 Dec 2017 17:23:14 -0800 (PST)
Date: Tue, 5 Dec 2017 17:23:13 -0800
From: Nicolin Chen <nicoleotsuka@gmail.com>
To: "Maciej S. Szmigiero" <mail@maciej.szmigiero.name>
Cc: broonie@kernel.org, linux-kernel@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org, alsa-devel@alsa-project.org,
 fabio.estevam@nxp.com, timur@tabi.org, caleb@crome.org, lgirdwood@gmail.com
Subject: Re: [PATCH 00/10] ASoC: fsl_ssi: Clean up - coding style level
Message-ID: <20171206012312.GA11876@Asurada-Nvidia>
References: <1512420403-10164-1-git-send-email-nicoleotsuka@gmail.com>
 <81e17b9c-e878-1fe9-bb6f-b074d5766232@maciej.szmigiero.name>
 <20171205193258.GA11039@Asurada-Nvidia>
 <1cbd2b92-30c3-4f07-e9ab-8c9a2d342800@maciej.szmigiero.name>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1cbd2b92-30c3-4f07-e9ab-8c9a2d342800@maciej.szmigiero.name>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, Dec 06, 2017 at 02:01:32AM +0100, Maciej S. Szmigiero wrote:

> >>> ==Verification==
> >>> Theoretically, it only needs code review, build and sanity tests. I
> >>> have done build and sanity tests on an i.MX 6 platform by building
> >>> using imx_v6_v7_defconfig and testing with I2S slave/master mode.
> > 
> >> Due to my current workload I will be able to go through this and test
> >> the AC'97 mode on a UDOO board only in about a week.
> > 
> > This is the first round which doesn't touch program flow. If you
> > prefer to verify it other than merely reviewing it, I would like
> > to wait for your Tested-by. There will be another set to simplify
> > all functions and their program flows after this set gets merged.
> > That one will need to be fully tested.
> 
> If you can wait a week then naturally it would be better to test
> these changes on a real board.

I can wait for a week. I think Timur will also want to justify for
some changes. So I need time to revise and rebase as well -- I've
some patches for the 2nd set already, so rebasing would take some
time.
