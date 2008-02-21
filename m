Return-Path: <glikely@secretlab.ca>
Received: from an-out-0708.google.com (an-out-0708.google.com [209.85.132.243])
	by ozlabs.org (Postfix) with ESMTP id 956D9DDE43
	for <linuxppc-embedded@ozlabs.org>;
	Thu, 21 Feb 2008 11:01:59 +1100 (EST)
Received: by an-out-0708.google.com with SMTP id c37so2497343anc.78
	for <linuxppc-embedded@ozlabs.org>;
	Wed, 20 Feb 2008 16:01:56 -0800 (PST)
Message-ID: <fa686aa40802201601q20ef2077qcec6221d5c4ab2e0@mail.gmail.com>
Date: Wed, 20 Feb 2008 17:01:55 -0700
From: "Grant Likely" <grant.likely@secretlab.ca>
Sender: glikely@secretlab.ca
To: "David Baird" <dhbaird@gmail.com>
Subject: Re: powerpc tree vs ppc tree
In-Reply-To: <440abda90802201403y1bb88c21s44f64a76c58041b4@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
References: <5ee408090802201257g26baa1ablbbb460ac38be0964@mail.gmail.com>
	<440abda90802201403y1bb88c21s44f64a76c58041b4@mail.gmail.com>
Cc: linuxppc-embedded@ozlabs.org
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

On Wed, Feb 20, 2008 at 3:03 PM, David Baird <dhbaird@gmail.com> wrote:
> On Wed, Feb 20, 2008 at 1:57 PM, Ricardo Ayres Severo
>  <severo.ricardo@gmail.com> wrote:
>  >  I have a simple doubt, but I find no answer. What is the difference
>  >  between the powerpc tree to the ppc tree in the kernel source?
>  >  Which one should I use with a virtex II pro board?
>
>  ppc (32-bit versions) and ppc64 are deprecated trees scheduled to be
>  removed from the Linux kernel.
>
>  powerpc is the new preferred tree and is trying to consolidate ppc and
>  ppc64.  For Xilinx ppc405 though, I think the ppc tree is still
>  recommended, but that will probably be changing soon (this summer)?

arch/powerpc is getting close to usable on the virtex, but there are
still some missing bits.  It won't be ready for prime time until
2.6.26.

Cheers,
g.

-- 
Grant Likely, B.Sc., P.Eng.
Secret Lab Technologies Ltd.
