Date: Wed, 11 Jun 2003 10:29:23 -0500
From: Chris Zimman <chris@cryptoapps.com>
To: Christophe.LINDHEIMER@fr.thalesgroup.com
Cc: linuxppc-embedded@lists.linuxppc.org, jjboor@sun023.aimsys.nl
Subject: Re: About MTD.
Message-ID: <20030611152923.GB9573@dingdong.cryptoapps.com>
Reply-To: Chris Zimman <chris@cryptoapps.com>
References: <D96E2AFA0DF3D211B139009027454948034CBDF7@helios.gnv.tcc.thomson-csf.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <D96E2AFA0DF3D211B139009027454948034CBDF7@helios.gnv.tcc.thomson-csf.com>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


On Wed, Jun 11, 2003 at 02:45:37PM +0200, Christophe.LINDHEIMER@fr.thalesgroup.com wrote:
>
> I am trying to use MTD on my board.
>
> I have two flash AMD LV160BB that are configured in 16 bits.
>
> They are in parallel so I have got a 32 bits bus wide.
>
> Each flash is 2 Mo . So the total is 4 Mo.
>
> My flash starts at @ : 0x04000000.
>
> So in the configuration for Linux I set
> 	CFI : yes
> 	Start @ : 0x04000000
> 	Size : 0x00400000
> 	Bus Width : 4
>
> The result at the boot is :
>
> physmap flash device: 400000 at 4000000
>  Amd/Fujitsu Extended Query Table v1.0 at 0x0040
> number of JEDEC chips: 1
> 0: offset=0x0,size=0x8000,blocks=1
> 1: offset=0x8000,size=0x4000,blocks=2
> 2: offset=0x10000,size=0x10000,blocks=1
> 3: offset=0x20000,size=0x20000,blocks=31
> mtd: Giving out device 0 to Physically mapped flash

Can you send along the snippet of code from your config?

> Is it correct ?
> Why is there only one JEDEC Chip detected ?

I'm guessing that the two flash parts are only using 1 chip select for
both.  If that's the case, it would make sense to me.

--Chris

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
