Return-Path: <nicoleotsuka@gmail.com>
Received: from mail-pg0-x231.google.com (mail-pg0-x231.google.com
 [IPv6:2607:f8b0:400e:c05::231])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3z0z5C5lcDzDr9R
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 19 Dec 2017 11:18:07 +1100 (AEDT)
Received: by mail-pg0-x231.google.com with SMTP id j9so9834328pgc.11
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 18 Dec 2017 16:18:07 -0800 (PST)
Date: Mon, 18 Dec 2017 15:02:21 -0800
From: Nicolin Chen <nicoleotsuka@gmail.com>
To: Caleb Crome <caleb@crome.org>, Mark Brown <broonie@kernel.org>
Cc: Timur Tabi <timur@tabi.org>, linux-kernel@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org, alsa-devel@alsa-project.org,
 Liam Girdwood <lgirdwood@gmail.com>,
 Fabio Estevam <fabio.estevam@nxp.com>, mail@maciej.szmigiero.name,
 Arnaud Mouiche <arnaud.mouiche@invoxia.com>, lukma@denx.de,
 Sascha Hauer <kernel@pengutronix.de>
Subject: Re: [PATCH v4 00/11] ASoC: fsl_ssi: Clean up - coding style level
Message-ID: <20171218230220.GA16161@Asurada-Nvidia>
References: <1513565530-33957-1-git-send-email-nicoleotsuka@gmail.com>
 <4e69ef31-3aa6-66ea-331b-8a7472a66a15@tabi.org>
 <CAG5mAdxsWmHfCc=vFkO+Wmi8m0c_9t7B6BTUBGVOmPoGOQrsyg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <CAG5mAdxsWmHfCc=vFkO+Wmi8m0c_9t7B6BTUBGVOmPoGOQrsyg@mail.gmail.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, Dec 18, 2017 at 02:19:08PM -0800, Caleb Crome wrote:

> > Acked-by: Timur Tabi <timur@tabi.org>

--- To Mark ---

Mark, can you still take these changes first? Since this failed
test that Caleb reported here is already existing on the top of
the mainline tree, I would like to treat this mail as a separate
bug report and fix it with a separate patch.

Besides, this series of changes don't change any function flow.

Thank you


--- To Caleb ---

> I'm re-setting up my loopback test to try to verify these most recent changes.

I really appreciate your verification and help.

> warn:   11a0 11a1 1160 11a3 11a4 11a5 11a6 11a7
> warn: Valid frame after 1 invalid frames
> warn:   11c0 11c1 11c2 11c3 11c4 11c5 11c6 11c7
> warn: first invalid frame while expecting frame 0x00a0
> warn:   13e7 1400 1401 1402 1403 1404 1405 1404
> warn:   1407 1420 1421 1422 1423 1424 1425 1426
> warn:   1427 1440 1441 1442 1443 1444 1445 1484
> warn:   1447 1460 1461 1462 1463 1464 1465 1466
> 
> Those last 4 lines are the channel slips -- the least significant
> nibble should be the channel number:  i.e. should go 0, 1, 2, 3, 4, 5,
> 6, 7.
> 
> Ugh, so it's basically quite broken again -- before these patches.

I remember Arnaud reviewed one of my changes back to September.
So I suppose the test should be fine at that time -- so a change
being merged recently might have impacted the test result.

> I guess I need to go backwards in time and see what rev re-broke it.
> I don't really have time to dig too deep on this again.
> 
> I'd be happy to provide the hardware to anybody that can diagnose and
> debug this more quickly than I can.  I'm very inefficient at kernel
> drivers I think.   My day job is acoustical and electrical
> engineering.
> 
> Here's what the hardware looks like for anybody that's interested.
> Just a single wire loopback on the wandboard header.

I would definitely like to take the hardware to debug it as long
as you are willing to provide me. Can you send me a private mail
to discuss about it?

Thanks
Nicolin
