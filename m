In-Reply-To: <Pine.LNX.4.60.0407081642170.12139@localhost.localdomain>
References: <Pine.LNX.4.60.0407081642170.12139@localhost.localdomain>
Mime-Version: 1.0 (Apple Message framework v618)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <2A282E52-D123-11D8-8B61-000393DBC2E8@freescale.com>
Cc: Embedded Linux PPC list <linuxppc-embedded@lists.linuxppc.org>
From: Kumar Gala <kumar.gala@freescale.com>
Subject: Re: confusion re: CPM2 and 8xxx
Date: Thu, 8 Jul 2004 16:09:56 -0500
To: "Robert P. J. Day" <rpjday@mindspring.com>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


I think this is due to the config file just not getting updated.  The
driver for the uart on CPM1 (8xx) and CPM2 (82xx/85xx) is the same
code.  It started as a driver for only CPM2 and thus the config options
reference CPM2.  Will make a note to cleanup the config file for the
driver

- kumar

On Jul 8, 2004, at 3:53 PM, Robert P. J. Day wrote:

>
>   there's some confusion (well, ok, just me) regarding kernel config
> settings in the linuxppc-2.5 tree.  when i select a processor type, i
> see that i have a number of choices, including
>
>   ...
>   8xx
>   ...
>   6xx/7xx/74xx/8260
>   ...
>
> so far, so good.  so i select 8xx and, later, under
>
>   Device drivers
>     Character devices
>       Serial drivers
>
>   ...
>   <*> CPM2 SCC/SMC serial port support
>   [*] Support for console on CPM2 SCC/SMC serial port
>
> according to the help on that first option:
>
>     This driver supports the SCC and SMC serial ports on Motorola
>     embedded PowerPC that contain a CPM2 (8xxx) or a CPM1 (8xx)
>
> given that i explicitly selected 8xx, i don't think i should be
> presented with any options related to an 8xxx platform (that is,
> anything saying "CPM2").  yes, it's picky, but the first time i did
> this, i sat there thinking, "i know CPM, but what the heck is this
> CPM2 thing, and what does it have to do with an 8xx platform?"
>
>   thoughts?
>
> rday
>
> p.s. it's also a bit misleading since there are no options whatever in
> .config that contain the string "CPM2", in case you go grepping for
> them.
>
> p.p.s.  more pedantry to follow.
>


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
