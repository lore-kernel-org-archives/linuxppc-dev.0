Return-Path: <glikely@secretlab.ca>
Received: from an-out-0708.google.com (an-out-0708.google.com [209.85.132.248])
	by ozlabs.org (Postfix) with ESMTP id ADEFCDDDFC
	for <linuxppc-embedded@ozlabs.org>;
	Sat, 19 Jan 2008 12:23:26 +1100 (EST)
Received: by an-out-0708.google.com with SMTP id c37so281623anc.78
	for <linuxppc-embedded@ozlabs.org>;
	Fri, 18 Jan 2008 17:23:24 -0800 (PST)
Message-ID: <fa686aa40801181723r4ca29725s23f4acd9297e905@mail.gmail.com>
Date: Fri, 18 Jan 2008 18:23:24 -0700
From: "Grant Likely" <grant.likely@secretlab.ca>
Sender: glikely@secretlab.ca
To: "Ron Sass" <rsass@uncc.edu>
Subject: Re: ml310 kernel2.6 booting problems
In-Reply-To: <200801190011.m0J0BCtr001286@rsass-homer.uncc.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
References: <169c03cb0801171849i59d35893hda44a7f0c5417b58@mail.gmail.com>
	<200801190011.m0J0BCtr001286@rsass-homer.uncc.edu>
Cc: Jean-Samuel Chenard <jsamch@macs.ece.mcgill.ca>,
	linuxppc-embedded@ozlabs.org
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

On 1/18/08, Ron Sass <rsass@uncc.edu> wrote:
> My question is this:  Would it make sense to have a Kernel
> configuration something like "VIRTEX_PCI" and a platforms
> "XILINX_ML4xx" / "XILINX_ML3xx" ... or create four platforms:
>
>   XILINX_ML300
>   XILINX_ML310
>   XILINX_ML40x
>   XILINX_ML410

The whole CONFIG_XILINX_ML*** stuff will be disappearing as part of
the migration from arch/ppc to arch/powerpc.  Instead, the board
configuration will be described using a device tree file (dts).  Feel
free to add stuff in your local tree, but be prepared to migrate your
drivers in the next 6 months or so.

Cheers,
g.

-- 
Grant Likely, B.Sc., P.Eng.
Secret Lab Technologies Ltd.
