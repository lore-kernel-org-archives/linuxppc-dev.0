Message-ID: <3A59EA33.B7C7187F@snmc.com>
Date: Mon, 08 Jan 2001 10:26:28 -0600
From: Daris Nevil <dnevil@snmc.com>
MIME-Version: 1.0
To: "Bernal, Fernando J" <fernando.bernal@eds.com>
CC: "'linuxppc-embedded@lists.linuxppc.org'"
 <linuxppc-embedded@lists.linuxppc.org>
Subject: Re: SCC and SMC Implementation
References: <7A62AD36B644D411B0E500508BDF0CECF1245C@usahm016.exmi01.exch.eds.com>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


F.J.,

SNMC has implement both SMC and SCC serial drivers for the MPC850.  The drivers

seem to work for the MPC823 as well, although we have not done extensive
testing
for the 823.

You can download the sources from ftp.qslinux.org (documentation on
www.qslinux.org).

The drivers can be found in the directory snmc/qslinux/drivers/char.

Regards,
Daris Nevil


"Bernal, Fernando J" wrote:

> I would like to know if someone has implemented the two SMC and the two SCC
> serial ports on an embedded 823 PowerPC.
>
> F.J. Bernal
>


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
