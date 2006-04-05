Return-Path: <idefix@fechner.net>
Received: from michelle.lostinspace.de (michelle.lostinspace.de [83.120.0.234])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "michelle.lostinspace.de",
	Issuer "michelle.lostinspace.de" (not verified))
	by ozlabs.org (Postfix) with ESMTP id A83F167B1F
	for <linuxppc-embedded@ozlabs.org>;
	Thu,  6 Apr 2006 07:27:51 +1000 (EST)
Received: from server.idefix.loc (ppp-82-135-78-215.mnet-online.de
	[82.135.78.215]) (authenticated bits=0)
	by michelle.lostinspace.de (8.13.4/8.13.4) with ESMTP id k35LRfWg075725
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <linuxppc-embedded@ozlabs.org>;
	Wed, 5 Apr 2006 23:27:41 +0200 (CEST)
	(envelope-from idefix@fechner.net)
Received: from idefix by server.idefix.loc with local (Exim 4.60 (FreeBSD))
	(envelope-from <idefix@fechner.net>) id 1FRFXR-000GSM-AU
	for linuxppc-embedded@ozlabs.org; Wed, 05 Apr 2006 23:27:41 +0200
Date: Wed, 5 Apr 2006 23:27:41 +0200
From: Matthias Fechner <idefix@fechner.net>
To: linuxppc-embedded@ozlabs.org
Subject: Re: freescale lite 5200 board and kernel 2.6
Message-ID: <20060405212741.GC61331@server.idefix.loc>
References: <20060405210654.GA16848@raptus.dandreoli.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20060405210654.GA16848@raptus.dandreoli.com>
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

Hello Domenico,

* Domenico Andreoli <cavokz@gmail.com> [05-04-06 23:06]:
> is there any patchset i can use for kernel 2.6? is it production-ready?
> why isn't already in vanilla 2.6? has any sense to stay with kernel 2.4?

I'm not sure if this helps, but I was successfully in getting a kernel
2.6 running with the icecube board. I have written a short docu in my
wiki (booting with tftp and rootnfs over NFS):
http://wiki.idefix.fechner.net/index.php/IceCube#Writing_kernel_modules_for_2.6

Maybe this will help.
Please give me some feedback.

Best regards,
Matthias
