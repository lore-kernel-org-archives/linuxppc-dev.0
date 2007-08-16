Return-Path: <Geert.Uytterhoeven@sonycom.com>
Received: from vervifontaine.sonycom.com (vervifontaine.sonytel.be
	[80.88.33.193]) by ozlabs.org (Postfix) with ESMTP id A74D3DDE49
	for <linuxppc-dev@ozlabs.org>; Thu, 16 Aug 2007 17:15:39 +1000 (EST)
Date: Thu, 16 Aug 2007 09:15:35 +0200 (CEST)
From: Geert Uytterhoeven <Geert.Uytterhoeven@sonycom.com>
Sender: geert@sonytel.be
To: mike zheng <mail4mz@gmail.com>
Subject: Re: System crash on boot_e500.S
In-Reply-To: <5c9cd53b0708151423r1c9748e5jbd460cd72585020c@mail.gmail.com>
Message-ID: <Pine.LNX.4.62.0708160914120.6037@pademelon.sonytel.be>
References: <5c9cd53b0708141314o57440c62waffb4cca3f2be0b9@mail.gmail.com>
	<1187124014.32650.80.camel@ld0161-tx32>
	<5c9cd53b0708150657k71531bdbl848375d5d80faf21@mail.gmail.com>
	<20070815160254.GA9049@ld0162-tx32.am.freescale.net>
	<A9A39446-A8B0-44D7-ABF4-E9918FCC2843@kernel.crashing.org>
	<16A6A248-880E-483A-AFDD-2A225F4B6864@freescale.com>
	<5c9cd53b0708151353u67e10e03lf12c3971e4f3d63@mail.gmail.com>
	<46C368D1.7000403@freescale.com>
	<5c9cd53b0708151423r1c9748e5jbd460cd72585020c@mail.gmail.com>
MIME-Version: 1.0
Content-Type: MULTIPART/MIXED;
	BOUNDARY="-584337861-1391323965-1187248535=:6037"
Cc: "linuxppc-dev@ozlabs.org" <linuxppc-dev@ozlabs.org>
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

---584337861-1391323965-1187248535=:6037
Content-Type: TEXT/PLAIN; charset=UTF-8
Content-Transfer-Encoding: 8BIT

On Wed, 15 Aug 2007, mike zheng wrote:
> On 8/15/07, Scott Wood <scottwood@freescale.com> wrote:
> > mike zheng wrote:
> > > Unfortunately, all the applications are running on 2.4 kernel. I can not
> > > just throw the 2.4 kernel.
> >
> > And in what way does 2.6 break these applications?
> 
> All the device drivers are based on 2.4 kernel. We plan to upgrade to 2.6 in
                             ^^^^^^^^
derived from?

> the middle of next year.

> > Any suggest or comment is welcome, I am struggling with this issue for
> > > almost one week...... :-(
> >
> > How long would you have struggled with getting your applications running
> > on a more recent kernel instead?
> 
> 
> Don't know, maybe 16 weeks. That is out of my control. I only deal with the
> kernel.....:-)

Ah, good, so the device drivers are in user space.
What in user space has changed completely between 2.4 and 2.6?

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
---584337861-1391323965-1187248535=:6037--
