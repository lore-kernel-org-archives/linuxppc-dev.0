Subject: RE: CPM interrupts raised to early? (was More I2C stuff,) 
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Date: Tue, 30 Oct 2001 10:01:55 -0000
Message-ID: <EADB10BAC266A14A85ECBF8686A73E31459362@kolkrabbi.flaga.is>
From: =?iso-8859-1?B?S+FyaSBEYXbt8HNzb24=?= <kd@flaga.is>
To: "Joakim Tjernlund" <Joakim.Tjernlund@lumentis.se>
Cc: <linuxppc-embedded@lists.linuxppc.org>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Hi,

> -----Original Message-----
> From: Joakim Tjernlund [mailto:Joakim.Tjernlund@lumentis.se]
> Sent: 29. október 2001 21:46
> To: Kári Davíðsson
> Cc: linuxppc-embedded@lists.linuxppc.org
> Subject: RE:CPM interrupts raised to early? (was More I2C stuff,)
>
>
> Hi Kari
>
> This rings a bell in my mind. There is(was?) a line early in
> the irq routine
> where i2cmod(?) is disabled(there is a comment that states

Yes there is. The interrupt are also enabled in the read() and write()
due to some chip errate.

> that this is
> due to some chip errata).
>
> First a commeted this line and my I2C was starting to work. Later
> I moved it to someplace directly after IRQ context and now my I2C is
> working fine. Do you know what this "chip errata" referes to? I could
> not find any reference to this in any Motorola doc.

No I have not found this errata.

>
> If you want, I can send you my version of the i2c-algo-8xx.c
> driver(I am at
> home
> now and don't have access to the driver now)

Thanks, I appriciate that.
A diff is fine too.

Regards,

K.D.
>
>    Regards
>                Joakim Tjernlund
> PS.
>       I am also using motorola I2C microcode patch
>
>

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
