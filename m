Message-ID: <3941259C.4E2F9B32@embeddededge.com>
Date: Fri, 09 Jun 2000 13:13:00 -0400
From: Dan Malek <dan@netx4.com>
MIME-Version: 1.0
To: Kim Jørgensen <KIJ@infocom.dk>
CC: "'linuxppc-embedded@lists.linuxppc.org'"
 <linuxppc-embedded@lists.linuxppc.org>
Subject: Re: Changes in the MPC8xx I2C driver
References: <819E3E914E0AD11194DE00805F0D100B0138B86C@fbi.infocom.dk>
Content-Type: text/plain; charset=iso-8859-1
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Kim Jørgensen wrote:

> I have made some changes in the MPC8xx I2C driver, mainly adding write
> support and making the driver re-entrant.

Looks pretty good.  I will add it to kernel sources.

> I don't use the minor number for the device address,

Did you investigate the Linux I2C implementation?  I never did, but
perhaps it would be worthwhile to make this look like that at least
to an application.

> I have removed all of the microcode relocation code in the driver, as I
> couldn't make the driver work with this code and I had no need for applying
> the patch.

That is fine.  I could never make it work either.  I have had some
discussions with others about this, but no solution yet.


> I made some clumsy code for converting offset to internal address, maybe
> some one can tell me how to make this in a simpler way?

The challenge is some devices need this address, others don't.  What
you have seems fine.  After we use it for a while maybe we can find
something better.

Thanks.


	-- Dan

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
