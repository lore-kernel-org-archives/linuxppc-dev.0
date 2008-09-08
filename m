Return-Path: <scottwood@freescale.com>
Received: from de01egw02.freescale.net (de01egw02.freescale.net
	[192.88.165.103])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "de01egw02.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 62D5EDDDFF
	for <linuxppc-dev@ozlabs.org>; Tue,  9 Sep 2008 02:07:43 +1000 (EST)
Received: from az33smr01.freescale.net (az33smr01.freescale.net [10.64.34.199])
	by de01egw02.freescale.net (8.12.11/de01egw02) with ESMTP id
	m88G7YPB007049
	for <linuxppc-dev@ozlabs.org>; Mon, 8 Sep 2008 09:07:35 -0700 (MST)
Received: from ld0162-tx32.am.freescale.net (ld0162-tx32.am.freescale.net
	[10.82.19.112])
	by az33smr01.freescale.net (8.13.1/8.13.0) with ESMTP id m88G3ZeF014593
	for <linuxppc-dev@ozlabs.org>; Mon, 8 Sep 2008 11:03:35 -0500 (CDT)
Date: Mon, 8 Sep 2008 11:03:34 -0500
From: Scott Wood <scottwood@freescale.com>
To: Wolfgang Grandegger <wg@grandegger.com>
Subject: Re: [PATCH] powerpc/44x: Add hwmon support to Sequoia device tree
Message-ID: <20080908160332.GA12679@ld0162-tx32.am.freescale.net>
References: <200809041155.02927.matthias.fuchs@esd-electronics.com>
	<20080905160017.GA22310@ld0162-tx32.am.freescale.net>
	<20080905201703.0586e131@lappy.seanm.ca>
	<200809061440.41629.matthias.fuchs@esd-electronics.com>
	<48C29CA3.80806@grandegger.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <48C29CA3.80806@grandegger.com>
Cc: Sean MacLennan <smaclennan@pikatech.com>, linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Sat, Sep 06, 2008 at 05:07:15PM +0200, Wolfgang Grandegger wrote:
> How about "dtt"? That's what we use in U-Boot for digital temperature
> sensors as well.

I vote against any acronyms that are not very well known.  Even knowing
that it's supposed to be "digital temperature <something>", I can't
figure out what the <something> is.  Not having the context that it
relates to temperature, I wouldn't have a clue what "dtt" is.

hwmon is concise and fairly obvious, and unlike "temp" could be
meaningfully used with chips that also monitor voltages, fan speeds, etc.

-Scott
