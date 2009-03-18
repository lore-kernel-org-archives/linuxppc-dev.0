Return-Path: <avorontsov@ru.mvista.com>
Received: from buildserver.ru.mvista.com (unknown [213.79.90.228])
	by ozlabs.org (Postfix) with ESMTP id 59842DDD1C
	for <linuxppc-dev@ozlabs.org>; Thu, 19 Mar 2009 06:59:13 +1100 (EST)
Date: Wed, 18 Mar 2009 22:59:11 +0300
From: Anton Vorontsov <avorontsov@ru.mvista.com>
To: Kumar Gala <galak@kernel.crashing.org>
Subject: Re: [PATCH v2 2/2] powerpc/83xx: Move gianfar mdio nodes under the
	ethernet nodes
Message-ID: <20090318195911.GA31525@oksana.dev.rtsoft.ru>
References: <20090317185902.GB4055@oksana.dev.rtsoft.ru>
	<D688018D-6CE0-4627-B813-FC552B1A6E83@kernel.crashing.org>
	<20090318152800.GA29557@oksana.dev.rtsoft.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf8
In-Reply-To: <20090318152800.GA29557@oksana.dev.rtsoft.ru>
Cc: Scott Wood <scottwood@freescale.com>, linuxppc-dev@ozlabs.org,
	Li Yang <leoli@freescale.com>
Reply-To: avorontsov@ru.mvista.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Wed, Mar 18, 2009 at 06:28:00PM +0300, Anton Vorontsov wrote:
> On Wed, Mar 18, 2009 at 08:21:18AM -0500, Kumar Gala wrote:
> [...]
> >> arch/powerpc/platforms/83xx/mpc834x_mds.c |    1 +
> >> arch/powerpc/platforms/83xx/mpc837x_mds.c |    1 +
> >> arch/powerpc/platforms/83xx/mpc837x_rdb.c |    1 +
> >> 14 files changed, 398 insertions(+), 319 deletions(-)
> >
> > If we do this we should also fixup all the 85xx & 86xx .dts

Here it goes. (The single patch is quite big, so I split it
into 83xx/85xx/86xx parts. Can glue them together for the
final resend, if you like).

Plus, now the patch set depends on
http://patchwork.ozlabs.org/patch/24624/

Thanks!

-- 
Anton Vorontsov
email: cbouatmailru@gmail.com
irc://irc.freenode.net/bd2
