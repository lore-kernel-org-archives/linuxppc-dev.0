From: "Stefan Roese" <stefan.roese@esd-electronics.com>
To: "David Gibson" <david@gibson.dropbear.id.au>,
	<linuxppc-embedded@lists.linuxppc.org>
Subject: Re: ppc4xx_serial.c?
Date: Thu, 14 Feb 2002 09:46:06 +0100
Message-ID: <EFEAIMDCOOOHIEPHDNFJAEOCDKAA.stefan.roese@esd-electronics.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
In-reply-to: <20020214053008.GY1133@zax>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


> Is arch/ppc/kernel/ppc4xx_serial.c of any relevance any more?  It
> doesn't include any code unless CONFIG_DEBUG_BRINGUP is defined, and
> it doesn't look like it would compile, let alone be called, if it was
> defined.

That was also my impression. It seems, that this file could be removed.

Stefan.


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
