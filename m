Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 10C91681BB
	for <linuxppc-dev@ozlabs.org>; Sat, 14 Jan 2006 08:57:29 +1100 (EST)
Subject: Re: [PATCH/RFC?] usb/input: Add support for fn key on Apple PowerBooks
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Dmitry Torokhov <dtor_core@ameritech.net>
In-Reply-To: <1137189319.4854.12.camel@localhost.localdomain>
References: <20051225212041.GA6094@hansmi.ch>
	<1137022900.5138.66.camel@localhost.localdomain>
	<20060112000830.GB10142@hansmi.ch>
	<200601122312.05210.dtor_core@ameritech.net>
	<1137189319.4854.12.camel@localhost.localdomain>
Content-Type: text/plain
Date: Sat, 14 Jan 2006 08:57:14 +1100
Message-Id: <1137189435.4854.15.camel@localhost.localdomain>
Mime-Version: 1.0
Cc: linux-kernel@killerfox.forkbomb.ch, linux-kernel@vger.kernel.org,
	linuxppc-dev@ozlabs.org, Vojtech Pavlik <vojtech@suse.cz>,
	linux-input@atrey.karlin.mff.cuni.cz
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Sat, 2006-01-14 at 08:55 +1100, Benjamin Herrenschmidt wrote:

> 
> > > +		try_translate = test_bit(usage->code, usbhid_pb_numlock)?1:
> > > +				test_bit(LED_NUML, input->led);
> > > +		if (try_translate) {
> > 
> > Isn't this the same as 
> > 
> > 		if (test_bit(usage->code, usbhid_pb_numlock) || test_bit(LED_NUML, input->led))
> > 
> > but harder to read?
> 
> No. If the first one is 0, the second one will not matter in the first
> version, while it will in yours.

Forget me, I'm stupid or rather I should finish by breakfast before
writing stupid things ;) Of course you are right, they are equivalent.

Ben.
