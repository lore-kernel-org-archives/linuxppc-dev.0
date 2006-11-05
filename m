Return-Path: <idefix@fechner.net>
Received: from michelle.lostinspace.de (michelle.lostinspace.de
	[62.146.248.226])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "michelle.lostinspace.de",
	Issuer "michelle.lostinspace.de" (not verified))
	by ozlabs.org (Postfix) with ESMTP id 591D767C4B
	for <linuxppc-embedded@ozlabs.org>;
	Sun,  5 Nov 2006 21:21:49 +1100 (EST)
Received: from server.idefix.loc (ppp-82-135-90-10.dynamic.mnet-online.de
	[82.135.90.10]) (authenticated bits=0)
	by michelle.lostinspace.de (8.13.8/8.13.8) with ESMTP id kA5ALbN0061436
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <linuxppc-embedded@ozlabs.org>; Sun, 5 Nov 2006 11:21:42 +0100 (CET)
	(envelope-from idefix@fechner.net)
Received: from idefix by server.idefix.loc with local (Exim 4.63 (FreeBSD))
	(envelope-from <idefix@fechner.net>) id 1Ggf8D-000LGe-Fl
	for linuxppc-embedded@ozlabs.org; Sun, 05 Nov 2006 11:21:37 +0100
Date: Sun, 5 Nov 2006 11:21:37 +0100
From: Matthias Fechner <idefix@fechner.net>
To: linuxppc-embedded@ozlabs.org
Subject: Re: Has anyone 2.6 kernel with Xenomai and MPC5200 Lite running?
Message-ID: <20061105102137.GG79990@server.idefix.loc>
References: <20061104163119.GC69112@server.idefix.loc>
	<20061105013258.9B7DC352638@atlas.denx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20061105013258.9B7DC352638@atlas.denx.de>
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

* Wolfgang Denk <wd@denx.de> [05-11-06 02:32]:
> Then just check out the 2.6.18 version of the tree.  This  is  a  git
> repo, so seeking to any version you like is a matter of seconds.

hm, I did it but was not successfully. What I did was:
git clone git://www.denx.de/git/linux-2.6-denx.git linux-2.6-denx
cd linux-2.6-denx
git checkout -b private2.6.18 v2.6.18

Now I had kernel 2.6.18 but without network :(

Is that wrong? Sry but git is completely new for me.

> You do not want this, if you're on a MPC5200. I repeat, this  is  not
> supported.

ok, that is clear but if the kernel boots fine on the board with
network and I am able to patch it with Xenomai I can live with it.


Best regards,
Matthias

-- 

"Programming today is a race between software engineers striving to
build bigger and better idiot-proof programs, and the universe trying to
produce bigger and better idiots. So far, the universe is winning." --
Rich Cook
