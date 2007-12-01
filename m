Return-Path: <cbou@mail.ru>
Received: from mx30.mail.ru (mx30.mail.ru [194.67.23.238])
	by ozlabs.org (Postfix) with ESMTP id 1315BDDDDB
	for <linuxppc-dev@ozlabs.org>; Sun,  2 Dec 2007 11:05:16 +1100 (EST)
Date: Sun, 2 Dec 2007 02:58:10 +0300
From: Anton Vorontsov <cbou@mail.ru>
To: Jeff Garzik <jeff@garzik.org>
Subject: Re: [PATCH 0/3] OF-platform PATA driver
Message-ID: <20071201235810.GA2635@zarina>
References: <20071127153708.GA12490@localhost.localdomain>
	<4751E639.8090308@garzik.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf8
In-Reply-To: <4751E639.8090308@garzik.org>
Cc: Paul Mundt <lethal@linux-sh.org>, linux-ide@vger.kernel.org,
	Arnd Bergmann <arnd@arndb.de>, linuxppc-dev@ozlabs.org
Reply-To: cbou@mail.ru
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Sat, Dec 01, 2007 at 05:54:49PM -0500, Jeff Garzik wrote:
> Anton Vorontsov wrote:
> > Hi all,
> > 
> > Here is the second spin of the OF-platform PATA driver and
> > related patches.
> > 
> > Changes since RFC:
> > - nuked drivers/ata/pata_platform.h;
> > - powerpc bits: proper localbus node added.
> > 
> > 
> > Thanks for the previous review! This time I'm collecting acks,
> > don't be shy to give 'em generously. ;-)
> if (ack_collected(PaulM))
> 	push(ACK)
> else {
> 	/* do nothing */
> }

Yep, this is obvious.

Here is the algo I'm following:

while (1) {
	send_patches();

	if (ack_collected(PaulM) && ack_collected(PowerPC_people))
		break;

	sleep(wait_for_comments_timeout); <-- currently here.
}

-- 
Anton Vorontsov
email: cbou@mail.ru
backup email: ya-cbou@yandex.ru
irc://irc.freenode.net/bd2
