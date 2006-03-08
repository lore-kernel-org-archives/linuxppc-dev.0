Return-Path: <dwh@ovro.caltech.edu>
Received: from ovro.ovro.caltech.edu (ovro.ovro.caltech.edu [192.100.16.2])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "sabrina.ovro.caltech.edu",
	Issuer "sabrina.ovro.caltech.edu" (not verified))
	by ozlabs.org (Postfix) with ESMTP id 10191679EB
	for <linuxppc-embedded@ozlabs.org>;
	Thu,  9 Mar 2006 07:28:09 +1100 (EST)
Message-ID: <440F3E3D.3090807@ovro.caltech.edu>
Date: Wed, 08 Mar 2006 12:27:41 -0800
From: David Hawkins <dwh@ovro.caltech.edu>
MIME-Version: 1.0
To: Jeff.Fellin@rflelect.com
Subject: Re: Yosemite board ala, PPC405EP
References: <OFFBE09E88.DB8A5C68-ON8525712B.006C3D78@teal.com>
In-Reply-To: <OFFBE09E88.DB8A5C68-ON8525712B.006C3D78@teal.com>
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

Jeff.Fellin@rflelect.com wrote:
> I have been using an Albatron BDI for a PPC405GP board in a project.
> According to the documentation I've read the Yosemite board is identical
> register wise to the 405GP, except for two sets of EMAC registers.
> 
> My problem is when I use the Albatron BDI using the register definitions
> for the 405GP, the BDI cannot communicate with the 405EP.
> 
> Anyone have experience with usingg the BDI for the PPC 405EP?

Hey Jeff,

Can you please clarify;

Are you using a Yosemite board (440EP) or are you using a 405EP board
(which is *not* the Yosemite board)?

If you are using the Yosemite board, then I have one here,
and my BDI2000 just arrived. I haven't had a chance to test
the BDI2000, but I can let you know the results when I do.

Dave
