Date: Mon, 3 Jun 2002 15:19:57 -0700
From: Matt Porter <porter@cox.net>
To: sanjay k k <fren00@rediffmail.com>
Cc: linuxppc-embedded@lists.linuxppc.org
Subject: Re: 64 bit PCI qlogic + ebony + 440 kernel
Message-ID: <20020603151956.A13778@home.com>
References: <20020603213540.29797.qmail@webmail8.rediffmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20020603213540.29797.qmail@webmail8.rediffmail.com>; from fren00@rediffmail.com on Mon, Jun 03, 2002 at 09:35:40PM -0000
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


On Mon, Jun 03, 2002 at 09:35:40PM -0000, sanjay k k wrote:
>
> Hi,
> I have 64-bit PCI qlogic adapter , which works fine with 405 as it
> detects 32 bit on 405.
> When i tried to run the same code on ebony board with current 440
> kernel (development tree), it detects as a 32 bit PCI but gave all
> junk data.

I've tested ~14 different PCI(X) cards that all run fine.  I've
got 64-bit conventional PCI gige and PCI-X gige cards running
at 66-133Mhz with no problems.

Make sure you have the Ebony pci bus speed jumpers and firmware
speed settings set properly for your card, it can be a little
touchy sometimes.

> Do i need to change any thing in qlogic driver code for 440
> kernel?

You shouldn't.

Regards,
--
Matt Porter
porter@cox.net
This is Linux Country. On a quiet night, you can hear Windows reboot.

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
