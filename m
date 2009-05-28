Return-Path: <esbenhaabendal@gmail.com>
Received: from mail-qy0-f123.google.com (mail-qy0-f123.google.com
	[209.85.221.123]) by ozlabs.org (Postfix) with ESMTP id AB736DDF01
	for <linuxppc-dev@ozlabs.org>; Fri, 29 May 2009 06:41:40 +1000 (EST)
Received: by qyk29 with SMTP id 29so1932260qyk.17
	for <linuxppc-dev@ozlabs.org>; Thu, 28 May 2009 13:41:38 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <87ws8155md.fsf@macbook.be.48ers.dk>
References: <4A124202.4010201@doredevelopment.dk>
	<d2b9ea600905260430i72290901p9266de4cade049c1@mail.gmail.com>
	<20090526213351.GG23114@fluff.org.uk>
	<20090528171726.GE3112@pengutronix.de>
	<d2b9ea600905281310p16f47ed0i454e25bf256d3010@mail.gmail.com>
	<87ws8155md.fsf@macbook.be.48ers.dk>
Date: Thu, 28 May 2009 22:41:38 +0200
Message-ID: <d2b9ea600905281341s24efa4e3l6277a8aa5dec5bd@mail.gmail.com>
Subject: Re: [PATCH v2] i2c-mpc: generate START condition after STOP caused by
	read i2c_msg
From: Esben Haabendal <esbenhaabendal@gmail.com>
To: Peter Korsgaard <jacmet@sunsite.dk>
Content-Type: text/plain; charset=ISO-8859-1
Cc: Esben Haabendal <eha@doredevelopment.dk>, linuxppc-dev@ozlabs.org,
	linux-i2c@vger.kernel.org, Ben Dooks <ben-linux@fluff.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

> =A0Esben> I've checked both my copy in my "Sent" folder and the copy
> =A0Esben> received from the list, and I cannot see any "line break"
> =A0Esben> breakage of the patch.
>
> I guess Wolfram referred to the context line which was clearly word wrapp=
ed:
>
> @@ -456,17 +456,22 @@ static int mpc_xfer(struct i2c_adapter *adap,
> struct i2c_msg *msgs, int num)
>
> The other lines look fine.

It's strange, that line looks perfectly fine when I check the mail in my GM=
ail
inbox and the outbox from the account I sent it from.

/Esben
--=20
Esben Haabendal, Senior Software Consultant
Dor=E9Development ApS, Ved Stranden 1, 9560 Hadsund, DK-Denmark
Phone: +45 51 92 53 93, E-mail: eha@doredevelopment.dk
WWW: http://www.doredevelopment.dk
