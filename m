Return-Path: <segher@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id C745CDDE02
	for <linuxppc-dev@ozlabs.org>; Sun, 25 May 2008 09:06:36 +1000 (EST)
In-Reply-To: <fa686aa40805232219x7e888d80y394958f1c0a0fad0@mail.gmail.com>
References: <20080523182754.GA26891@polina.dev.rtsoft.ru>
	<20080523182842.GB469@polina.dev.rtsoft.ru>
	<fa686aa40805232219x7e888d80y394958f1c0a0fad0@mail.gmail.com>
Mime-Version: 1.0 (Apple Message framework v623)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <5779f808f6188a88231bf2a8c49e52d5@kernel.crashing.org>
From: Segher Boessenkool <segher@kernel.crashing.org>
Subject: Re: [RFC PATCH 2/2] mmc: add OpenFirmware bindings for the mmc_spi
	driver
Date: Sun, 25 May 2008 01:06:08 +0200
To: "Grant Likely" <grant.likely@secretlab.ca>
Cc: David Brownell <dbrownell@users.sourceforge.net>,
	Gary Jennejohn <garyj@denx.de>, linux-kernel@vger.kernel.org,
	linuxppc-dev@ozlabs.org, Guennadi Liakhovetski <g.liakhovetski@gmx.de>,
	Pierre Ossman <drzeus-mmc@drzeus.cx>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

>> +      Required properties:
>> +      - #address-cells : should be 0.
>> +      - #size-cells : should be 0.
>
> Are these properties required at all?  Will this node have any 
> children.

You mean, "does this node define a bus".  If it doesn't, there
shouldn't be #a and #s; if it does, the binding should describe
what the addressing is.  #a = #s = 0 describes a bus without any
addressing; pretty unusual :-)

>> +      - linux,mmc-ocr-mask : (optional) Linux-specific MMC OCR mask
>> +        (slot voltage).
>
> Should this property be better defined?

Yes please.  There's a good chance that it doesn't turn out to be
Linux-specific at all (after some modification, perhaps).


Segher
