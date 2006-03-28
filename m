Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 82072679E7
	for <linuxppc-dev@ozlabs.org>; Wed, 29 Mar 2006 09:08:01 +1100 (EST)
Subject: Re: 2.6.16 does not boot on powerbook
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: wrobell@pld-linux.org
In-Reply-To: <1143556705.3562.104.camel@RECENT-CONVERT>
References: <442925A8.6030004@rsbac.org>
	<1143556705.3562.104.camel@RECENT-CONVERT>
Content-Type: text/plain
Date: Wed, 29 Mar 2006 09:07:54 +1100
Message-Id: <1143583675.2284.35.camel@localhost.localdomain>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Tue, 2006-03-28 at 15:38 +0100, wrobell wrote:
> On Tue, 2006-03-28 at 14:01 +0200, Michal Purzynski wrote:
> > -----BEGIN PGP SIGNED MESSAGE-----
> > Hash: SHA1
> > 
> > hey,
> > 
> > i've just installed 2.6.16 vanilla kernel on powerbook G4 but it cannot
> > boot.
> [...]
> > my kernel config (the same config works on 2.6.15)
> [...]
> > # CONFIG_PPC_PMAC is not set
> 
> you have to go through configuration options carefully.
> some of them are disabled because of ppc32/64 arch merging changes
> (please correct me if i am wrong).

There is a pmac32_defconfig you can use as a basis now.

Ben.
