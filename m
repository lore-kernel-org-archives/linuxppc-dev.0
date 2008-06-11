Return-Path: <DWatkins@tranzeo.com>
Received: from mail.tranzeo.com (unknown [64.114.87.10])
	by ozlabs.org (Postfix) with ESMTP id A767EDE96A
	for <linuxppc-embedded@ozlabs.org>;
	Thu, 12 Jun 2008 03:13:20 +1000 (EST)
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Subject: RE: PPC to PowerPC Migration
Date: Wed, 11 Jun 2008 10:15:03 -0700
Message-ID: <D61182AC8012EA4EBC531B3AF23BE109603578@tranzeo-mail2.12stewart.tranzeo.com>
In-Reply-To: <20080611123254.64fabf64@vader.jdub.homelinux.org>
References: <c443b0db0806101048t1df8c11ag456fbc352709966b@mail.gmail.com><161B3BAD77161449A144FF054231C3D6022A3E4A@uss-am-xch-01.am.trimblecorp.net><f608b67d0806110655v19dac162wc3adfc8939b5c40a@mail.gmail.com><D61182AC8012EA4EBC531B3AF23BE10960355D@tranzeo-mail2.12stewart.tranzeo.com>
	<20080611123254.64fabf64@vader.jdub.homelinux.org>
From: "Darcy Watkins" <DWatkins@tranzeo.com>
To: "Josh Boyer" <jwboyer@linux.vnet.ibm.com>
Cc: vb <vb@vsbe.com>, Mike Timmons <mike_timmons@trimble.com>,
	Andy Schmidt <andrewgschmidt@gmail.com>, linuxppc-embedded@ozlabs.org
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Hi Josh,

I think it would be more helpful if I were to tidy it a bit and add AMCC
Taihu boot support to it first.  Then submit it.  People are more likely
to have access to a Taihu than one of our boards.

What I mean by "AMCC Taihu boot support" is that the board would come up
just like our Taihushui/Kolsch family of boards, but would not include
the extra drivers, etc needed for USB gadgets, the LCD and other like
items that are on the AMCC board.

Once I get this done, I can submit BSP patch sets for kernel 2.6.25 and
2.6.26.  If there is demand, I could submit a BSP patch set for 2.6.24
as well.

Please send me (or URL to) summarized patch submission instructions /
guidelines.


Regards,


Darcy

-----Original Message-----
From: Josh Boyer [mailto:jwboyer@gmail.com] On Behalf Of Josh Boyer
Sent: Wednesday, June 11, 2008 9:33 AM
To: Darcy Watkins
Cc: vb; Mike Timmons; Andy Schmidt; linuxppc-embedded@ozlabs.org
Subject: Re: PPC to PowerPC Migration

On Wed, 11 Jun 2008 07:38:44 -0700
"Darcy Watkins" <DWatkins@tranzeo.com> wrote:

> Hello,
>=20
> I recently migrated an AMCC PPC405EP system from arch/ppc to
> arch/powerpc and found that in kernel 2.6.25, my board support patches
> have reduced to just the board support patches - approx 20k bytes in
> size (and one small one-line fix needed when using RT Preemption
> kernel).  Compare this with 2.6.24 and earlier where I had to apply
> patches to complete the PPC405EP and/or arch/powerpc support.
>    Prior to 2.6.23 had to use non kernel.org kernel sources and
> arch/ppc.
>    2.6.23 --> patch file size 400k+
>    2.6.24 --> patch file size ~80k
>    2.6.25 --> patch file size ~20k
>    2.6.26 --> patch file size ~20k
>=20
> I think that with 2.6.25 (and upcoming 2.6.26) this means that 4xx is
> ready for prime time in arch/powerpc.

Did you post your patch for your board port?  If not, please do.  If
so, kindly point me to it so I can look at merging it into mainline?

josh

No virus found in this incoming message.
Checked by AVG.=20
Version: 8.0.100 / Virus Database: 270.2.0/1497 - Release Date:
6/11/2008 8:32 AM
