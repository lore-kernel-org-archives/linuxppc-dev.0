Return-Path: <glikely@secretlab.ca>
Received: from hs-out-0708.google.com (hs-out-0708.google.com [64.233.178.249])
	by ozlabs.org (Postfix) with ESMTP id 00221DDEC7
	for <linuxppc-embedded@ozlabs.org>;
	Wed, 13 Feb 2008 01:56:46 +1100 (EST)
Received: by hs-out-0708.google.com with SMTP id x43so298901hsb.9
	for <linuxppc-embedded@ozlabs.org>;
	Tue, 12 Feb 2008 06:56:45 -0800 (PST)
Message-ID: <fa686aa40802120656g6352a2cdy66b2756409e6dbfd@mail.gmail.com>
Date: Tue, 12 Feb 2008 07:56:45 -0700
From: "Grant Likely" <grant.likely@secretlab.ca>
Sender: glikely@secretlab.ca
To: "A. Nolson" <alohanono@gmail.com>
Subject: Re: Writing drivers for external IP cores
In-Reply-To: <47B188F5.60607@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
References: <47B188F5.60607@gmail.com>
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

On Feb 12, 2008 4:54 AM, A. Nolson <alohanono@gmail.com> wrote:
> Hi ,
>
>  I am going to start developing some IP cores for my virtex fx12 (ML403)
> and I need to control them through my embedded Linux ( it is already
> working in the ppc405 ).  I am a bit lost and I need some references for
> developing drivers. In principle, I will start with something like a
> GPIO. I think an example like a driver for controlling the push buttons
> of my Ml403 will be enough. An example IP core for that will also be
> also very helpful.

After you've got through the examples in Linux Device Drivers v3, you
can take a look at drivers/video/xilinxfb.c for an example of a driver
that works with an FPGA ip core.  Unfortunately there isn't a simple
xilinx GPIO driver in the mainline kernel at the moment, otherwise I'd
point you there.

Cheers,
g.

-- 
Grant Likely, B.Sc., P.Eng.
Secret Lab Technologies Ltd.
