Message-ID: <3AF827ED.88ABED6E@mvista.com>
Date: Tue, 08 May 2001 10:07:57 -0700
From: Matthew Locke <mlocke@mvista.com>
MIME-Version: 1.0
To: Arturo Nunez <artnpp@cs.ucf.edu>
Cc: linuxppc-embedded <linuxppc-embedded@lists.linuxppc.org>
Subject: Re: Wireless Advice
References: <200105081540.LAA10976@iris.cs.ucf.edu>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Arturo Nunez wrote:
>
> Hello:
>         I have the following board:
>
>         RPX CLLF
>         Cpu:XPC860TZ
>
>         From Embbeded Planet.
>
>         Now, I need to do some research in Wireless, I was thinking to use one of these cards:
>
>         -       Cisco Aironet 340 Series Card  or
>         -       Linksys WPC11
>

Cisco 340 works great.  Wavelan also works.  I have not tried the
Linksys card.  the 340 and wavelan work out of the box with the latest
pcmcia-cs package.  Er, actually, the last change I sent to Dave Hinds
broke it.  I will be fixing that shortly.

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
