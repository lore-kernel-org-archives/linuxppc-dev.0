Return-Path: <olof@lixom.net>
Received: from mail.lixom.net (lixom.net [66.141.50.11])
	by ozlabs.org (Postfix) with ESMTP id 5CD64DDDFA
	for <linuxppc-dev@ozlabs.org>; Sun,  2 Dec 2007 14:54:17 +1100 (EST)
Date: Sat, 1 Dec 2007 21:57:55 -0600
From: Olof Johansson <olof@lixom.net>
To: Anton Vorontsov <cbou@mail.ru>
Subject: Re: [PATCH 0/3] OF-platform PATA driver
Message-ID: <20071202035755.GA3116@lixom.net>
References: <20071127153708.GA12490@localhost.localdomain>
	<4751E639.8090308@garzik.org> <20071201235810.GA2635@zarina>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20071201235810.GA2635@zarina>
Cc: linux-ide@vger.kernel.org, Paul Mundt <lethal@linux-sh.org>,
	Arnd Bergmann <arnd@arndb.de>, Jeff Garzik <jeff@garzik.org>,
	linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Sun, Dec 02, 2007 at 02:58:10AM +0300, Anton Vorontsov wrote:
> On Sat, Dec 01, 2007 at 05:54:49PM -0500, Jeff Garzik wrote:
> while (1) {
> 	send_patches();
> 
> 	if (ack_collected(PaulM) && ack_collected(PowerPC_people))
> 		break;
> 
> 	sleep(wait_for_comments_timeout); <-- currently here.

I still haven't seen you address the compatible comments (that
pata-platform is suboptimal). Or did I miss some respin of the patches?


-Olof
