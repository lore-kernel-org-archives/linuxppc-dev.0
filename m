Message-ID: <3BFC1D51.6090808@oerlikon.ca>
Date: Wed, 21 Nov 2001 16:32:01 -0500
From: "sruel@oerlikon.ca" <sruel@oerlikon.ca>
MIME-Version: 1.0
To: Ken Applebaum <applebaumk@embeddedplanet.com>,
	linuxppc-embedded@lists.linuxppc.org, Wolfgang Denk <wd@denx.de>
Subject: Re: eth1 FEC on RPX-CLLF info: Bingo!
References: <D73A25AA6E54D511AD74009027B1110F04F6C3@ORION>
Content-Type: text/plain; charset=us-ascii; format=flowed
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Bingo!
FEC is now working!

Bit 16 & 17 of BCSR2 register needed to be = '1' to activate the MII
transceiver.
Thank's Wolfgang and Ken for your info.

Ken Applebaum wrote:

>wolfgang, as usual!, is right on. Sebastien, look at page 15 of the CLLF
>manual. That should give you the info you need.
>
>Ken
>


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
