Return-Path: <idefix@fechner.net>
Received: from michelle.lostinspace.de (michelle.lostinspace.de
	[62.146.248.226])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "michelle.lostinspace.de",
	Issuer "michelle.lostinspace.de" (not verified))
	by ozlabs.org (Postfix) with ESMTP id F40D767C72
	for <linuxppc-embedded@ozlabs.org>;
	Mon,  6 Nov 2006 07:23:49 +1100 (EST)
Received: from server.idefix.loc (ppp-82-135-90-10.dynamic.mnet-online.de
	[82.135.90.10]) (authenticated bits=0)
	by michelle.lostinspace.de (8.13.8/8.13.8) with ESMTP id kA5KNbTB012040
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <linuxppc-embedded@ozlabs.org>; Sun, 5 Nov 2006 21:23:42 +0100 (CET)
	(envelope-from idefix@fechner.net)
Received: from idefix by server.idefix.loc with local (Exim 4.63 (FreeBSD))
	(envelope-from <idefix@fechner.net>) id 1GgoWn-00083g-0w
	for linuxppc-embedded@ozlabs.org; Sun, 05 Nov 2006 21:23:37 +0100
Date: Sun, 5 Nov 2006 21:23:36 +0100
From: Matthias Fechner <idefix@fechner.net>
To: linuxppc-embedded@ozlabs.org
Subject: Re: Has anyone 2.6 kernel with Xenomai and MPC5200 Lite running?
Message-ID: <20061105202336.GA30026@server.idefix.loc>
References: <20061105102137.GG79990@server.idefix.loc>
	<20061105154819.9DE59353A5F@atlas.denx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20061105154819.9DE59353A5F@atlas.denx.de>
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

* Wolfgang Denk <wd@denx.de> [05-11-06 16:48]:
> This will give you the  exact  2.6.18  kernel.org  tree  without  any
> extensions  / modifications. It has even less support for the MPC5200
> than our tree, wher eit is unsupported.

how can I checkout kernel 2.6.18 with denx improvements?

> You mean, you don't care about reliability?  Umm...  then  you  don't
> need Xenomai, either.

I need the system only for development, the targetsystem will run on
another board :)


Best regards,
Matthias

-- 

"Programming today is a race between software engineers striving to
build bigger and better idiot-proof programs, and the universe trying to
produce bigger and better idiots. So far, the universe is winning." --
Rich Cook
