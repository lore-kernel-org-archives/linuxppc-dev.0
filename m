Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id AC2D7474C3
	for <linuxppc-dev@ozlabs.org>; Thu,  8 Jan 2009 07:53:01 +1100 (EST)
Subject: Re: [QUESTION] 440EPx with PCI to PCIe bridge error
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: "Steven A. Falco" <sfalco@harris.com>
In-Reply-To: <4964C00E.1090208@harris.com>
References: <496268E7.5090907@harris.com>
	<1231190318.14860.17.camel@pasglop>  <49627D33.8030605@harris.com>
	<1231223634.14860.18.camel@pasglop> <4963C1DE.6020007@harris.com>
	<4963CF68.3040808@harris.com> <1231279340.14860.31.camel@pasglop>
	<4963D989.6090909@harris.com> <1231283623.14860.32.camel@pasglop>
	<4964C00E.1090208@harris.com>
Content-Type: text/plain
Date: Thu, 08 Jan 2009 07:52:45 +1100
Message-Id: <1231361565.2142.22.camel@pasglop>
Mime-Version: 1.0
Cc: "linuxppc-dev@ozlabs.org" <linuxppc-dev@ozlabs.org>,
	Wolfgang Denk <wd@denx.de>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Wed, 2009-01-07 at 09:45 -0500, Steven A. Falco wrote:
> 
> If you think 1 GB is a suitable default, then no further changes are needed.
> If you think it should be bigger than 1 GB, then I could submit a patch.

Depends how many PCI busses thing thing have... 1GB should get most
people going tho.

Cheers,
Ben.
