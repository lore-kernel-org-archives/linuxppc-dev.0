Message-ID: <3B3A0E58.7E41C368@mvista.com>
Date: Wed, 27 Jun 2001 09:48:24 -0700
From: "Mark A. Greer" <mgreer@mvista.com>
MIME-Version: 1.0
To: Neil Wilson <NWILSON@Airspan.com>
Cc: "'linuxppc-embedded@lists.linuxppc.org'" <linuxppc-embedded@lists.linuxppc.org>
Subject: Re: Sandpoint 3 + MPC7450 + HHL2
References: <E69FF45ADA3BD511A25900047623CC4F12AA74@JUPITER>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Neil Wilson wrote:

> Hi,
>
> I managed to get the JourneyMan 2 82XX booting up on my Sandpoint3 MPC7450 -
> after adding a enable for the TimeBase - however when a ramdisk is mounted
> up I get very slow serial response, like several seconds to print a string,
> does anyone have some ideas of what I could look at to resolve this, I have
> an Abatron bdi etc but a lot of this is new to me so any help would be very
> welcome. Thanks.

I'll virtually guarantee you that its an interrupt-related problem.  Either the
routing is wrong or the IRQ isn't enabled or...

Mark


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
