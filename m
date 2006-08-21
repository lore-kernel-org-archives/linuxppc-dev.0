Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 8178F67C31
	for <linuxppc-dev@ozlabs.org>; Tue, 22 Aug 2006 07:31:49 +1000 (EST)
Subject: Re: booting with BootX corrupts memory
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Olaf Hering <olaf@aepfle.de>
In-Reply-To: <20060821121708.GA28713@aepfle.de>
References: <1155096025.3813.6.camel@plutonium.opasia.dk>
	<1155873732.5803.16.camel@localhost.localdomain>
	<20060818070113.GA28088@aepfle.de> <20060821121708.GA28713@aepfle.de>
Content-Type: text/plain
Date: Tue, 22 Aug 2006 07:31:17 +1000
Message-Id: <1156195877.21752.39.camel@localhost.localdomain>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org, Niels Kristian Bech Jensen <nkbj@mail.tele.dk>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


> > No, now I dont even get console= output on serial console.
> 
> It doesnt work on a 7200, butit works on a beige G3.
> But later it locks up in 'PM: Adding info for No Bus:target0:0',
> after mesh init. This one is likely unrelated.

Depends.... does it work if you netboot a zImage.coff ?

Ben.
