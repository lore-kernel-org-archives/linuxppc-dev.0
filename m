Message-ID: <3CEA0F45.BDBBA25@etx.ericsson.se>
Date: Tue, 21 May 2002 11:11:33 +0200
From: Kenneth Johansson <kenneth.johansson@etx.ericsson.se>
MIME-Version: 1.0
To: andrew may <acmay@acmay.homeip.net>
Cc: linuxppc-embedded@lists.linuxppc.org,
	Armin Kuster <akuster@mvista.com>
Subject: Re: [PATCH] ibm ocp gpio
References: <20020520182657.B17318@ecam.san.rr.com>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


andrew may wrote:
>
> The most common thing I want to use the GPIO pins for is
> simple lighting of some LED's. I decided to roll in some timers
> into the generic GPIO driver rather than haveing each user of the
> GPIO driver be forced to do some form of timers to get a usable
> LED visual as well.
>
> I think I got the timer stuff correct but I am not sure.
> I didn't bother cleaning it up until I get some feedback on it.
>
>   -----------------------------------------------------------------------------
>                     Name: gpio.patch.gz
>    gpio.patch.gz    Type: unspecified type (application/octet-stream)
>                 Encoding: base64

I don't think we should add this It's not really something that needs to be
done in the driver. Also you have not exported this functionality to
userspace.


--
Kenneth Johansson
Ericsson AB                       Tel: +46 8 404 71 83
Borgafjordsgatan 9                Fax: +46 8 404 72 72
164 80 Stockholm                  kenneth.johansson@etx.ericsson.se

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
