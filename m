Return-Path: <gguevel@interfaceconcept.com>
Received: from smtp3.clb.oleane.net (smtp3.clb.oleane.net [213.56.31.19])
	by ozlabs.org (Postfix) with ESMTP id 88E7A6839F
	for <linuxppc-embedded@ozlabs.org>;
	Thu, 29 Sep 2005 23:21:29 +1000 (EST)
From: =?iso-8859-1?Q?G=E9rard_Gu=E9vel?= <gguevel@interfaceconcept.com>
To: "'Andy Fleming'" <afleming@freescale.com>
Date: Thu, 29 Sep 2005 15:23:51 +0200
Message-ID: <000501c5c4f9$0b1b81a0$5201a8c0@GEG2400>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
In-Reply-To: <AD2A3D43-57D8-4198-BAD3-FB5E3B549361@freescale.com>
Cc: linuxppc-embedded@ozlabs.org
Subject: RE: How to use SPE on MPC8541
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>


> Hmm... This is very strange, because Dhrystone is exactly the
> benchmark this was tested on.  How did you determine that the SPE
> functions are called?

I prefix the strcpy and strcmp functions with a "v" in dhry21a.c and
dhry21b.c. Then I statically compile the c files with the freescale
assembly source S files and not with the library libcfsl_e500.a.

If I don't add the S files the ld fails else it succeeds.
I retreive the symbols vstr... in the binary dhrystone with readelf.
So I presume that it is the right code that is called.

> I'm not sure why you aren't seeing a performance gain, but I assure
> you that, if SPE instructions weren't working, Dhrystone would
> crash.

I confirm that if I try to run this binary without SPE in Linux kernel
I get an exception.

> The only other possibility I can think of is that the SPE
> versions of the functions aren't being called.

I don't understand what you say.
Perhaps have you a pre-compiled dhrystone for Linux 2.6
I can try and compare on my board

Thanks
Gérard
