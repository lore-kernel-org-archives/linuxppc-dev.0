Return-Path: <dwh@ovro.caltech.edu>
Received: from ovro.ovro.caltech.edu (ovro.ovro.caltech.edu [192.100.16.2])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "sabrina.ovro.caltech.edu",
	Issuer "sabrina.ovro.caltech.edu" (not verified))
	by ozlabs.org (Postfix) with ESMTP id F3DED67B27
	for <linuxppc-embedded@ozlabs.org>;
	Sun, 12 Feb 2006 05:18:28 +1100 (EST)
Message-ID: <43EE29DC.103@ovro.caltech.edu>
Date: Sat, 11 Feb 2006 10:15:56 -0800
From: David Hawkins <dwh@ovro.caltech.edu>
MIME-Version: 1.0
To: Stefan Roese <sr@denx.de>
Subject: Re: Yosemite/440EP 'issues' as a PCI target
References: <20060210173133.964B53525CC@atlas.denx.de>
	<43ED7E1E.2030700@ovro.caltech.edu> <200602110921.33245.sr@denx.de>
In-Reply-To: <200602110921.33245.sr@denx.de>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
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


> Hmmm. The 440EP is around for quite a while. I would be surprised if you 
> couldn't buy those parts right now. But I have to admit, I never tried to. I 
> would contact my AMCC distributor for availability...

I always figure that if you can find it on a distributor web
site without having to explicitly ask for the part, then
it really is available. I got my Yosemite kit through
Avnet, so lets start there:

1. Avnet

    http://www.em.avnet.com

    Search for 440EP from the vendor AMCC, and it only shows up
    the eval boards.

    Search for 'contains' MPC834 from Freescale, and there are
    lots of hits (though no stock for most of them).

2. Arrow North America

    http://www.arrownac.com

    No AMCC stuff there.

    A search for the Freescale part shows up a bunch, although they
    have no stock either.

The successful search hits for the Freescale part gives me
more confidence in those parts. However, you are correct, if I
really want to know the availablity of parts, I should talk
directly to an AMCC rep.

Cheers
Dave
