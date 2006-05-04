Return-Path: <adgospod@gmail.com>
Received: from nz-out-0102.google.com (nz-out-0102.google.com [64.233.162.195])
	by ozlabs.org (Postfix) with ESMTP id C060767A3D
	for <linuxppc-embedded@ozlabs.org>;
	Fri,  5 May 2006 05:10:28 +1000 (EST)
Received: by nz-out-0102.google.com with SMTP id x7so490161nzc
	for <linuxppc-embedded@ozlabs.org>;
	Thu, 04 May 2006 12:10:27 -0700 (PDT)
Message-ID: <bdfc5d6e0605041204y640e3233u83d57f22cf648699@mail.gmail.com>
Date: Thu, 4 May 2006 15:04:06 -0400
From: "Andy Gospodarek" <andy@greyhouse.net>
Sender: adgospod@gmail.com
To: "Grant Likely" <grant.likely@secretlab.ca>
Subject: Re: Moving from 2.4 to 2.6 kernel
In-Reply-To: <528646bc0605041111o1b652d60w3f5847a19abe5c95@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
References: <445A3AB1.7040405@ics-ltd.com>
	<528646bc0605041111o1b652d60w3f5847a19abe5c95@mail.gmail.com>
Cc: Chris Dumoulin <cdumoulin@ics-ltd.com>, linuxppc-embedded@ozlabs.org
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

On 5/4/06, Grant Likely <grant.likely@secretlab.ca> wrote:
> On 5/4/06, Chris Dumoulin <cdumoulin@ics-ltd.com> wrote:
> > I am trying to take a working embedded linux system from kernel 2.4 to
> > 2.6. The hardware is a custom board using a Virtex II Pro with PPC405
> > processor.
> > The working system uses u-boot 1.1.1 with linux kernel 2.4.18.
> >
> > I am using the same u-boot and I am trying to port linux kernel 2.6.15
> > to our platform. Using the stuff from the working 2.4 kernel port and
> > other PPC4xx platforms in the 2.6.15 code as examples, I believe I have
> > done everything required to get the kernel booting. However, the kernel
> > seems to hang after being uncompressed. Here is what I see after runnin=
g
> > bootm from u-boot:
>
> The V2pro is already supported in the 2.6 kernel.  Are you using that
> code; or starting from scratch?  V2Pro (ML300) and V4FX (ML403) are
> both supported in the latest 2.6 kernel.
>
> I had similar problems when I was porting to the V4FX.  Do you have a
> JTAG debugger (Like a BDI-2000)?  I think your best bet is to get in
> there with a debugger to find out where it goes off into Lala land.
>
> Cheers,
> g.
>
> --
> Grant Likely, B.Sc. P.Eng.
> Secret Lab Technologies Ltd.
> (403) 399-0195
> _______________________________________________
> Linuxppc-embedded mailing list
> Linuxppc-embedded@ozlabs.org
> https://ozlabs.org/mailman/listinfo/linuxppc-embedded
>

You could also try enabling early printk....sometimes that helps tell
you how far you did or didn't get.
