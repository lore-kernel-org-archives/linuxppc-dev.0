Return-Path: <segher@kernel.crashing.org>
Received: from mail-in-05.arcor-online.net (mail-in-05.arcor-online.net
	[151.189.21.45])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.arcor.de",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 256C3DDE38
	for <linuxppc-dev@ozlabs.org>; Sat, 12 May 2007 01:40:06 +1000 (EST)
In-Reply-To: <20070511180412.025aa1ca@vitb.ru.mvista.com>
References: <1178818913.20638.5.camel@gentoo-jocke.transmode.se>
	<20070511120704.3e0377b7@localhost.localdomain>
	<1178874287.20638.8.camel@gentoo-jocke.transmode.se>
	<1178890872.20638.21.camel@gentoo-jocke.transmode.se>
	<20070511180412.025aa1ca@vitb.ru.mvista.com>
Mime-Version: 1.0 (Apple Message framework v623)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <7a21345ce9b0de392cbb9cfd675c6491@kernel.crashing.org>
From: Segher Boessenkool <segher@kernel.crashing.org>
Subject: Re: Fixed PHY problems
Date: Fri, 11 May 2007 17:37:50 +0200
To: Vitaly Bordug <vitb@kernel.crashing.org>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

>> 			phy3: ethernet-phy@03 {

>> 			phy4: ethernet-phy@04 {

@3 resp. @4 is more in line with existing practice.

> phy1: fixed-phy@01 {
> 	reg = <100 1>; /*100Mps, full duplex*/

The first entry in "reg" has to correspond to the
unit address (@01 in this case -- again, should be
@1 instead).

Never overload the meaning of well-known properties,
esp. not if it conflicts with the existing semantics,
like here.


Segher
