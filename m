Return-Path: <robertlazarski@gmail.com>
Received: from ik-out-1112.google.com (ik-out-1112.google.com [66.249.90.183])
	by ozlabs.org (Postfix) with ESMTP id 1C6B9DDDD8
	for <linuxppc-embedded@ozlabs.org>;
	Sat, 18 Aug 2007 00:03:35 +1000 (EST)
Received: by ik-out-1112.google.com with SMTP id b35so118047ika
	for <linuxppc-embedded@ozlabs.org>;
	Fri, 17 Aug 2007 07:03:33 -0700 (PDT)
Message-ID: <f87675ee0708170703t632db650o95fd7ec16f587c37@mail.gmail.com>
Date: Fri, 17 Aug 2007 10:03:31 -0400
From: "robert lazarski" <robertlazarski@gmail.com>
Subject: Re: external IRQ's
Cc: linuxppc-embedded@ozlabs.org
In-Reply-To: <46C4C4E6.9070406@freescale.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
References: <f87675ee0708160751u14f96dbcs3ad35a147b70a3f3@mail.gmail.com>
	<46C47A1D.5030303@freescale.com>
	<f87675ee0708161434i9f38b0dg123a767822cf7402@mail.gmail.com>
	<46C4C4E6.9070406@freescale.com>
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

On 8/16/07, Scott Wood <scottwood@freescale.com> wrote:
> robert lazarski wrote:
> > Why <1d 2 1e 2 22 2> ? I can't seem to parse these numbers
>
> They alternate between IRQ numbers and level/sense information, and the
> IRQ numbers are the internal IRQ number plus 16.

Thanks, The "internal IRQ number plus 16" part is the info I was
lacking. However by 'internal IRQ' do you mean DMA? I just asked the
hardware engineer and that's what he thought you may have meant.

So in '1d'  the first cell is the irq and the second cell is the sense
level, how is the '1' calculated from 'internal IRQ number plus 16' .
Thanks for you patience, I'm just not getting that part yet.

>
> > - how do I
> > know what to use for my external interupts 1,2 for phy's 0,1 using a
> > 88E1121R and for external interupts 3,4 for phy's 2,3 using a 88E1111
> > ?
>
> I thought it was interrupts 0-3, not 1-4?

It was 0-3 ;-)

>
> If, like the CDS board, you have level-triggered active-low phy
> interrupts, then <0 1>, <1 1>, <2 1>, and <3 1>.  If not, then choose an
> appropriate value for the second cell based on booting-without-of.txt.
>

Kool, think I got this part. Do the 0-3 irq's in the mdio node
influence in any way the ethernet nodes irq's - the <1d 2 1e 2 22 2>
in this example ?

Thanks!
Robert
