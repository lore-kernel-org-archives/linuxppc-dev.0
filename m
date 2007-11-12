Return-Path: <Geert.Uytterhoeven@sonycom.com>
Date: Mon, 12 Nov 2007 14:57:13 +0100 (CET)
From: Geert Uytterhoeven <Geert.Uytterhoeven@sonycom.com>
Sender: geert@sonytel.be
To: Jon Smirl <jonsmirl@gmail.com>
Subject: Re: pcspkr device, pnpPNP,100
In-Reply-To: <9e4733910711120551y2285003bw7be4d5aedbd25e96@mail.gmail.com>
Message-ID: <Pine.LNX.4.62.0711121456120.4731@pademelon.sonytel.be>
References: <9e4733910711111535w6ffdfa97x4bed07eb84d4ab13@mail.gmail.com>
	<1194825784.18185.0.camel@pasglop>
	<9e4733910711111607i35294d3ja43e1c616a3427bd@mail.gmail.com>
	<1194826191.18185.6.camel@pasglop>
	<9e4733910711111618l5190dee3jd8e0aa8f9b78ebf4@mail.gmail.com>
	<1194829646.18185.8.camel@pasglop>
	<Pine.LNX.4.62.0711121147480.4731@pademelon.sonytel.be>
	<9e4733910711120551y2285003bw7be4d5aedbd25e96@mail.gmail.com>
MIME-Version: 1.0
Content-Type: MULTIPART/MIXED;
	BOUNDARY="-584337861-1772500560-1194875833=:4731"
Cc: PowerPC dev list <Linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

---584337861-1772500560-1194875833=:4731
Content-Type: TEXT/PLAIN; charset=UTF-8
Content-Transfer-Encoding: 8BIT

On Mon, 12 Nov 2007, Jon Smirl wrote:
> On 11/12/07, Geert Uytterhoeven <Geert.Uytterhoeven@sonycom.com> wrote:
> > On Mon, 12 Nov 2007, Benjamin Herrenschmidt wrote:
> > > On Sun, 2007-11-11 at 19:18 -0500, Jon Smirl wrote:
> > >
> > > > Using this scheme, which platforms should select the pcspkr hardware?
> > >
> > > Run a poll :-) I suppose at least chrp/prep/pegasos
> >
> > And definitely not Amiga/APUS ;-)
> 
> I found this device tree that has the pnpPNP,100 device for an Amiga.
> http://www.nabble.com/Re:-Problem-with-OF-interrupt-parsing-code-p12988017.html

Ah yes, the AmigaOne. That's more a rebranded CHRP box...
Has nothing to do with CONFIG_AMIGA.

With kind regards,
 
Geert Uytterhoeven
Software Architect

Sony Network and Software Technology Center Europe
The Corporate Village · Da Vincilaan 7-D1 · B-1935 Zaventem · Belgium
 
Phone:    +32 (0)2 700 8453	
Fax:      +32 (0)2 700 8622	
E-mail:   Geert.Uytterhoeven@sonycom.com	
Internet: http://www.sony-europe.com/
 	
Sony Network and Software Technology Center Europe	
A division of Sony Service Centre (Europe) N.V.	
Registered office: Technologielaan 7 · B-1840 Londerzeel · Belgium	
VAT BE 0413.825.160 · RPR Brussels	
Fortis Bank Zaventem · Swift GEBABEBB08A · IBAN BE39001382358619
---584337861-1772500560-1194875833=:4731--
