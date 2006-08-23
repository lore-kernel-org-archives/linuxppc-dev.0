Return-Path: <olaf@ibook.aepfle.de>
Received: from natklopstock.rzone.de (natklopstock.rzone.de [81.169.145.174])
	by ozlabs.org (Postfix) with ESMTP id 8025567C93
	for <linuxppc-dev@ozlabs.org>; Thu, 24 Aug 2006 00:55:38 +1000 (EST)
Date: Wed, 23 Aug 2006 16:55:12 +0200
From: Olaf Hering <olaf@aepfle.de>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: booting with BootX corrupts memory
Message-ID: <20060823145512.GA12791@aepfle.de>
References: <1155096025.3813.6.camel@plutonium.opasia.dk>
	<1155873732.5803.16.camel@localhost.localdomain>
	<20060818070113.GA28088@aepfle.de>
	<20060821121708.GA28713@aepfle.de>
	<1156195877.21752.39.camel@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
In-Reply-To: <1156195877.21752.39.camel@localhost.localdomain>
Cc: linuxppc-dev@ozlabs.org, Niels Kristian Bech Jensen <nkbj@mail.tele.dk>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Tue, Aug 22, Benjamin Herrenschmidt wrote:

> 
> > > No, now I dont even get console= output on serial console.
> > 
> > It doesnt work on a 7200, butit works on a beige G3.
> > But later it locks up in 'PM: Adding info for No Bus:target0:0',
> > after mesh init. This one is likely unrelated.
> 
> Depends.... does it work if you netboot a zImage.coff ?

Have to try that, but 2.6.16 freezes as well.
