Subject: RE: kernel can't boot
From: Gary Thomas <gary@mlbassoc.com>
To: kamarajp@future.futsoft.com
Cc: "'Wolfgang Denk'" <wd@denx.de>,
	linuxppc embedded <linuxppc-embedded@lists.linuxppc.org>
In-Reply-To: <003a01c3cdc1$008e16c0$6704060a@future.futsoft.com>
References: <003a01c3cdc1$008e16c0$6704060a@future.futsoft.com>
Content-Type: text/plain
Message-Id: <1072707167.13356.1.camel@hermes>
Mime-Version: 1.0
Date: 29 Dec 2003 07:12:47 -0700
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


On Sun, 2003-12-28 at 21:05, Kamaraj P wrote:
> Hi All,
> I am using RedBoot in IXP425 Board (Embedded Linux).
> Whether this environment settings are specific to U-Boot ?? If I am using
> RedBoot, How can I debug the kernel Image.
> Is there any FAQ available.
>

Perhaps you should be asking these questions on an ARM Linux list.
This list, and its members, concentrate mostly on PowerPC based
systems and the software that support them.

>
> Thanks in Advance.
> Kamaraj.
>
> -----Original Message-----
> From: owner-linuxppc-embedded@lists.linuxppc.org
> [mailto:owner-linuxppc-embedded@lists.linuxppc.org]On Behalf Of Wolfgang
> Denk
> Sent: Friday, December 26, 2003 3:56 PM
> To: sun-zj
> Cc: linuxppc-embedded@lists.linuxppc.org
> Subject: Re: kernel can't boot
>
>
>
> In message <200312260052.SAA27783@lists.linuxppc.org> you wrote:
> >
> > I am using the ELDL-2.1 from denx(Thanks their hard works)
> > and the recent kernel advised by Denk(thanks a lots). I compile
> > it and download it by tftp with FEC ethernet.
> > I use the FADS board and U-boot-1.0.0. The eldk enclosed
> > kernel-2.4.4 works fine. But kernel-2.4.23 can go to the stage
> > of Uncompressed kernel image OK. and then system Hangs there
> > without any messages?
>
> Probably the kernel received invalid parameters (clock information).
>
> > Who can tell me what happens ?
>
> You did not read the FAQ. See
> http://www.denx.de/twiki/bin/view/DULG/LinuxHangsAfterUncompressingKernel
>
> Best regards,
>
> Wolfgang Denk
>
> --
> Software Engineering:  Embedded and Realtime Systems,  Embedded Linux
> Phone: (+49)-8142-4596-87  Fax: (+49)-8142-4596-88  Email: wd@denx.de
> Ernest asks Frank how long he has been working for the company.
>         "Ever since they threatened to fire me."
>
>
--
Gary Thomas <gary@mlbassoc.com>
MLB Associates


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
