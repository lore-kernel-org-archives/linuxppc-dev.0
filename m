Reply-To: <tcurran@ultsol.com>
From: "Tom Curran" <tcurran@ultsol.com>
To: <linuxppc-embedded@lists.linuxppc.org>
Subject: RE: JTAG debuggers for Motorola 8xx/82xx/85xx
Date: Wed, 9 Jun 2004 17:08:30 -0700
Message-ID: <008201c44e7f$10a309f0$6601a8c0@curranusi>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="US-ASCII"
In-Reply-To: <5CB4164A-BA5A-11D8-92CC-000393DBC2E8@freescale.com>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Yes, that is indeed correct.  The firmware licensing for the Abatron
emulators is done by processor family, not individual processor.  So in the
case of the PPC82xx, the same firmware for debugging with GDB will cover the
entire range of PPC6xx/7xx/7400,7410,5200, and 82xx processors.

Best Regards,
Tom

Tom Curran
Technical Sales Representative
Ultimate Solutions, Inc.
=====================================================
Providing Professional Development Tools For Embedded Systems
Toll Free: 866.455.3383 x257
Direct: 916.789.9358
Fax: 978.926.3091
Email:  tcurran@ultsol.com <mailto:tcurran@ultsol.com>
Web:  www.ultsol.com <http://www.ultsol.com>
FAQ: www.ultsol.com/faqs.htm <http://www.ultsol.com/faqs.htm>


-----Original Message-----
From: owner-linuxppc-embedded@lists.linuxppc.org
[mailto:owner-linuxppc-embedded@lists.linuxppc.org]On Behalf Of Kumar
Gala
Sent: Wednesday, June 09, 2004 2:17 PM
To: Matevz Langus
Cc: linuxppc-embedded@lists.linuxppc.org
Subject: Re: JTAG debuggers for Motorola 8xx/82xx/85xx



I'm guessing most people would recommend the BDI2000.  If I remember
correctly they end up doing support based on 'Family'.  So support for
85xx is one family, 82xx is another, 8xx a third.


- kumar

On Jun 9, 2004, at 4:12 PM, Matevz Langus wrote:

>
> Hi folks,
>
> I see you are discussing about BDI2000 here. Our company used EST Tools
> for many years and they were really good but since Windriver bought EST
> they suck.
>
> Which JTAG debugger do you suggest for Mot 8xx/82xx/85xx processors?
> If possible without stupid licensing model, where every time Motorola
> changes partnumber for the same chip new license and a couple k$ are
> needed.
>
> I hope to get honest answers as all producers promise amazing things
> which aren't really to believe.
>
> thanks,
>   Matevz
>
>


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
