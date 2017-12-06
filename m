Return-Path: <mail@maciej.szmigiero.name>
Received: from vps-vb.mhejs.net (vps-vb.mhejs.net [37.28.154.113])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3ys0gc2RrVzDrpn
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  6 Dec 2017 12:01:45 +1100 (AEDT)
Subject: Re: [PATCH 00/10] ASoC: fsl_ssi: Clean up - coding style level
To: Nicolin Chen <nicoleotsuka@gmail.com>
Cc: broonie@kernel.org, linux-kernel@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org, alsa-devel@alsa-project.org,
 fabio.estevam@nxp.com, timur@tabi.org, caleb@crome.org, lgirdwood@gmail.com
References: <1512420403-10164-1-git-send-email-nicoleotsuka@gmail.com>
 <81e17b9c-e878-1fe9-bb6f-b074d5766232@maciej.szmigiero.name>
 <20171205193258.GA11039@Asurada-Nvidia>
From: "Maciej S. Szmigiero" <mail@maciej.szmigiero.name>
Message-ID: <1cbd2b92-30c3-4f07-e9ab-8c9a2d342800@maciej.szmigiero.name>
Date: Wed, 6 Dec 2017 02:01:32 +0100
MIME-Version: 1.0
In-Reply-To: <20171205193258.GA11039@Asurada-Nvidia>
Content-Type: text/plain; charset=utf-8
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 05.12.2017 20:33, Nicolin Chen wrote:
> On Tue, Dec 05, 2017 at 02:01:17PM +0100, Maciej S. Szmigiero wrote:
> 
>>> ==Verification==
>>> Theoretically, it only needs code review, build and sanity tests. I
>>> have done build and sanity tests on an i.MX 6 platform by building
>>> using imx_v6_v7_defconfig and testing with I2S slave/master mode.
> 
>> Due to my current workload I will be able to go through this and test
>> the AC'97 mode on a UDOO board only in about a week.
> 
> This is the first round which doesn't touch program flow. If you
> prefer to verify it other than merely reviewing it, I would like
> to wait for your Tested-by. There will be another set to simplify
> all functions and their program flows after this set gets merged.
> That one will need to be fully tested.

If you can wait a week then naturally it would be better to test
these changes on a real board.

Maciej
