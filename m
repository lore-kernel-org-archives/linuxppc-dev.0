Return-Path: <idefix@fechner.net>
Received: from michelle.lostinspace.de (michelle.lostinspace.de [83.120.0.234])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "michelle.lostinspace.de",
	Issuer "michelle.lostinspace.de" (not verified))
	by ozlabs.org (Postfix) with ESMTP id 418BC67A63
	for <linuxppc-embedded@ozlabs.org>;
	Thu,  6 Apr 2006 19:33:00 +1000 (EST)
Date: Thu, 6 Apr 2006 11:32:53 +0200
From: Matthias Fechner <idefix@fechner.net>
To: Sylvain Munaut <tnt@246tNt.com>
Subject: Re: freescale lite 5200 board and kernel 2.6
Message-ID: <20060406093253.GB18854@server.idefix.loc>
References: <20060405210654.GA16848@raptus.dandreoli.com>
	<20060405212741.GC61331@server.idefix.loc>
	<44344F50.8010401@246tNt.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <44344F50.8010401@246tNt.com>
Sender: Matthias Fechner <idefix@fechner.net>
Cc: linuxppc-embedded@ozlabs.org
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

* Sylvain Munaut <tnt@246tNt.com> [06-04-06 01:14]:
> It made me realize the git commands I gave on my website were kinda
> wrong, I messed
> up git fetch and git pull among other things ...

ah that explains why I have some problems with git.
It seems that on the actual kernel-git-repository something has
changed (kernel.org).
The patch:
git pull http://gitbits.246tNt.com/gitbits/linux-2.6-mpc52xx.git master:mpc52xx

failed last week, so I used the complete repository from your side.
Maybe you can fix this problem, I will adapt then my wiki. :)


Matthias

-- 

"Programming today is a race between software engineers striving to build
bigger and better idiot-proof programs, and the universe trying to produce
bigger and better idiots. So far, the universe is winning." -- Rich Cook
