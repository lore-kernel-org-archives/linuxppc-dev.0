Message-ID: <3A5CE4C5.E59163A1@mvista.com>
Date: Wed, 10 Jan 2001 17:40:05 -0500
From: Dan Malek <dan@mvista.com>
MIME-Version: 1.0
To: "Gessner, Matt" <mattg@aiinet.com>
CC: "'Linux PPC'" <linuxppc-embedded@lists.linuxppc.org>
Subject: Re: 860P FEC and fec driver from 2.3?
References: <7283DE19D141D111AD0E00A0C95B195502581E68@mail2.aiinet.com>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


"Gessner, Matt" wrote:
>
> Do this work?  I've got someone here who's got the LXT970 PHY
> and the thing doesn't work with the driver from 2.3 I've got.
> Has it changed?

There have been some changes through the course of 2.3 and 2.4.
I think Wolfgang Denk finally fixed the FEC driver so it can be
use in 2.4.  Some of the software modifications were driver
interface related, and I made a couple because the MII pin
configuration changed with > Rev. C of the parts.

The 860P certainly works, I use one almost every day for some
kind of network activity.


	-- Dan

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
