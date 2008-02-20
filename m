Return-Path: <dhbaird@gmail.com>
Received: from wr-out-0506.google.com (wr-out-0506.google.com [64.233.184.233])
	by ozlabs.org (Postfix) with ESMTP id 22330DDEF2
	for <linuxppc-embedded@ozlabs.org>;
	Thu, 21 Feb 2008 09:03:17 +1100 (EST)
Received: by wr-out-0506.google.com with SMTP id 68so2720257wra.13
	for <linuxppc-embedded@ozlabs.org>;
	Wed, 20 Feb 2008 14:03:16 -0800 (PST)
Message-ID: <440abda90802201403y1bb88c21s44f64a76c58041b4@mail.gmail.com>
Date: Wed, 20 Feb 2008 15:03:14 -0700
From: "David Baird" <dhbaird@gmail.com>
To: linuxppc-embedded@ozlabs.org
Subject: Re: powerpc tree vs ppc tree
In-Reply-To: <5ee408090802201257g26baa1ablbbb460ac38be0964@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
References: <5ee408090802201257g26baa1ablbbb460ac38be0964@mail.gmail.com>
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

On Wed, Feb 20, 2008 at 1:57 PM, Ricardo Ayres Severo
<severo.ricardo@gmail.com> wrote:
>  I have a simple doubt, but I find no answer. What is the difference
>  between the powerpc tree to the ppc tree in the kernel source?
>  Which one should I use with a virtex II pro board?

ppc (32-bit versions) and ppc64 are deprecated trees scheduled to be
removed from the Linux kernel.

powerpc is the new preferred tree and is trying to consolidate ppc and
ppc64.  For Xilinx ppc405 though, I think the ppc tree is still
recommended, but that will probably be changing soon (this summer)?
