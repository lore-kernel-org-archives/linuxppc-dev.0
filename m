Return-Path: <jdl@freescale.com>
Received: from de01egw01.freescale.net (de01egw01.freescale.net
	[192.88.165.102])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "de01egw01.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 7AF57DDEA2
	for <linuxppc-embedded@ozlabs.org>;
	Sat, 23 Jun 2007 03:25:01 +1000 (EST)
Subject: Re: version control for dts/dtb?
From: Jon Loeliger <jdl@freescale.com>
To: marty <leisner@rochester.rr.com>
In-Reply-To: <000301c7b03e$0e2a42a0$9700a8c0@hplaptop>
References: <000301c7b03e$0e2a42a0$9700a8c0@hplaptop>
Content-Type: text/plain
Message-Id: <1182533095.29873.30.camel@ld0161-tx32>
Mime-Version: 1.0
Date: Fri, 22 Jun 2007 12:24:55 -0500
Cc: "linuxppc-embedded@ozlabs.org" <linuxppc-embedded@ozlabs.org>
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

On Sat, 2007-06-16 at 12:44, marty wrote:
> Is there a  wy to figure out the version of the dtb file I'm  using?
> At a minimum, it would be useful to have a node with the conversion time 
> stuck somewhere...
> 
> I ran dtc to convert binary to source, but that isn't necessarily what I 
> wanted to look at -- just a single date
> code would be sufficient...
> 
> marty


There is currently no direct version stamp in the
DTS or DTB files.  You may be able to derive some
knowledge by running a DTB file through the DTC
with the input file as "dtb" and looking at an
output file of DTS, though.  That is, "-I dtb -O dts"
and looking at it.

HTH,
jdl
