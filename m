Message-ID: <F1BED55F35F4D3118C0F00E0295CFF4DFFA00B@mail.mediatrix.com>
From: Jean-Denis Boyer <jdboyer@mediatrix.com>
To: "'Gabriel Paubert'" <paubert@iram.es>
Cc: Troy Benjegerdes <hozer@drgw.net>,
	Benjamin Herrenschmidt <benh@kernel.crashing.org>,
	linuxppc-embedded@lists.linuxppc.org,
	Paul Mackerras <paulus@samba.org>
Subject: RE: Bogomips and loops_per_jiffy
Date: Fri, 10 May 2002 10:46:07 -0400
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Gabriel,


Warning: real time clock seems stuck!
> -----Original Message-----
> From: Gabriel Paubert [mailto:paubert@iram.es]
> Sent: 10 mai, 2002 10:29
> To: Jean-Denis Boyer
> Cc: Troy Benjegerdes; Benjamin Herrenschmidt;
> linuxppc-embedded@lists.linuxppc.org; Paul Mackerras
> Subject: RE: Bogomips and loops_per_jiffy
>
>
>
>
> On Fri, 10 May 2002, Jean-Denis Boyer wrote:
>
> >
> > Grabiel,
> >
> > > I'm afraid that this is a symptom of lost timekeeping
> > > after reading the RTC and that you simply cure the symptom.
> >
> > My platform uses an 8260 processor, and AFAIK there is no
> RTC. The function
> > __USE_RTC() returns 0.
>
> OOPs, sorry for the confusion, by RTC I meant the chip with a battery
> which keeps time across reboots and that we read to initially set the
> system time.
>
> 	Gabriel.
>
>

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
