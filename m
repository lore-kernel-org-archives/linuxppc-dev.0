Date: Fri, 23 Apr 1999 09:44:59 -0700 (MST)
From: Matt Porter <mmporter@home.com>
To: Simone Piccardi <Simone.Piccardi@fi.infn.it>
cc: Gabriel Paubert <paubert@iram.es>,
        linuxppc-dev <linuxppc-dev@lists.linuxppc.org>
Subject: Re: A still not working, but cross-compiled kernel
In-Reply-To: <37209E59.BE289D2E@fi.infn.it>
Message-ID: <Pine.LNX.3.96.990423094048.10741A-100000@liberty.chnd1.az.home.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Fri, 23 Apr 1999, Simone Piccardi wrote:
> Next problem is to get the ethernet working: I tries to change the
> ethernet setting as suggested; the output of the SROM command is this:
> 
> PPC4-Bug>srom
> 
> Device Address =$00007000 (N/Y)? y
> Reading SROM into Local Buffer.....
> $00 (&000) 0000?
> $02 (&002) 0000?
> $04 (&004) 0000?
> $06 (&006) 0000?
> $08 (&008) 0000?
> $0A (&010) 0000?
> $0C (&012) 0000?
> $0E (&014) 0000?
> $10 (&016) AF00?
> $12 (&018) 0301?
> $14 (&020) 0800?
> $16 (&022) 3E28?
> $18 (&024) 2800?
> $1A (&026) 0E1E?
> $1C (&028) 0000?
> $1E (&030) 0008?	<---- Is this one?

Nope, that's the conntion type location 0x800 is AutoSense...don't change
that.

> $20 (&032) 0193?
> $22 (&034) 0308?

Use $22 (&034) 0300
This octet indicates PHY index and must start at zero.

> $24 (&036) 0003?
> $26 (&038) 0108?
> $28 (&040) 0000?
> $2A (&042) 0100?
> $2C (&044) 0078?
> $2E (&046) E001?
> $30 (&048) 0050?
> $32 (&050) 0018?

--
Matt Porter
mmporter@home.com
This is Linux Country. On a quiet night, you can hear Windows reboot.


[[ This message was sent via the linuxppc-dev mailing list.  Replies are ]]
[[ not  forced  back  to the list, so be sure to Cc linuxppc-dev if your ]]
[[ reply is of general interest. Please check http://lists.linuxppc.org/ ]]
[[ and http://www.linuxppc.org/ for useful information before posting.   ]]
