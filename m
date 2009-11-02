Return-Path: <glikely@secretlab.ca>
Received: from mail-gx0-f223.google.com (mail-gx0-f223.google.com
	[209.85.217.223]) by ozlabs.org (Postfix) with ESMTP id 6DC30100808
	for <linuxppc-dev@ozlabs.org>; Tue,  3 Nov 2009 04:49:20 +1100 (EST)
Received: by gxk23 with SMTP id 23so2119414gxk.2
	for <linuxppc-dev@ozlabs.org>; Mon, 02 Nov 2009 09:49:19 -0800 (PST)
MIME-Version: 1.0
Sender: glikely@secretlab.ca
In-Reply-To: <1256925231-21917-1-git-send-email-w.sang@pengutronix.de>
References: <20091030105414.GD717@sirena.org.uk>
	<1256925231-21917-1-git-send-email-w.sang@pengutronix.de>
From: Grant Likely <grant.likely@secretlab.ca>
Date: Mon, 2 Nov 2009 10:48:58 -0700
Message-ID: <fa686aa40911020948o673b058emba4bb2ccfc1cfd17@mail.gmail.com>
Subject: Re: [PATCH V2] mpc512x/clock: fix clk_get logic
To: Wolfram Sang <w.sang@pengutronix.de>
Content-Type: text/plain; charset=ISO-8859-1
Cc: linuxppc-dev@ozlabs.org, Roel Kluin <roel.kluin@gmail.com>,
	Mark Brown <broonie@sirena.org.uk>, Wolfgang Denk <wd@denx.de>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, Oct 30, 2009 at 10:53 AM, Wolfram Sang <w.sang@pengutronix.de> wrot=
e:
> + =A0 =A0 =A0 bool id_matched =3D !id;
> + =A0 =A0 =A0 bool dev_matched =3D !dev;
[...]
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 dev_matched =3D true;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (id && strcmp(id, p->name) =3D=3D 0)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 id_matched =3D true;

Using bool/true/false doesn't seem to be a common pattern in the
kernel.  Anyone know what the winds of prevailing opinion are
regarding 'bool' in kernel code?

g.

--=20
Grant Likely, B.Sc., P.Eng.
Secret Lab Technologies Ltd.
