Return-Path: <glikely@secretlab.ca>
Received: from mail-yw0-f181.google.com (mail-yw0-f181.google.com
	[209.85.211.181]) by ozlabs.org (Postfix) with ESMTP id 7959BB6F0A
	for <linuxppc-dev@ozlabs.org>; Tue, 22 Dec 2009 10:16:39 +1100 (EST)
Received: by ywh11 with SMTP id 11so6076281ywh.9
	for <linuxppc-dev@ozlabs.org>; Mon, 21 Dec 2009 15:16:38 -0800 (PST)
MIME-Version: 1.0
Sender: glikely@secretlab.ca
In-Reply-To: <4B2FF71E.10508@billgatliff.com>
References: <4B2FF71E.10508@billgatliff.com>
From: Grant Likely <grant.likely@secretlab.ca>
Date: Mon, 21 Dec 2009 16:16:18 -0700
Message-ID: <fa686aa40912211516u4a079693h74e39fd887cb421d@mail.gmail.com>
Subject: Re: Question on MPC52xx IRQ[123] pins
To: Bill Gatliff <bgat@billgatliff.com>
Content-Type: text/plain; charset=ISO-8859-1
Cc: Linux/PPC Development <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, Dec 21, 2009 at 3:30 PM, Bill Gatliff <bgat@billgatliff.com> wrote:
> gpio_get_value() on them. =A0There isn't any existing code that I can fin=
d
> that allows you to read the states of IRQ pins, be it under gpiolib or
> otherwise. =A0And I think the reason for that is that there's no way to
> actually read the states of those pins at all--- the hardware just
> doesn't work that way.

Correct.  IRQ2 can only be used as IRQ2.  It cannot be used a GPIO.
(Well, I suppose you *could* try to hack into the interrupt controller
driver and fetch the pin state that way; but I don't know if you can
read the state of masked out IRQ pins, and it sure would be ugly.)

g.

--=20
Grant Likely, B.Sc., P.Eng.
Secret Lab Technologies Ltd.
