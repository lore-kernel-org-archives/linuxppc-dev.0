Subject: Re: mpc8xx CPM timer usage
From: Albert ARIBAUD <albert.aribaud@free.fr>
To: Linuxppc-Embedded <linuxppc-embedded@lists.linuxppc.org>
In-Reply-To: <3F5562F5.7070101@tait.co.nz>
References: <3F5562F5.7070101@tait.co.nz>
Content-Type: text/plain; charset=ISO-8859-15
Message-Id: <1062567088.1998.14.camel@lilith>
Mime-Version: 1.0
Date: 03 Sep 2003 07:32:21 +0200
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Le mer 03/09/2003 à 05:41, Robin Gilks a écrit :
> Greetings
>
> Does anyone know of any 'standard' Linux drivers that make use of any of
> the 4 CPM timers?

When I used the DENX ELDK kernel on a custom MPC8XX board with serial
lines and Ethernet mostly, I once found no driver *used by the project*
that used the CPM timers. Note that we wrote our own SPI bus code,
though.

Your best bet is to check arch/ppc/8xx_io/*.[chS].

> I just want to check before the hardware guys caste our i/o lines into
> stone :-))

<ot>
Why bother, since anyway they'll cast them the wrong way around?
</ot>

:)

> Many thanks

HTH,
--
Albert ARIBAUD <albert.aribaud@free.fr>


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
