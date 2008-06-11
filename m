Return-Path: <DWatkins@tranzeo.com>
Received: from mail.tranzeo.com (unknown [64.114.87.10])
	by ozlabs.org (Postfix) with ESMTP id 59D5BDE259
	for <linuxppc-embedded@ozlabs.org>;
	Thu, 12 Jun 2008 00:49:35 +1000 (EST)
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Subject: RE: PPC to PowerPC Migration
Date: Wed, 11 Jun 2008 07:38:44 -0700
Message-ID: <D61182AC8012EA4EBC531B3AF23BE10960355D@tranzeo-mail2.12stewart.tranzeo.com>
In-Reply-To: <f608b67d0806110655v19dac162wc3adfc8939b5c40a@mail.gmail.com>
References: <c443b0db0806101048t1df8c11ag456fbc352709966b@mail.gmail.com><161B3BAD77161449A144FF054231C3D6022A3E4A@uss-am-xch-01.am.trimblecorp.net>
	<f608b67d0806110655v19dac162wc3adfc8939b5c40a@mail.gmail.com>
From: "Darcy Watkins" <DWatkins@tranzeo.com>
To: "vb" <vb@vsbe.com>,
	"Mike Timmons" <mike_timmons@trimble.com>
Cc: Andy Schmidt <andrewgschmidt@gmail.com>, linuxppc-embedded@ozlabs.org
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Hello,

I recently migrated an AMCC PPC405EP system from arch/ppc to
arch/powerpc and found that in kernel 2.6.25, my board support patches
have reduced to just the board support patches - approx 20k bytes in
size (and one small one-line fix needed when using RT Preemption
kernel).  Compare this with 2.6.24 and earlier where I had to apply
patches to complete the PPC405EP and/or arch/powerpc support.
   Prior to 2.6.23 had to use non kernel.org kernel sources and
arch/ppc.
   2.6.23 --> patch file size 400k+
   2.6.24 --> patch file size ~80k
   2.6.25 --> patch file size ~20k
   2.6.26 --> patch file size ~20k

I think that with 2.6.25 (and upcoming 2.6.26) this means that 4xx is
ready for prime time in arch/powerpc.

One other note though, for IBM I2C Driver 2.2 you need to use 2.6.26
release candidates (or apply a patch to back port it).  The 2.1 driver
appears to be arch/ppc (IBM_OCP based) only.

The only real downer is that the native posix thread library (NPTL)
being added to the upcoming uclibc won't support PowerPC (at least not
yet).

Getting more to the topic, when you get into preparing this document,
keep me in the loop too please.  I may be able to contribute something
to it as well.  Thanks in advance.

Regards,

Darcy


-----Original Message-----
From: linuxppc-embedded-bounces+dwatkins=3Dtranzeo.com@ozlabs.org
[mailto:linuxppc-embedded-bounces+dwatkins=3Dtranzeo.com@ozlabs.org] On
Behalf Of vb
Sent: Wednesday, June 11, 2008 6:56 AM
To: Mike Timmons
Cc: Andy Schmidt; linuxppc-embedded@ozlabs.org
Subject: Re: PPC to PowerPC Migration

I recently ported two platforms (8245 and 8541) from ppc tree in
earlier 2.6 versions into powerpc tree in 2.6.25. It is amazing how
little the device tree contents are described, a lot of things
required reverse engineering of the kernel code to understand the
meaning of some numbers in the  tree.

I am also willing to contribute into a document describing this
transition, please keep me in the loop,

regards,
Vadim



On Tue, Jun 10, 2008 at 6:19 PM, Mike Timmons <mike_timmons@trimble.com>
wrote:
> Great Idea Andrew. I am no long-serving expert, but over the past few
> years I've had some ARM-linux and more recently mpc5200 Linux
exposure.
> For the mpc5200 we started as ppc under 2.6.16 a few months ago. I
> recently migrated to 2.6.24 with ARCH=3Dpowerpc.

--snip!--
