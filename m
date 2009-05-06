Return-Path: <glikely@secretlab.ca>
Received: from mail-gx0-f172.google.com (mail-gx0-f172.google.com
	[209.85.217.172]) by ozlabs.org (Postfix) with ESMTP id B74E2DDF93
	for <linuxppc-dev@ozlabs.org>; Thu,  7 May 2009 08:40:50 +1000 (EST)
Received: by gxk20 with SMTP id 20so786362gxk.9
	for <linuxppc-dev@ozlabs.org>; Wed, 06 May 2009 15:40:49 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20090506210644.GA17311@pengutronix.de>
References: <1241640919-4650-1-git-send-email-wd@denx.de>
	<1241640919-4650-11-git-send-email-wd@denx.de>
	<20090506210644.GA17311@pengutronix.de>
From: Grant Likely <grant.likely@secretlab.ca>
Date: Wed, 6 May 2009 16:40:29 -0600
Message-ID: <fa686aa40905061540x96c1524hd88ee78bc366b89b@mail.gmail.com>
Subject: Re: [PATCH 10/12] mpc5121: Add MPC5121 Real time clock driver.
To: Wolfram Sang <w.sang@pengutronix.de>
Content-Type: text/plain; charset=ISO-8859-1
Cc: John Rigby <jrigby@freescale.com>, linuxppc-dev@ozlabs.org,
	Wolfgang Denk <wd@denx.de>, rtc-linux@googlegroups.com,
	Piotr Ziecik <kosmo@semihalf.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Wed, May 6, 2009 at 3:06 PM, Wolfram Sang <w.sang@pengutronix.de> wrote:
> On Wed, May 06, 2009 at 10:15:17PM +0200, Wolfgang Denk wrote:
>> From: John Rigby <jrigby@freescale.com>
>>
>> Based on Domen Puncer's rtc driver for 5200 posted to
>> the ppclinux mailing list:
>> =A0 =A0 =A0 http://patchwork.ozlabs.org/linuxppc-embedded/patch?id=3D116=
75
>> but never commited anywhere.
>>
>> Changes to Domen's original:
>>
>> =A0 =A0 Changed filenames/routine names from mpc5200* to mpc5121*
>
> Why not changing it to mpc5xxx? From a glimpse, it should still work on
> MPC5200, too.

If this is true, the I heartily agree with Wolfram.  :-)

g.

--=20
Grant Likely, B.Sc., P.Eng.
Secret Lab Technologies Ltd.
