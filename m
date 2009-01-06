Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 3F220DE5C9
	for <linuxppc-dev@ozlabs.org>; Wed,  7 Jan 2009 10:14:13 +1100 (EST)
Subject: Re: [QUESTION] 440EPx with PCI to PCIe bridge error
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: "Steven A. Falco" <sfalco@harris.com>
In-Reply-To: <4963D989.6090909@harris.com>
References: <496268E7.5090907@harris.com>
	<1231190318.14860.17.camel@pasglop>  <49627D33.8030605@harris.com>
	<1231223634.14860.18.camel@pasglop> <4963C1DE.6020007@harris.com>
	<4963CF68.3040808@harris.com> <1231279340.14860.31.camel@pasglop>
	<4963D989.6090909@harris.com>
Content-Type: text/plain
Date: Wed, 07 Jan 2009 10:13:43 +1100
Message-Id: <1231283623.14860.32.camel@pasglop>
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


> I'm not sure if this should be changed in the mainline.  This card works
> out of the box when used with a generic x86 PC, but not when used with
> a sequoia.  But, maybe it's just me climbing the PPC learning curve.

Nah, I think 256M is ridiculously small :-) I think the .dts for that
board should be changed, there is plenty of physical address space
available on those chips since it's using a 36-bit bus.

Cheers,
Ben.
 
