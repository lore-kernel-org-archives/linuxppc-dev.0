Message-ID: <3A8C1B99.2DAE3B2E@mvista.com>
Date: Thu, 15 Feb 2001 13:10:33 -0500
From: Dan Malek <dan@mvista.com>
MIME-Version: 1.0
To: Subodh Nijsure <SNijsure@SkyStream.com>
CC: linuxppc-embedded@lists.linuxppc.org
Subject: Re: How does one get physical address for iorempped window?
References: <B25E2E5A003CD311B61E00902778AF2A0148B711@SERVER1>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Subodh Nijsure wrote:

> ....When I used virt_to_phys() on the addresse
> ioremap() I was not getting back the original physical address.
> Hence the question.

OK.  Worded differently from my previous message.....virt_to_phys()
won't work properly on any dynamically mapped space.......


	-- Dan

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
