From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: <msokolov@ivan.Harhan.ORG>, <linuxppc-dev@lists.linuxppc.org>
Subject: Re: CONFIG_GENERIC_PPC32
Date: Sun, 7 Apr 2002 00:29:40 +0100
Message-Id: <20020406232941.774@smtp.wanadoo.fr>
In-Reply-To: <0204062217.AA17328@ivan.Harhan.ORG>
References: <0204062217.AA17328@ivan.Harhan.ORG>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


>(This doesn't mean that having such wrapper is the RTTD or that the vmlinux
>boot ABI inherently has to change all the time. It is perfectly possible
>technically to fix the vmlinux boot ABI, keep it stable, and eliminate all
>those wrappers. But that would require a revolution to oust the current
>tyrants
>with a strangehold on write access to the mainline tree and let people with
>more progressive minds in.)

heh, well, I for one thinks the PPC tree hasn't a strong enough tyrant ;)

>> I don't plan to include Michael boards in it, I want to rework
>> our ground to match what Michael does and then let him drop in his new
>> boards.
>
>I don't have my own boards yet. In my tree I used the Adirondack, EV-64260A,
>and K2 ports to prove the CONFIG_GENERIC_PPC32 implementation. EV-64260A is
>Galileo's reference board for the GT-64260A system controller, and Adirondack
>and K2 are SBS boards already supported in 2_4_devel. I'm not at SBS any more
>and don't have their hardware, but those boards are still fresh in my
head and
>I needed a few ports to prove my generic PPC32 implementation.

Ok.


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
