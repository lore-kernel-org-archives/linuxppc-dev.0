Return-Path: <glikely@secretlab.ca>
Received: from mail-yw0-f199.google.com (mail-yw0-f199.google.com
	[209.85.211.199]) by ozlabs.org (Postfix) with ESMTP id B0BF7B7BF3
	for <linuxppc-dev@ozlabs.org>; Tue,  3 Nov 2009 10:49:51 +1100 (EST)
Received: by ywh37 with SMTP id 37so5691643ywh.17
	for <linuxppc-dev@ozlabs.org>; Mon, 02 Nov 2009 15:49:50 -0800 (PST)
MIME-Version: 1.0
Sender: glikely@secretlab.ca
In-Reply-To: <20091103101032.496a0290.sfr@canb.auug.org.au>
References: <20091030105414.GD717@sirena.org.uk>
	<1256925231-21917-1-git-send-email-w.sang@pengutronix.de>
	<fa686aa40911020948o673b058emba4bb2ccfc1cfd17@mail.gmail.com>
	<20091103101032.496a0290.sfr@canb.auug.org.au>
From: Grant Likely <grant.likely@secretlab.ca>
Date: Mon, 2 Nov 2009 16:49:30 -0700
Message-ID: <fa686aa40911021549o36c7d49dl9da9f770d6a37708@mail.gmail.com>
Subject: Re: [PATCH V2] mpc512x/clock: fix clk_get logic
To: Stephen Rothwell <sfr@canb.auug.org.au>
Content-Type: text/plain; charset=ISO-8859-1
Cc: linuxppc-dev@ozlabs.org, Roel Kluin <roel.kluin@gmail.com>,
	Wolfgang Denk <wd@denx.de>, Mark Brown <broonie@sirena.org.uk>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, Nov 2, 2009 at 4:10 PM, Stephen Rothwell <sfr@canb.auug.org.au> wro=
te:
> Hi Grant,
>
> On Mon, 2 Nov 2009 10:48:58 -0700 Grant Likely <grant.likely@secretlab.ca=
> wrote:
>>
>> Using bool/true/false doesn't seem to be a common pattern in the
>> kernel. =A0Anyone know what the winds of prevailing opinion are
>> regarding 'bool' in kernel code?
>
> Its a good thing.

Thanks,
g.

--=20
Grant Likely, B.Sc., P.Eng.
Secret Lab Technologies Ltd.
