Return-Path: <idefix@fechner.net>
Received: from michelle.lostinspace.de (michelle.lostinspace.de [83.120.0.234])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "michelle.lostinspace.de",
	Issuer "michelle.lostinspace.de" (not verified))
	by ozlabs.org (Postfix) with ESMTP id 7D1C567C73
	for <linuxppc-embedded@ozlabs.org>;
	Thu, 13 Apr 2006 06:09:29 +1000 (EST)
Received: from server.idefix.loc (ppp-82-135-78-215.mnet-online.de
	[82.135.78.215]) (authenticated bits=0)
	by michelle.lostinspace.de (8.13.4/8.13.4) with ESMTP id k3CK9Pen027329
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <linuxppc-embedded@ozlabs.org>;
	Wed, 12 Apr 2006 22:09:25 +0200 (CEST)
	(envelope-from idefix@fechner.net)
Received: from idefix by server.idefix.loc with local (Exim 4.61 (FreeBSD))
	(envelope-from <idefix@fechner.net>) id 1FTleX-000Aci-N3
	for linuxppc-embedded@ozlabs.org; Wed, 12 Apr 2006 22:09:25 +0200
Date: Wed, 12 Apr 2006 22:09:25 +0200
From: Matthias Fechner <idefix@fechner.net>
To: linuxppc-embedded@ozlabs.org
Subject: Re: freescale lite 5200 board and kernel 2.6
Message-ID: <20060412200925.GA33398@server.idefix.loc>
References: <20060405210654.GA16848@raptus.dandreoli.com>
	<20060405212741.GC61331@server.idefix.loc>
	<20060406221056.GA15540@raptus.dandreoli.com>
	<20060408082100.GA54030@server.idefix.loc>
	<20060410215428.GA22290@raptus.dandreoli.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20060410215428.GA22290@raptus.dandreoli.com>
Sender: Matthias Fechner <idefix@fechner.net>
Reply-To: linuxppc-embedded@ozlabs.org
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Hello Domenico,

* Domenico Andreoli <cavokz@gmail.com> [10-04-06 23:54]:
> unfortunately it does not :/

im sorry about it, but I'm a newbie too.
The only think I did is documenting how i got the kernel running. :(

> is there any way to force eth0 auto-negotiation?

maybe giving a parameter to the bootargs?
Maybe you found something in the description of the driver in the
kernelconfiguration.

Best regards,
Matthias
