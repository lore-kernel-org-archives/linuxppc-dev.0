Message-ID: <3E2E5EC8.8040805@devcom.cz>
Date: Wed, 22 Jan 2003 10:05:12 +0100
From: Jan Damborsky <Jan.Damborsky@devcom.cz>
MIME-Version: 1.0
To: Wolfgang Denk <wd@denx.de>
Cc: linuxppc-embedded@lists.linuxppc.org
Subject: Re: Problem with data cache on MPC823E
References: <20030121194946.43F24C608E@atlas.denx.de>
Content-Type: text/plain; charset=us-ascii; format=flowed
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


>
>
>This pheomenon is typical for bad SDRAM initialization. Read the chip
>manufacturer's manual and follow  the  steps  of  the  init  sequence
>_to_the_letter_. It is _not_ sufficient to set up the UPM tables.
>
>Best regards,
>
>Wolfgang Denk
>
>
>
But we dont use SDRAM, but DRAM EDO SIMM module. I think these RAM types
dont require special initialization.

Thanks,
Jan Damborsky


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
