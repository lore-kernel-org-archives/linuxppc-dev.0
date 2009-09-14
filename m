Return-Path: <glikely@secretlab.ca>
Received: from ozlabs.org (ozlabs.org [203.10.76.45])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.ozlabs.org",
	Issuer "CA Cert Signing Authority" (verified OK))
	by bilbo.ozlabs.org (Postfix) with ESMTPS id 58854B7C1A
	for <linuxppc-dev@lists.ozlabs.org>;
	Tue, 15 Sep 2009 00:46:20 +1000 (EST)
Received: from mail-yw0-f180.google.com (mail-yw0-f180.google.com
	[209.85.211.180]) by ozlabs.org (Postfix) with ESMTP id 98A98DDD01
	for <linuxppc-dev@ozlabs.org>; Tue, 15 Sep 2009 00:46:18 +1000 (EST)
Received: by ywh10 with SMTP id 10so726163ywh.1
	for <linuxppc-dev@ozlabs.org>; Mon, 14 Sep 2009 07:46:17 -0700 (PDT)
MIME-Version: 1.0
Sender: glikely@secretlab.ca
In-Reply-To: <20090914080322.GA3164@pengutronix.de>
References: <4AADF93C.3030604@denx.de> <20090914080322.GA3164@pengutronix.de>
From: Grant Likely <grant.likely@secretlab.ca>
Date: Mon, 14 Sep 2009 08:45:57 -0600
Message-ID: <fa686aa40909140745u2cf1dba7q8ae2af53c87bd216@mail.gmail.com>
Subject: Re: [PATCH] mpc5200: support for the MAN mpc5200 based board mucmc52
To: Wolfram Sang <w.sang@pengutronix.de>
Content-Type: text/plain; charset=ISO-8859-1
Cc: linuxppc-dev@ozlabs.org, Heiko Schocher <hs@denx.de>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, Sep 14, 2009 at 2:03 AM, Wolfram Sang <w.sang@pengutronix.de> wrote=
:
> Hi,
>
>> + =A0 =A0 =A0 =A0 =A0 =A0 mpc5200_pic: interrupt-controller@500 {
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 // 5200 interrupts are encoded=
 into two levels;
>
> Grant, maybe this comment could be dropped also for the in-kernel dts-fil=
es? I
> think it is sufficently described in mpc5200.txt. I could prepare a patch=
 if
> you agree.

Meh.  I don't mind it being there.  Interrupt encoding is confusing
enough as is for people unfamiliar with the device tree, that any
additional hints are a plus.  In fact, if you want to prepare a patch,
instead of removing this comment, replace it with one that tells
readers where to look for the encoding documentation.

Cheers,
g.

--=20
Grant Likely, B.Sc., P.Eng.
Secret Lab Technologies Ltd.
