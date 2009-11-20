Return-Path: <glikely@secretlab.ca>
Received: from mail-yw0-f199.google.com (mail-yw0-f199.google.com
	[209.85.211.199]) by ozlabs.org (Postfix) with ESMTP id 08CF0B6EEF
	for <linuxppc-dev@ozlabs.org>; Sat, 21 Nov 2009 08:46:45 +1100 (EST)
Received: by ywh37 with SMTP id 37so3625015ywh.17
	for <linuxppc-dev@ozlabs.org>; Fri, 20 Nov 2009 13:46:44 -0800 (PST)
MIME-Version: 1.0
Sender: glikely@secretlab.ca
In-Reply-To: <20091118095828.GA5166@pengutronix.de>
References: <1258468268-9911-1-git-send-email-w.sang@pengutronix.de>
	<20091117144300.GB4850@pengutronix.de>
	<20091118095828.GA5166@pengutronix.de>
From: Grant Likely <grant.likely@secretlab.ca>
Date: Fri, 20 Nov 2009 14:46:19 -0700
Message-ID: <fa686aa40911201346p4ca1c23eu1861fe1cb1e4bf26@mail.gmail.com>
Subject: Re: [PATCH] spi/mpc52xx-spi: cleanups
To: Wolfram Sang <w.sang@pengutronix.de>
Content-Type: text/plain; charset=ISO-8859-1
Cc: spi-devel-general@lists.sourceforge.net, Luotao Fu <l.fu@pengutronix.de>,
	linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, Nov 18, 2009 at 2:58 AM, Wolfram Sang <w.sang@pengutronix.de> wrote=
:
>> > - =A0 =A0 =A0 =A0 =A0 rc |=3D request_irq(ms->irq1, mpc52xx_spi_irq, I=
RQF_SAMPLE_RANDOM,
>> > + =A0 =A0 =A0 =A0 =A0 rc |=3D request_irq(ms->irq1, mpc52xx_spi_irq, 0=
,
>> > =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 "mpc5200-s=
pi-spiF", ms);
>>
>> The "spiF" here is probably also a typo.
>
> Ack. Grant, if you think it is worth you may modify my patch to avoid a r=
esend.
> If it is easier for you, I will do the resend, of course.

Don't resend.  Patch looks okay.

g.

--=20
Grant Likely, B.Sc., P.Eng.
Secret Lab Technologies Ltd.
