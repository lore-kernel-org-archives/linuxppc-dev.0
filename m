Return-Path: <trini@kernel.crashing.org>
Received: from fed1rmmtao03.cox.net (fed1rmmtao03.cox.net [68.230.241.36])
	by ozlabs.org (Postfix) with ESMTP id E43882BC0F
	for <linuxppc-dev@ozlabs.org>; Tue, 21 Sep 2004 03:49:16 +1000 (EST)
Date: Mon, 20 Sep 2004 10:49:14 -0700
From: Tom Rini <trini@kernel.crashing.org>
To: Pantelis Antoniou <panto@intracom.gr>
Message-ID: <20040920174914.GM27914@smtp.west.cox.net>
References: <20040917100643.53011.qmail@web15608.mail.cnb.yahoo.com>
	<414AB4A7.2000807@intracom.gr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <414AB4A7.2000807@intracom.gr>
Cc: linuxppc-dev@ozlabs.org, Song Sam <samlinuxppc@yahoo.com.cn>
Subject: Re: Linux 2.6.x on 8xx status
List-Id: "Linux on PowerPC \(Including Embedded\) Developers Mail List"
	<linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Fri, Sep 17, 2004 at 12:55:51PM +0300, Pantelis Antoniou wrote:
> Song Sam wrote:
> > "Smith, Craig" <craig.d.smith@siemens.com> wrote:
> >  
> > 
> >>Right now, I just want to know if I should expect to
> >>see funny behavior from this particular source tree
> >>on an 8xx platform or should it work OK? Thanks so 
> >>much.
> > 
> > 
> > Well, as I have tested so far, 2.6.x can only work
> > right on 8xx with RAMDISK root file system. As for
> > NFS, still no luck.
> 
> Well it could have fooled me since I have it running
> right here...
> 
> Don't use the old etherner driver.

Note that the old SCC enet driver, in linuxppc-2.5 at least is 'OK'.
Not that it couldn't do with a cleanup and netdev person audit, but it's
functional enough for me and my rpxlite to mount a root fs.

-- 
Tom Rini
http://gate.crashing.org/~trini/
