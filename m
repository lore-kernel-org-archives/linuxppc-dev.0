Return-Path: <SRS0=jHOD=OV=denx.de=sr@srs.kundenserver.de>
Received: from moutng.kundenserver.de (moutng.kundenserver.de
	[212.227.126.177]) by ozlabs.org (Postfix) with ESMTP id D0294DDE01
	for <linuxppc-dev@ozlabs.org>; Tue, 25 Sep 2007 23:20:48 +1000 (EST)
From: Stefan Roese <sr@denx.de>
To: linuxppc-dev@ozlabs.org
Subject: Re: AMCC yosemite 440ep PCI slot doesn't work.
Date: Tue, 25 Sep 2007 15:21:07 +0200
References: <46F3A2C4.7000202@windriver.com> <46F86C4F.7060305@windriver.com>
	<200709250718.51824.sr@denx.de>
In-Reply-To: <200709250718.51824.sr@denx.de>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200709251521.07500.sr@denx.de>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Tuesday 25 September 2007, Stefan Roese wrote:
> On Tuesday 25 September 2007, Andrew Liu wrote:
> > I have tested it on linux-2.6.19 which is from AMCC website ,  linux
> > 2.6.21.7 which is from linux mainline and  linux-2.6.23.rc7 which is
> > from git://www.denx.de/git/linux-2.6-denx.git
> > Have the same problem.
> >  I don't understand, why after enabling this PCI interrupts.  in so
> > short time, produce 100,000 interrupt request (25:     100000  UIC0
> > Level     eth2).
>
> Because the interrupt is somehow not acknowledged in the PCI device.
>
> I will test this on my Yosemite and let you know.

I just tested on my Yellowstone, which is nearly identical to the Yosemite. 
And it works just fine with an Intel EEPRO/100.

Could you test another PCI board (ethernet, IDE, USB...)? Or do you have 
access to another Yosemite or Yellowstone board?

Best regards,
Stefan

=====================================================================
DENX Software Engineering GmbH,     MD: Wolfgang Denk & Detlev Zundel
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany
Phone: +49-8142-66989-0 Fax: +49-8142-66989-80  Email: office@denx.de
=====================================================================
