Return-Path: <andrew@varisys.co.uk>
Received: from sammy.varisys.co.uk (secure.varisys.co.uk [81.187.198.36])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 8B9B8679E1
	for <linuxppc-embedded@ozlabs.org>;
	Sat, 11 Feb 2006 04:55:23 +1100 (EST)
Message-ID: <43ECCB4D.9080602@varisys.co.uk>
Date: Fri, 10 Feb 2006 17:20:13 +0000
From: Andrew Armitage <andrew@varisys.co.uk>
MIME-Version: 1.0
To: David Hawkins <dwh@ovro.caltech.edu>
Subject: Re: Yosemite/440EP 'issues' as a PCI target
References: <20060209003459.0ED30352564@atlas.denx.de>	<43EBD715.4020303@ovro.caltech.edu>
	<200602100847.54363.sr@denx.de> <43ECC7CE.1010409@ovro.caltech.edu>
In-Reply-To: <43ECC7CE.1010409@ovro.caltech.edu>
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

Hi David,

> However, given the meager host-to-host communications
> features, I think I would be better off putting an
> Intel 21555 non-transparent bridge on the board.
> That will provide 5V tolerance, and a full set of
> messaging unit and I2O facilities. All for $50-80
> or so according to the single-piece pricing from
> Digikey. I'm not so happy to need to add another
> chip, but if the 440EP passes all the other
> benchmark requirements, then it seems the least
> painful way to proceed.
> 
> Has anyone reading this list had good or bad experiences
> with the Intel 21555 or perhaps some of the PLX offers,
> eg. PCI 6254?

We've used the 21555 on a couple of our designs (mated to a 7457/107 
pair) and have never had too many problems with them.  The messaging 
unit has been very helpful.

Just my $0.02,

Andrew
