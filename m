Message-ID: <3F68769C.1010000@embeddededge.com>
Date: Wed, 17 Sep 2003 10:58:36 -0400
From: Dan Malek <dan@embeddededge.com>
MIME-Version: 1.0
To: joakim.tjernlund@lumentis.se
Cc: Jean-Denis Boyer <jdboyer@m5t.com>,
	Steffen Rumler <Steffen.Rumler@siemens.com>,
	linuxppc <linuxppc-embedded@lists.linuxppc.org>
Subject: Re: Problem of concurrency in arch/ppc/8260_io/uart.c
References: <IGEFJKJNHJDCBKALBJLLOEFNFPAA.joakim.tjernlund@lumentis.se>
Content-Type: text/plain; charset=us-ascii; format=flowed
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Joakim Tjernlund wrote:

> I am taking a stab at my_console_write() as well. I have something that works well
> for me, but i am unsure if I have broken KGDB/XMON support.

You better check it.  The reason for all of the complexity in there is to
support that.  Lots of time was spent making kgdb/xmon work correctly, and
to break it or toss it away would kinda piss me off.

> ....In my new my_console_write()
> I must know the length of the TX buffer in the TXBD.

Why?

> ...But what is the TX buffer length before serial_console_setup has run(that's
> when KGB/XMON is active)?

Whatever the boot rom initializes.


	-- Dan


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
