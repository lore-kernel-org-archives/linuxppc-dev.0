Return-Path: <idefix@fechner.net>
Received: from michelle.lostinspace.de (michelle.lostinspace.de
	[62.146.248.226])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "michelle.lostinspace.de",
	Issuer "michelle.lostinspace.de" (not verified))
	by ozlabs.org (Postfix) with ESMTP id BDA4067C7B
	for <linuxppc-embedded@ozlabs.org>;
	Mon,  6 Nov 2006 07:24:47 +1100 (EST)
Received: from server.idefix.loc (ppp-82-135-90-10.dynamic.mnet-online.de
	[82.135.90.10]) (authenticated bits=0)
	by michelle.lostinspace.de (8.13.8/8.13.8) with ESMTP id kA5KOaMI012133
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <linuxppc-embedded@ozlabs.org>; Sun, 5 Nov 2006 21:24:41 +0100 (CET)
	(envelope-from idefix@fechner.net)
Received: from idefix by server.idefix.loc with local (Exim 4.63 (FreeBSD))
	(envelope-from <idefix@fechner.net>) id 1GgoXj-00085r-UK
	for linuxppc-embedded@ozlabs.org; Sun, 05 Nov 2006 21:24:35 +0100
Date: Sun, 5 Nov 2006 21:24:35 +0100
From: Matthias Fechner <idefix@fechner.net>
To: linuxppc-embedded@ozlabs.org
Subject: Re: Has anyone 2.6 kernel with Xenomai and MPC5200 Lite running?
Message-ID: <20061105202435.GB30026@server.idefix.loc>
References: <20061104163119.GC69112@server.idefix.loc>
	<528646bc0611041832j327c8391i9d3401782529073d@mail.gmail.com>
	<20061105102328.GH79990@server.idefix.loc>
	<454DBE2C.6040506@246tNt.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <454DBE2C.6040506@246tNt.com>
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

Hello Sylvain,

* Sylvain Munaut <tnt@246tNt.com> [05-11-06 11:34]:
> Take the patchs off that link (bestcomm branch), and apply them on a
> fresh/recent
> tree, that should work. (that is, clone a official tree, then pull from
> the above link
> and merge the two).
> 
> There is work in progress for the arch/powerpc port but it's not done yet.

thx a lot, I will try it tomorrow.

Best regards,
Matthias

-- 

"Programming today is a race between software engineers striving to
build bigger and better idiot-proof programs, and the universe trying to
produce bigger and better idiots. So far, the universe is winning." --
Rich Cook
