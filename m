Message-ID: <8D7C5F56B409554D9D46AC22195807F3061C26@exchwenz01.dmcwave.co.nz>
From: Rod Boyce <rod_boyce@stratexnet.com>
To: "'Klaus Heydeck'" <Heydeck@kieback-peter.de>,
	"<" <linuxppc-embedded@lists.linuxppc.org>
Subject: RE: Antw: Re: Lauterbach ICD In-Circuit Debugger
Date: Thu, 23 Jan 2003 08:08:29 +1300
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


I have no experience with the Lauterbach debugger although when we were
looking to buy I obtained a quote for one.  While my quote is a few years
old the BDI2000 was 1/3 the price.  If you are looking to purchase a new
debugger then there is not contest.  The BDI works on Linux or Windows and
I'm yet to discover anything it can't do.
Even if you were going to buy a second debugger I would recommend the
BDI2000

Regards,
Rod Boyce.

 -----Original Message-----
From: 	Klaus Heydeck [mailto:Heydeck@kieback-peter.de]
Sent:	Thursday, 23 January 2003 5:48 a.m.
To:	<
Subject:	Antw: Re: Lauterbach ICD In-Circuit Debugger


>>
>> A lot of people suggest to use the Abatron BDI2000 as debug system. I
used
>> the Lauterbach TRACE32-ICD system with ARM processors without MMU (no
>> Linux) and it works extremely well.
>> The manufacturer claims it fully supports both the MMU and the Linux
kernel
>> (see here for more details
>> http://www.lauterbach.com/cgi-bin/docloc.pl?file=rtoslinux.pdf). Can
>> anybody who used it confirm this point?
>
>I can. You can debug the kernel and e.g. interrupts using virtual
>addresses very well, you just have to specify the mapping
>(e.g. for ppc map phys 0x00000000 to 0xc0000000)
>
>I've not looked in detail yet to debug user processes.
>
We are using the TRACE32-ICD (MPC8xx) with U-Boot and Kernel 2.4.4.
Kernel debugging works without any problems. User space debugging is also
fine - but only if you don't have to debug shared libraries :-(
I think the T32 is a very good choice for kernel debugging, especially if
you
have experience with the GUI and don t need the documentation or online help
;-)
If the problems with the shared libs are solved you have _one_ debugger for
kernel and applications.

Best regards,
Klaus Heydeck

--
Klaus Heydeck
Kieback & Peter GmbH & Co KG
Abt. Softwareentwicklung
Tempelhofer Weg 50
12347 Berlin / Germany
Tel. +49 30 60095 522
Fax. +49 30 60095 540


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
