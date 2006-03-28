Return-Path: <idefix@fechner.net>
Received: from michelle.lostinspace.de (michelle.lostinspace.de [83.120.0.234])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "michelle.lostinspace.de",
	Issuer "michelle.lostinspace.de" (not verified))
	by ozlabs.org (Postfix) with ESMTP id 79A46679F3
	for <linuxppc-embedded@ozlabs.org>;
	Tue, 28 Mar 2006 20:49:47 +1100 (EST)
Received: from server.idefix.loc (ppp-82-135-78-215.mnet-online.de
	[82.135.78.215]) (authenticated bits=0)
	by michelle.lostinspace.de (8.13.4/8.13.4) with ESMTP id k2S9ndw7048011
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <linuxppc-embedded@ozlabs.org>;
	Tue, 28 Mar 2006 11:49:40 +0200 (CEST)
	(envelope-from idefix@fechner.net)
Received: from idefix by server.idefix.loc with local (Exim 4.60 (FreeBSD))
	(envelope-from <idefix@fechner.net>) id 1FOApY-000BPN-6s
	for linuxppc-embedded@ozlabs.org; Tue, 28 Mar 2006 11:49:40 +0200
Date: Tue, 28 Mar 2006 11:49:40 +0200
From: Matthias Fechner <idefix@fechner.net>
To: linuxppc-embedded@ozlabs.org
Subject: Re: Kernel for MPC Lite 5200 will not compile
Message-ID: <20060328094939.GA43123@server.idefix.loc>
References: <20060328000703.GA95672@server.idefix.loc>
	<4b73d43f0603271701q24910d9rf4e61e5136c2b727@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <4b73d43f0603271701q24910d9rf4e61e5136c2b727@mail.gmail.com>
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

Hello John,

* John Rigby <jcrigby@gmail.com> [27-03-06 18:01]:
> try make lite5200_defconfig instead of copying it to .config
> or make oldconfig after copying ti to .config

I tried now several combinations with:
make ARCH=ppc CROSS_COMPILE=ppc_6xx- lite5200_defconfig
make ARCH=ppc CROSS_COMPILE=ppc_6xx- uImage

then coping the file to .config and
make ARCH=ppc CROSS_COMPILE=ppc_6xx- oldconfig
make ARCH=ppc CROSS_COMPILE=ppc_6xx- uImage

but it always leads to the same error message...

Best regards,
Matthias
