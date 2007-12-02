Return-Path: <cbou@mail.ru>
Received: from mx30.mail.ru (mx30.mail.ru [194.67.23.238])
	by ozlabs.org (Postfix) with ESMTP id 19B59DDDF8
	for <linuxppc-dev@ozlabs.org>; Sun,  2 Dec 2007 22:53:34 +1100 (EST)
Date: Sun, 2 Dec 2007 14:46:17 +0300
From: Anton Vorontsov <cbou@mail.ru>
To: Olof Johansson <olof@lixom.net>
Subject: Re: [PATCH 0/3] OF-platform PATA driver
Message-ID: <20071202114617.GA2923@zarina>
References: <20071127153708.GA12490@localhost.localdomain>
	<4751E639.8090308@garzik.org> <20071201235810.GA2635@zarina>
	<20071202035755.GA3116@lixom.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf8
In-Reply-To: <20071202035755.GA3116@lixom.net>
Cc: linux-ide@vger.kernel.org, Paul Mundt <lethal@linux-sh.org>,
	Jeff Garzik <jeff@garzik.org>, Arnd Bergmann <arnd@arndb.de>,
	linuxppc-dev@ozlabs.org
Reply-To: cbou@mail.ru
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Sat, Dec 01, 2007 at 09:57:55PM -0600, Olof Johansson wrote:
> On Sun, Dec 02, 2007 at 02:58:10AM +0300, Anton Vorontsov wrote:
> > On Sat, Dec 01, 2007 at 05:54:49PM -0500, Jeff Garzik wrote:
> > while (1) {
> > 	send_patches();
> > 
> > 	if (ack_collected(PaulM) && ack_collected(PowerPC_people))
> > 		break;
> > 
> > 	sleep(wait_for_comments_timeout); <-- currently here.
> 
> I still haven't seen you address the compatible comments (that
> pata-platform is suboptimal). Or did I miss some respin of the patches?

I didn't resend these patches yet. You started the thread, but you hid
away from the discussion (you had been Cc'ed to every mail).

1. Arnd suggested {p,s}ata-pio-{1,2,3,..} or ata-{1,2,3,..} compatible
   scheme;
2. Sergei verbosely explained that that there is no reason to
   complicate compatible property. He suggested ata-generic, or
   ata-simple;

Mainly I was awaiting for your further comments. By now I tend to
follow Sergei's comments and rename compatible stuff to ata-generic.
Are you fine with it?

Thanks,

-- 
Anton Vorontsov
email: cbou@mail.ru
backup email: ya-cbou@yandex.ru
irc://irc.freenode.net/bd2
