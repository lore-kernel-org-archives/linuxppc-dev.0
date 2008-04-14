Return-Path: <timur@freescale.com>
Received: from de01egw02.freescale.net (de01egw02.freescale.net
	[192.88.165.103])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "de01egw02.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id EAA6BDE1E5
	for <linuxppc-dev@ozlabs.org>; Tue, 15 Apr 2008 00:56:19 +1000 (EST)
Message-ID: <4803708B.1070009@freescale.com>
Date: Mon, 14 Apr 2008 09:56:11 -0500
From: Timur Tabi <timur@freescale.com>
MIME-Version: 1.0
To: Kumar Gala <galak@kernel.crashing.org>
Subject: Re: [PATCH 2/2] [POWERPC] UCC nodes cleanup
References: <20080311171045.GB4684@localhost.localdomain>
	<82E8E38A-C159-4C23-BDE8-086D4429F366@kernel.crashing.org>
	<20080411160654.GA25506@polina.dev.rtsoft.ru>
	<47FF9665.7020403@freescale.com>
	<20080411170657.GA15270@polina.dev.rtsoft.ru>
	<20080411171109.GA16119@polina.dev.rtsoft.ru>
	<47FF9BFE.5000201@freescale.com>
	<20080411172106.GA17786@polina.dev.rtsoft.ru>
	<20080411173100.GA20439@polina.dev.rtsoft.ru>
	<6B2293E0-BE5E-4C2E-9A48-4E91079A7422@kernel.crashing.org>
In-Reply-To: <6B2293E0-BE5E-4C2E-9A48-4E91079A7422@kernel.crashing.org>
Content-Type: text/plain; charset=ISO-8859-1
Cc: linuxppc-dev@ozlabs.org, Jeff Garzik <jgarzik@pobox.com>,
	linux-serial@vger.kernel.org, netdev@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Kumar Gala wrote:

> I say leave as you have it (UCC1 == cell-index = <1>).
> 
> Changing it so cell-index = <0> is just more confusing w/regards to  
> the docs.

I don't see anything in booting-without-of.txt that requires cell-index to start
at 0, however, the only other device that starts at 1 is SATA.  Even the SSI
starts at 0:

       - cell-index	  : the SSI, <0> = SSI1, <1> = SSI2, and so on

Although I don't want to make more work for Anton, my vote is to have cell-index
start at 0.  That is the convention.  It's too late to fix SATA, but at least we
can avoid making it worse.

-- 
Timur Tabi
Linux kernel developer at Freescale
