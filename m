Message-ID: <40E5E99B.2060006@mvista.com>
Date: Fri, 02 Jul 2004 16:02:51 -0700
From: "Mark A. Greer" <mgreer@mvista.com>
MIME-Version: 1.0
To: David Woodhouse <dwmw2@infradead.org>
Cc: linux-emb <linuxppc-embedded@lists.linuxppc.org>
Subject: Re: mv6360 support in mv64x60.c (was Re: GT64260_eth (Ethernet)	Driver)
References: <40E1E94B.9060204@mvista.com>	 <1088691201.14216.2977.camel@hades.cambridge.redhat.com>	 <40E4618A.902@mvista.com> <1088777061.14216.4449.camel@hades.cambridge.redhat.com>
In-Reply-To: <1088777061.14216.4449.camel@hades.cambridge.redhat.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


David Woodhouse wrote:

>On Thu, 2004-07-01 at 12:10 -0700, Mark A. Greer wrote:
>
>
>>FYI, look at the "PCI P2P Configuration" register
>>(MV64x60_PCI[01]_P2P_CONFIG (0x1d14/0x1d94)).  Apparently your firmware
>>sets the device number of your hoses to 3 for some reason (default is 0
>>for PCI, 0x1f for PCI-X).
>>
>>
>
>Aha -- that's what I spent my last quarter of an hour at work yesterday
>looking for in the documentation. Thanks.
>
>I made mv64x60_get_type() read the register in question and query the
>correct device for ident.
>
k

>
>Here's what I have working at the moment -- sorry, it's a bit untidy
>still but the weekend calls... :)
>
heh

>
>Don't look too hard at the board code yet; it's still a hacked up hybrid
>of your ev64260 code and the timesys 2.4 port.
>

Okay, I skimmed it an saw what you did.  I'll take a closer on Tues but
64x60 changes look okay (I'm assuming your gen550 & serial changes
aren't meant to go into this tree).

I just pushed an updated mpsc driver that works okay for me.  Well...the
first port does; the second port hangs the system but its good enough to
allow me to work on my 64360 boards.  I will fix the second port.

Thanks for the patch & have a good weekend.

Mark


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
