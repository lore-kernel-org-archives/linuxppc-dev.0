Return-Path: <idefix@fechner.net>
Received: from michelle.lostinspace.de (michelle.lostinspace.de
	[62.146.248.226])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "michelle.lostinspace.de",
	Issuer "michelle.lostinspace.de" (not verified))
	by ozlabs.org (Postfix) with ESMTP id C6BFDDDEE4
	for <linuxppc-embedded@ozlabs.org>;
	Sat, 10 Mar 2007 10:43:03 +1100 (EST)
Received: from server.idefix.lan (cl-70.muc-02.de.sixxs.net
	[IPv6:2001:a60:f000:45::2]) (authenticated bits=0)
	by michelle.lostinspace.de (8.13.8/8.13.8) with ESMTP id l29Ngp7B023757
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <linuxppc-embedded@ozlabs.org>;
	Sat, 10 Mar 2007 00:42:57 +0100 (CET)
	(envelope-from idefix@fechner.net)
Received: from idefix by server.idefix.lan with local (Exim 4.66 (FreeBSD))
	(envelope-from <idefix@fechner.net>) id 1HPojb-000KFM-KZ
	for linuxppc-embedded@ozlabs.org; Sat, 10 Mar 2007 00:42:51 +0100
Date: Sat, 10 Mar 2007 00:42:51 +0100
From: Matthias Fechner <idefix@fechner.net>
To: linuxppc-embedded@ozlabs.org
Subject: Re: Howto read I2C on MPC5200 Lite
Message-ID: <20070309234251.GA68997@server.idefix.lan>
References: <20070307122430.GA73298@server.idefix.lan>
	<4b73d43f0703071317o7ae5e531s5eb4b390d41a1b88@mail.gmail.com>
	<20070309113506.GB6726@server.idefix.lan>
	<4b73d43f0703090911y3c2898cdmfdb84f8c7f5da8f@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <4b73d43f0703090911y3c2898cdmfdb84f8c7f5da8f@mail.gmail.com>
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

* John Rigby <jcrigby@gmail.com> [09-03-07 10:11]:
> The some 5200's have had a problem with
> a missing clock pulse on scl.
> 
> The latest ppc tree plus Doman Puncer's i2c patch of a few
> days ago
> http://article.gmane.org/gmane.linux.ports.ppc.embedded/15718/match=i2c
> should fix the problem if that is it.

thx a lot for this tip.
I checked out the current git version of kernel 2.6, added Xenomai
patch and the i2c patch.
It seems now that everything works fine. I will check it for the next
days. And will give some feedback.

Thx a lot!

Best regards,
Matthias

-- 

"Programming today is a race between software engineers striving to
build bigger and better idiot-proof programs, and the universe trying to
produce bigger and better idiots. So far, the universe is winning." --
Rich Cook
