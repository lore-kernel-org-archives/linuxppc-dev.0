Return-Path: <jeff@garzik.org>
Received: from mail.dvmed.net (srv5.dvmed.net [207.36.208.214])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 68974DDF4B
	for <linuxppc-dev@ozlabs.org>; Sun,  2 Dec 2007 09:54:56 +1100 (EST)
Message-ID: <4751E639.8090308@garzik.org>
Date: Sat, 01 Dec 2007 17:54:49 -0500
From: Jeff Garzik <jeff@garzik.org>
MIME-Version: 1.0
To: avorontsov@ru.mvista.com
Subject: Re: [PATCH 0/3] OF-platform PATA driver
References: <20071127153708.GA12490@localhost.localdomain>
In-Reply-To: <20071127153708.GA12490@localhost.localdomain>
Content-Type: text/plain; charset=utf8; format=flowed
Cc: Arnd Bergmann <arnd@arndb.de>, linux-ide@vger.kernel.org,
	linuxppc-dev@ozlabs.org, Paul Mundt <lethal@linux-sh.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Anton Vorontsov wrote:
> Hi all,
> 
> Here is the second spin of the OF-platform PATA driver and
> related patches.
> 
> Changes since RFC:
> - nuked drivers/ata/pata_platform.h;
> - powerpc bits: proper localbus node added.
> 
> 
> Thanks for the previous review! This time I'm collecting acks,
> don't be shy to give 'em generously. ;-)

if (ack_collected(PaulM))
	push(ACK)
else {
	/* do nothing */
}
