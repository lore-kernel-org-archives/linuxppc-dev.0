Message-ID: <3CBD97FC.1060503@pacbell.net>
Date: Wed, 17 Apr 2002 08:42:52 -0700
From: Armin <akuster@pacbell.net>
MIME-Version: 1.0
To: "Wright, David" <dwright@infiniswitch.com>
Cc: linuxppc-embedded@lists.linuxppc.org
Subject: Re: Anyone got eepro100 working on Walnut?
References: <FF6CF34C346E724596A2FB5CAAB2C4978844FF@voyager.ops.infiniswitch.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Wright, David wrote:
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
>
>   -- David Wright, InfiniSwitch Corp.
>
>
>
>

Yes,

What kernel version are you using? and what is the openbios version ?

armin


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
