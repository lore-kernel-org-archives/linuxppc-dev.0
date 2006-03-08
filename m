Return-Path: <ebs@ebshome.net>
Received: from gate.ebshome.net (gate.ebshome.net [64.81.67.12])
	(using TLSv1 with cipher EDH-RSA-DES-CBC3-SHA (168/168 bits))
	(Client CN "gate.ebshome.net", Issuer "gate.ebshome.net" (not verified))
	by ozlabs.org (Postfix) with ESMTP id AA505679E7
	for <linuxppc-embedded@ozlabs.org>;
	Thu,  9 Mar 2006 07:21:51 +1100 (EST)
Date: Wed, 8 Mar 2006 12:21:47 -0800
From: Eugene Surovegin <ebs@ebshome.net>
To: Jeff.Fellin@rflelect.com
Subject: Re: Yosemite board ala, PPC405EP
Message-ID: <20060308202147.GA13630@gate.ebshome.net>
References: <OFFBE09E88.DB8A5C68-ON8525712B.006C3D78@teal.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <OFFBE09E88.DB8A5C68-ON8525712B.006C3D78@teal.com>
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

On Wed, Mar 08, 2006 at 02:45:54PM -0500, Jeff.Fellin@rflelect.com wrote:
> 
> I have been using an Albatron BDI for a PPC405GP board in a project.
> According to the documentation I've read the Yosemite board is identical
> register wise to the 405GP, except for two sets of EMAC registers.
> 
> My problem is when I use the Albatron BDI using the register definitions
> for the 405GP, the BDI cannot communicate with the 405EP.
> 
> Anyone have experience with usingg the BDI for the PPC 405EP?

AFAIK, Yosemite is 440EP, not 405EP. And 440EP is quite different from 
405GP.

-- 
Eugene
