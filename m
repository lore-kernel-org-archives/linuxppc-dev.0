Return-Path: <glikely@secretlab.ca>
Received: from wa-out-1112.google.com (wa-out-1112.google.com [209.85.146.176])
	by ozlabs.org (Postfix) with ESMTP id 677BEDDDDB
	for <linuxppc-embedded@ozlabs.org>;
	Fri,  3 Aug 2007 10:53:06 +1000 (EST)
Received: by wa-out-1112.google.com with SMTP id m28so739577wag
	for <linuxppc-embedded@ozlabs.org>;
	Thu, 02 Aug 2007 17:53:05 -0700 (PDT)
Message-ID: <fa686aa40708021753p45390d10o3faeaa955356b842@mail.gmail.com>
Date: Thu, 2 Aug 2007 18:53:04 -0600
From: "Grant Likely" <grant.likely@secretlab.ca>
Sender: glikely@secretlab.ca
To: "John Williams" <jwilliams@itee.uq.edu.au>
Subject: Re: suspend/resume (Xilinx V4)
In-Reply-To: <46B26E97.3040706@itee.uq.edu.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
References: <46B26E97.3040706@itee.uq.edu.au>
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

On 8/2/07, John Williams <jwilliams@itee.uq.edu.au> wrote:
> Hi,
>
> Any comments on the status/feasibility of suspend/resume for LinuxPPC on
> Xilinx devices?

Pretty much non-existant as far as status goes.  Feasibility depends
entirely on what power management features the Xilinx silicon
supports.  I haven't looked into whether or not the 405 core can be
put into sleep states.

>
> The only suspend-related traffic I see here in the last 12 months is for
> the lite5200b board.
>
> Any guesstimates of level of difficulty for such a task on Xilinx
> PPC405?  The core lite5200b patchset didn't look too hairy (just a
> modest bit of ASM :), but there would also be Xilinx device driver hooks
> to consider.

I suspect the driver code will be where most of the effort lies.

> Also, are there kernel revision dependencies here?  Project is currently
> on an MVL 2.6.10 tree - but have seen mention of 2.6.17 (?) being
> earliest with PPC suspend/resume capability.

Suspend support for ppc has existed for a long time, but there aren't
many embedded ppc boards which support it (5200 being a notable
example).

Personally, I'm keeping up to date with mainline (2.6.22+) on my Virtex tree.

Cheers,
g.

-- 
Grant Likely, B.Sc., P.Eng.
Secret Lab Technologies Ltd.
grant.likely@secretlab.ca
(403) 399-0195
