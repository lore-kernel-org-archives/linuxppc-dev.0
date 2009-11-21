Return-Path: <glikely@secretlab.ca>
Received: from mail-gx0-f228.google.com (mail-gx0-f228.google.com
	[209.85.217.228]) by ozlabs.org (Postfix) with ESMTP id 497EEB6F2B
	for <linuxppc-dev@ozlabs.org>; Sat, 21 Nov 2009 19:02:03 +1100 (EST)
Received: by gxk28 with SMTP id 28so3651372gxk.9
	for <linuxppc-dev@ozlabs.org>; Sat, 21 Nov 2009 00:02:01 -0800 (PST)
MIME-Version: 1.0
Sender: glikely@secretlab.ca
In-Reply-To: <alpine.LFD.2.00.0911182141060.24119@localhost.localdomain>
References: <20091117224852.846805939@linutronix.de>
	<20091117224916.566205413@linutronix.de>
	<20091118175523.GA12857@b07421-ec1.am.freescale.net>
	<alpine.LFD.2.00.0911182141060.24119@localhost.localdomain>
From: Grant Likely <grant.likely@secretlab.ca>
Date: Sat, 21 Nov 2009 01:01:41 -0700
Message-ID: <fa686aa40911210001u699031a0h2b3818b68c212d69@mail.gmail.com>
Subject: Re: [patch 06/13] powerpc: Fixup last users of irq_chip->typename
To: Thomas Gleixner <tglx@linutronix.de>
Content-Type: text/plain; charset=ISO-8859-1
Cc: Scott Wood <scottwood@freescale.com>, linuxppc-dev@ozlabs.org,
	Ingo Molnar <mingo@elte.hu>, LKML <linux-kernel@vger.kernel.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, Nov 18, 2009 at 1:41 PM, Thomas Gleixner <tglx@linutronix.de> wrote=
:
> On Wed, 18 Nov 2009, Scott Wood wrote:
>> On Tue, Nov 17, 2009 at 10:50:53PM +0000, Thomas Gleixner wrote:
>> > Index: linux-2.6/arch/powerpc/platforms/82xx/pq2ads-pci-pic.c
>> > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>> > --- linux-2.6.orig/arch/powerpc/platforms/82xx/pq2ads-pci-pic.c
>> > +++ linux-2.6/arch/powerpc/platforms/82xx/pq2ads-pci-pic.c
>> > @@ -69,7 +69,7 @@ static void pq2ads_pci_unmask_irq(unsign
>> > =A0}
>> >
>> > =A0static struct irq_chip pq2ads_pci_ic =3D {
>> > - =A0 .typename =3D "PQ2 ADS PCI",
>> > + =A0 .name =3D "PQ2 ADS PCI",
>> > =A0 =A0 .name =3D "PQ2 ADS PCI",
>> > =A0 =A0 .end =3D pq2ads_pci_unmask_irq,
>> > =A0 =A0 .mask =3D pq2ads_pci_mask_irq,
>>
>> Duplicate ".name"...
>
> Darn.

Other than that, looks good to me.

Acked-by: Grant Likely <grant.likely@secretlab.ca>

--=20
Grant Likely, B.Sc., P.Eng.
Secret Lab Technologies Ltd.
