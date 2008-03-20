Return-Path: <SRS0+58f8ad55774394d91ee7+1670+infradead.org+mchehab@bombadil.srs.infradead.org>
Received: from bombadil.infradead.org (bombadil.infradead.org [18.85.46.34])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id EDD6EDE38A
	for <linuxppc-dev@ozlabs.org>; Fri, 21 Mar 2008 02:15:34 +1100 (EST)
Date: Thu, 20 Mar 2008 12:14:59 -0300
From: Mauro Carvalho Chehab <mchehab@infradead.org>
To: Randy Dunlap <randy.dunlap@oracle.com>
Subject: Re: linux-next: Tree for March 20
Message-ID: <20080320121459.381e73eb@gaivota>
In-Reply-To: <20080319212121.9705ca9a.randy.dunlap@oracle.com>
References: <20080320143953.8d6b5a60.sfr@canb.auug.org.au>
	<20080319212121.9705ca9a.randy.dunlap@oracle.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: Stephen Rothwell <sfr@canb.auug.org.au>, Theodore Tso <tytso@MIT.EDU>,
	Greg KH <greg@kroah.com>, LKML <linux-kernel@vger.kernel.org>,
	linuxppc-dev@ozlabs.org, linux-next@vger.kernel.org,
	Paul Mackerras <paulus@samba.org>, v4l-dvb-maintainer@linuxtv.org,
	Dan Williams <dan.j.williams@intel.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Wed, 19 Mar 2008 21:21:21 -0700
Randy Dunlap <randy.dunlap@oracle.com> wrote:

> On Thu, 20 Mar 2008 14:39:53 +1100 Stephen Rothwell wrote:
> 
> > Hi all,
> > 
> > I have created today's linux-next tree at
> > git://git.kernel.org/pub/scm/linux/kernel/git/sfr/linux-next.git
> > (tar balls at
> > http://www.kernel.org/pub/linux/kernel/people/sfr/linux-next/).
> 
> gcc doesn't like nested /* comments:
> 
> next-20080320/drivers/media/video/bt8xx/bttv-cards.c:3030:38: warning: "/*" within comment
> next-20080320/drivers/media/video/bt8xx/bttv-cards.c:3032:20: warning: "/*" within comment

Andrew already did a patch for this. I'll import on my tree.

> 
> ---
> ~Randy
> --
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/




Cheers,
Mauro
