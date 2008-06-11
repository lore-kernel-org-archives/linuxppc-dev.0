Return-Path: <jwboyer@gmail.com>
Received: from yx-out-2324.google.com (yx-out-2324.google.com [74.125.44.28])
	by ozlabs.org (Postfix) with ESMTP id CA537DDEE1
	for <linuxppc-embedded@ozlabs.org>;
	Thu, 12 Jun 2008 02:33:15 +1000 (EST)
Received: by yx-out-2324.google.com with SMTP id 8so354535yxg.39
	for <linuxppc-embedded@ozlabs.org>;
	Wed, 11 Jun 2008 09:33:14 -0700 (PDT)
Date: Wed, 11 Jun 2008 12:32:54 -0400
From: Josh Boyer <jwboyer@linux.vnet.ibm.com>
To: "Darcy Watkins" <DWatkins@tranzeo.com>
Subject: Re: PPC to PowerPC Migration
Message-ID: <20080611123254.64fabf64@vader.jdub.homelinux.org>
In-Reply-To: <D61182AC8012EA4EBC531B3AF23BE10960355D@tranzeo-mail2.12stewart.tranzeo.com>
References: <c443b0db0806101048t1df8c11ag456fbc352709966b@mail.gmail.com>
	<161B3BAD77161449A144FF054231C3D6022A3E4A@uss-am-xch-01.am.trimblecorp.net>
	<f608b67d0806110655v19dac162wc3adfc8939b5c40a@mail.gmail.com>
	<D61182AC8012EA4EBC531B3AF23BE10960355D@tranzeo-mail2.12stewart.tranzeo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: Josh Boyer <jwboyer@gmail.com>
Cc: vb <vb@vsbe.com>, Mike Timmons <mike_timmons@trimble.com>, Andy,
	Schmidt <andrewgschmidt@gmail.com>, linuxppc-embedded@ozlabs.org
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

On Wed, 11 Jun 2008 07:38:44 -0700
"Darcy Watkins" <DWatkins@tranzeo.com> wrote:

> Hello,
> 
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
> 
> I think that with 2.6.25 (and upcoming 2.6.26) this means that 4xx is
> ready for prime time in arch/powerpc.

Did you post your patch for your board port?  If not, please do.  If
so, kindly point me to it so I can look at merging it into mainline?

josh
