Return-Path: <kylo.ginsberg@gmail.com>
Received: from rproxy.gmail.com (rproxy.gmail.com [64.233.170.195])
	by ozlabs.org (Postfix) with ESMTP id 01E1967A06
	for <linuxppc-embedded@ozlabs.org>;
	Wed, 18 May 2005 04:05:25 +1000 (EST)
Received: by rproxy.gmail.com with SMTP id g11so1643105rne
	for <linuxppc-embedded@ozlabs.org>;
	Tue, 17 May 2005 11:05:24 -0700 (PDT)
Message-ID: <61cc712d05051711057f89b7d4@mail.gmail.com>
Date: Tue, 17 May 2005 11:05:24 -0700
From: Kylo Ginsberg <kylo.ginsberg@gmail.com>
To: Wolfgang Denk <wd@denx.de>
In-Reply-To: <20050517081558.74BA0C1512@atlas.denx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
References: <428995CB.4050301@compulab.co.il>
	<20050517081558.74BA0C1512@atlas.denx.de>
Cc: linuxppc-embedded@ozlabs.org
Subject: Re: MPC885 - USB HCI drivers.
Reply-To: Kylo Ginsberg <kylo.ginsberg@gmail.com>
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

On 5/17/05, Wolfgang Denk <wd@denx.de> wrote:
> Dear Mike,
>=20
> in message <428995CB.4050301@compulab.co.il> you wrote:
> >
> > Do you know if the same is applicable to CPM2 USB controllers present
> > for example on mpc8247?
>=20
> Sorry, I don't know from personal experience. But from what  I  heard
> there might be some "surprises", too.

Thanks for all the feedback.  If we set our sights lower and only aim
to use the CPM USB as a device (specifically an alternative serial
console), similar warnings of "surprises"?  Any source out there for
this purpose?  (I'm inclined to just use a 232-usb converter off a
uart and make it transparent to the target s/w.)

Also, I failed to find app notes or usb-specific errata on the
freescale site.  Perhaps they're tucked away under a specific
processor without a suggestive title?

Kylo
