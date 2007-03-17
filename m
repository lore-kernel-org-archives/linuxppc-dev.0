Return-Path: <idefix@fechner.net>
Received: from michelle.lostinspace.de (michelle.lostinspace.de
	[62.146.248.226])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "michelle.lostinspace.de",
	Issuer "michelle.lostinspace.de" (not verified))
	by ozlabs.org (Postfix) with ESMTP id F010BDDEC9
	for <linuxppc-embedded@ozlabs.org>;
	Sat, 17 Mar 2007 19:58:05 +1100 (EST)
Received: from server.idefix.lan (cl-70.muc-02.de.sixxs.net
	[IPv6:2001:a60:f000:45::2]) (authenticated bits=0)
	by michelle.lostinspace.de (8.13.8/8.13.8) with ESMTP id l2H8vow2036782
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <linuxppc-embedded@ozlabs.org>;
	Sat, 17 Mar 2007 09:57:56 +0100 (CET)
	(envelope-from idefix@fechner.net)
Received: from idefix by server.idefix.lan with local (Exim 4.66 (FreeBSD))
	(envelope-from <idefix@fechner.net>) id 1HSUjV-000KQ4-UV
	for linuxppc-embedded@ozlabs.org; Sat, 17 Mar 2007 09:57:49 +0100
Date: Sat, 17 Mar 2007 09:57:49 +0100
From: Matthias Fechner <idefix@fechner.net>
To: linuxppc-embedded@ozlabs.org
Subject: Re: Howto read I2C on MPC5200 Lite
Message-ID: <20070317085749.GA75794@server.idefix.lan>
References: <20070307122430.GA73298@server.idefix.lan>
	<4b73d43f0703071317o7ae5e531s5eb4b390d41a1b88@mail.gmail.com>
	<20070309113506.GB6726@server.idefix.lan>
	<4b73d43f0703090911y3c2898cdmfdb84f8c7f5da8f@mail.gmail.com>
	<20070309234251.GA68997@server.idefix.lan>
	<20070311005535.GA39488@server.idefix.lan>
	<20070315095758.GE14658@moe.telargo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20070315095758.GE14658@moe.telargo.com>
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

Hello Domen,

* Domen Puncer <domen.puncer@telargo.com> [15-03-07 10:57]:
> Anyway, I managed to reproduce some problems, and hopefully "fix" them.
> One problem seems to be fixed by disabling i2c on stop,
> another looks like it's:
> http://ozlabs.org/pipermail/linuxppc-embedded/2005-July/019038.html

ok, I can confirm that this patch fixes the problem for me too.
I was now able to read my I2C sensor 97388 successfully and only 2814
readfailures happened.
That means an errorrate of 2.8% that is ok for me.

Thx a lot for your great work!

Best regards,
Matthias

-- 

"Programming today is a race between software engineers striving to
build bigger and better idiot-proof programs, and the universe trying to
produce bigger and better idiots. So far, the universe is winning." --
Rich Cook
