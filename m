Return-Path: <glikely@secretlab.ca>
Received: from wa-out-1112.google.com (wa-out-1112.google.com [209.85.146.182])
	by ozlabs.org (Postfix) with ESMTP id 5BCD7DDE2C
	for <linuxppc-dev@ozlabs.org>; Thu,  4 Oct 2007 06:29:12 +1000 (EST)
Received: by wa-out-1112.google.com with SMTP id m28so5883852wag
	for <linuxppc-dev@ozlabs.org>; Wed, 03 Oct 2007 13:29:11 -0700 (PDT)
Message-ID: <fa686aa40710031329s728920eblaf1bf699a40272c8@mail.gmail.com>
Date: Wed, 3 Oct 2007 14:29:11 -0600
From: "Grant Likely" <grant.likely@secretlab.ca>
Sender: glikely@secretlab.ca
To: "Scott Wood" <scottwood@freescale.com>
Subject: Re: [PATCH 08/10] bootwrapper: Add a firmware-independent "raw"
	target.
In-Reply-To: <20070905192116.GH32113@ld0162-tx32.am.freescale.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
References: <20070905192001.GA32049@ld0162-tx32.am.freescale.net>
	<20070905192116.GH32113@ld0162-tx32.am.freescale.net>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On 9/5/07, Scott Wood <scottwood@freescale.com> wrote:
> This target produces a flat binary rather than an ELF file,
> fixes the entry point at the beginning of the image, and takes
> a complete device tree with no fixups needed.
>
> The device tree must have labels on /#address-cells, the timebase
> frequency, and the memory size.

Scott,

Are you planning to address the comments on this patch and resubmit in
time for the 2.6.24 merge window?  The raw platform is quite useful
for Xilinx Virtex support, so I'd really like to see it get merged.

Thanks,
g.

-- 
Grant Likely, B.Sc., P.Eng.
Secret Lab Technologies Ltd.
grant.likely@secretlab.ca
(403) 399-0195
