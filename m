Subject: Re: wdt_mpc8xx documentation
From: Andreas Oberritter <obi@saftware.de>
To: Robin Gilks <robin.gilks@tait.co.nz>
Cc: linuxppc-embedded@lists.linuxppc.org,
	Tom Rini <trini@kernel.crashing.org>
In-Reply-To: <3FE12DCD.10609@tait.co.nz>
References: <3FE12DCD.10609@tait.co.nz>
Content-Type: text/plain
Message-Id: <1071726766.3533.11.camel@shiva.eth.saftware.de>
Mime-Version: 1.0
Date: Thu, 18 Dec 2003 06:52:46 +0100
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Hi Robin,

Have a look at our driver, which uses the kernel's watchdog api:
http://cvs.tuxbox.org/cgi-bin/viewcvs.cgi/*checkout*/tuxbox/cdk/Patches/linux-2.4.23-pre6-m8xxwdt.diff?rev=HEAD&content-type=text/plain

It will probably never get into vanilla 2.4 because Marcelo doesn't
respond to my Emails. However, it is really stable since months...
What other driver were you talking about?

Tom, would you put this driver into the 2.4 ppc trees if I rediffed it?

Regards,
Andreas



On Thu, 2003-12-18 at 05:32, Robin Gilks wrote:
> Greetings
>
> Whilst rummaging about the PPC development tree I came across the
> Siemens/SGI/Denx watchdog driver for the mpc8xx. It references a man
> page which so far I've not been able to find (man wdt_mpx8xx(4)) so I'm
> a bit clueless about what the monitor chain code does.
>
> It doesn't seem to relate to the generic watchdog_api.txt in the kernel
> documentation (at least the defines don't seem to tie in with any of the
>   ioctl options).
>
> Any help here appreciated.
>
> --
> Robin Gilks
> Senior Design Engineer          Phone: (+64)(3) 357 1569
> Tait Electronics                Fax  :  (+64)(3) 359 4632
> PO Box 1645 Christchurch        Email : robin.gilks@tait.co.nz
> New Zealand
>
>
>


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
