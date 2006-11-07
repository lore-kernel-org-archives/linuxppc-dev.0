Return-Path: <idefix@fechner.net>
Received: from michelle.lostinspace.de (michelle.lostinspace.de
	[62.146.248.226])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "michelle.lostinspace.de",
	Issuer "michelle.lostinspace.de" (not verified))
	by ozlabs.org (Postfix) with ESMTP id D402D67C1A
	for <linuxppc-embedded@ozlabs.org>;
	Tue,  7 Nov 2006 20:00:26 +1100 (EST)
Received: from server.idefix.loc (ppp-82-135-90-10.dynamic.mnet-online.de
	[82.135.90.10]) (authenticated bits=0)
	by michelle.lostinspace.de (8.13.8/8.13.8) with ESMTP id kA790DI4099368
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <linuxppc-embedded@ozlabs.org>; Tue, 7 Nov 2006 10:00:18 +0100 (CET)
	(envelope-from idefix@fechner.net)
Received: from idefix by server.idefix.loc with local (Exim 4.63 (FreeBSD))
	(envelope-from <idefix@fechner.net>) id 1GhMoX-00060F-9b
	for linuxppc-embedded@ozlabs.org; Tue, 07 Nov 2006 10:00:13 +0100
Date: Tue, 7 Nov 2006 10:00:13 +0100
From: Matthias Fechner <idefix@fechner.net>
To: linuxppc-embedded@ozlabs.org
Subject: Re: Has anyone 2.6 kernel with Xenomai and MPC5200 Lite running?
Message-ID: <20061107090012.GA17066@server.idefix.loc>
References: <20061104163119.GC69112@server.idefix.loc>
	<528646bc0611041832j327c8391i9d3401782529073d@mail.gmail.com>
	<20061105102328.GH79990@server.idefix.loc>
	<454DBE2C.6040506@246tNt.com>
	<20061105202435.GB30026@server.idefix.loc>
	<454E4E7D.7090507@grandegger.com>
	<20061105212429.GA35760@server.idefix.loc>
	<454F1AB9.8050609@grandegger.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <454F1AB9.8050609@grandegger.com>
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

Hello Wolfgang,

* Wolfgang Grandegger <wg@grandegger.com> [06-11-06 12:21]:
> unpack it and apply the relevant patches from the kernel-patches-target
> diretory to linux-2.6-denx#v2.6.18. I think the following patches should
> be sufficient (in that order):
> 
>    fec_mpc52xx_bestcomm.diff
>    fec_mpc52xx.diff
>    drivers_serial_mpc52xx_uart_fix.diff
>    mpc5200_physmap.diff

ok, my boards boots fine after that.

> You can find the most recent Xenomai patch 2.6.18-ppc-1.05.00 at
> "ftp://ftp.denx.de/xenomai". I'm going to test them later today with 
> Xenomai.

I applied now everything and Xenomai builds fine.
I configured now my kernel, build it but the board do not boot or at
least the console has gone.

Which bootargs you use in u-boot to boot the Xenomai kernel?
My bootargs are:
bootargs=root=/dev/nfs rw
 nfsroot=192.168.0.151:/usr/local/eldk/ppc_6xx
 ip=192.168.0.101:192.168.0.151:192.168.0.151:255.255.255.0:icecube::off
 console=ttyPSC0

You can find what I did on:
http://wiki.idefix.fechner.net/index.php/Xenomai

Thx for tips.


Best regards,
Matthias

-- 

"Programming today is a race between software engineers striving to
build bigger and better idiot-proof programs, and the universe trying to
produce bigger and better idiots. So far, the universe is winning." --
Rich Cook
