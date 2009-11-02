Return-Path: <glikely@secretlab.ca>
Received: from mail-yw0-f199.google.com (mail-yw0-f199.google.com
	[209.85.211.199]) by ozlabs.org (Postfix) with ESMTP id D969E100831
	for <linuxppc-dev@ozlabs.org>; Tue,  3 Nov 2009 05:03:45 +1100 (EST)
Received: by ywh37 with SMTP id 37so5395771ywh.17
	for <linuxppc-dev@ozlabs.org>; Mon, 02 Nov 2009 10:03:44 -0800 (PST)
MIME-Version: 1.0
Sender: glikely@secretlab.ca
In-Reply-To: <20091102135244.GC4696@pengutronix.de>
References: <1256297157-28246-1-git-send-email-w.sang@pengutronix.de>
	<fa686aa40910311822i4ba27b2bs350c5684cd57187b@mail.gmail.com>
	<20091102135244.GC4696@pengutronix.de>
From: Grant Likely <grant.likely@secretlab.ca>
Date: Mon, 2 Nov 2009 11:03:24 -0700
Message-ID: <fa686aa40911021003r7c622654k654cd91d4ee58184@mail.gmail.com>
Subject: Re: [PATCH] spi/mpc52xx: check for invalid PSC usage
To: Wolfram Sang <w.sang@pengutronix.de>
Content-Type: text/plain; charset=ISO-8859-1
Cc: spi-devel-general@lists.sourceforge.net,
	David Brownell <dbrownell@users.sourceforge.net>, linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, Nov 2, 2009 at 6:53 AM, Wolfram Sang <w.sang@pengutronix.de> wrote:
>> I wouldn't even bother. =A0It's not actively dangerous to try and use
>> PSC{4,5} in SPI mode. =A0It just not going to work. =A0Besides, the
>> MPC5200 common code already checks for an invalid PSC number when
>> setting the clock divisor.
>>
>> Have you seen cases of users trying to do the wrong thing with the
>> crippled PSCs?
>
> Yes, that was the reason for this patch :) How about this patch to give u=
sers a
> better idea than just -ENODEV via set_psc_clkdiv? ...[/me hacks]...
> Uuuh, there is even a bug which makes the case go unnoticed.

Sure.  This looks okay to me.  I'll pick it up.

g.

--=20
Grant Likely, B.Sc., P.Eng.
Secret Lab Technologies Ltd.
