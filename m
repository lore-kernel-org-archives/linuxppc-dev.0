Date: Wed, 17 Apr 2002 08:36:18 -0700
From: Matt Porter <mporter@mvista.com>
To: "Wright, David" <dwright@infiniswitch.com>
Cc: linuxppc-embedded@lists.linuxppc.org
Subject: Re: Anyone got eepro100 working on Walnut?
Message-ID: <20020417083618.B15647@home.com>
References: <FF6CF34C346E724596A2FB5CAAB2C4978844FF@voyager.ops.infiniswitch.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <FF6CF34C346E724596A2FB5CAAB2C4978844FF@voyager.ops.infiniswitch.com>; from dwright@infiniswitch.com on Tue, Apr 16, 2002 at 09:08:41PM -0400
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


On Tue, Apr 16, 2002 at 09:08:41PM -0400, Wright, David wrote:
>
> I've been trying to get an Intel eepro100 card working on a
> Walnut board.  I've tried both the 1.09 and 1.19 versions of
> the driver (eepro100.c).  Initially, both failed the self-
> test step.  I was able to get past that one by invalidating
> the dcache after issuing the self-test directive.  However,
> I now find that the card is neither transmitting nor receiving
> reliably.  I get messages like:
>
>    eth1: Unknown receiver error, status=0x5048.  [lots of these]
>
> and
>
> eth1: Transmit timed out: status 0050  0000 at 2/8 commands 00a00300 00a003000.
> eth1: Restarting the chip...
> eth1: Command unit failed to mark command 00030000 as complete at 6.
>
>
> Any suggestions (other than junking this card, which is not an option
> for me) most welcome.

Sounds like you have a buggy kernel since it looks like cache
coherency problems.  By the revision of the eepro100 driver you
are using, it sounds ancient too.

Try running the 2_4_devel kernel.  The current eepro100 driver
works fine for me on a 440 so you shouldn't have a problem
assuming that the walnut port is working.

Regards,
--
Matt Porter
MontaVista Software, Inc.
mporter@mvista.com

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
