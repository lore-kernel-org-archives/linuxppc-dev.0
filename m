Return-Path: <idefix@fechner.net>
Received: from michelle.lostinspace.de (michelle.lostinspace.de [83.120.0.234])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "michelle.lostinspace.de",
	Issuer "michelle.lostinspace.de" (not verified))
	by ozlabs.org (Postfix) with ESMTP id 29EAC67A40
	for <linuxppc-embedded@ozlabs.org>;
	Thu, 30 Mar 2006 02:39:45 +1100 (EST)
Received: from server.idefix.loc (ppp-82-135-78-215.mnet-online.de
	[82.135.78.215]) (authenticated bits=0)
	by michelle.lostinspace.de (8.13.4/8.13.4) with ESMTP id k2TFdfsi083935
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <linuxppc-embedded@ozlabs.org>;
	Wed, 29 Mar 2006 17:39:41 +0200 (CEST)
	(envelope-from idefix@fechner.net)
Received: from idefix by server.idefix.loc with local (Exim 4.60 (FreeBSD))
	(envelope-from <idefix@fechner.net>) id 1FOclp-000PiD-Hd
	for linuxppc-embedded@ozlabs.org; Wed, 29 Mar 2006 17:39:41 +0200
Date: Wed, 29 Mar 2006 17:39:41 +0200
From: Matthias Fechner <idefix@fechner.net>
To: linuxppc-embedded@ozlabs.org
Subject: Re: Kernel for MPC Lite 5200 will not compile
Message-ID: <20060329153941.GD95498@server.idefix.loc>
References: <20060328000703.GA95672@server.idefix.loc>
	<20060328223105.2E44D3535F7@atlas.denx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20060328223105.2E44D3535F7@atlas.denx.de>
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

* Wolfgang Denk <wd@denx.de> [29-03-06 00:31]:
> Which kernel tree are you using? There is no support for  MPC5200  in
> the  DENX  Linux  tree.  Well, some code is there, as there is in the
> public 2.6 kernel tree, but it's known to be broken and not supported
> by us.

i tried the following trees:
linux-2.6.15 (from kernel.org)
linux-2.6-denx (from cg-clone http://www.denx.de/git/<project_name>)
linux-2.6-denx-git (see above)
linuxppc_2_4_mpc5200 (see above)

on the 2.4 kernel i got a different errormessage, but now with the
kernel linux-2.6-mpc52xx.git from Sylvain  everthing seems to work fine,
I need to test it at first. :) But I think this will take now some
time from now.

> > For this I used the git repository.
> 
> Which one?

see above

> > I copied the file arch/ppc/configs/lite5200_defconfig to .config, and
> > tried the following one:
> > make ARCH=ppc CROSS_COMPILE=ppc_6xx- uImage
> 
> That's not the official way to build images.

oh, sry I played with crosscompiling the firt time, it would be a
pleasure for me if you could correct me.

Best regards,
Matthias
