Return-Path: <SRS0+65f9f841fcd8f70ddce6+1673+infradead.org+dwmw2@pentafluge.srs.infradead.org>
Received: from pentafluge.infradead.org (pentafluge.infradead.org
	[213.146.154.40])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 1F454DDE45
	for <linuxppc-dev@ozlabs.org>; Sun, 23 Mar 2008 21:13:27 +1100 (EST)
Subject: Re: crash in init_ipic_sysfs on efika
From: David Woodhouse <dwmw2@infradead.org>
To: Sven Luther <sven@genesi-usa.com>
In-Reply-To: <20080323101215.GA26361@powerlinux.fr>
References: <20080317195305.GA13298@aepfle.de>
	<fa686aa40803202214k7d8596a5y922a34f33d33dca2@mail.gmail.com>
	<18403.31214.826941.838442@cargo.ozlabs.ibm.com>
	<47E3B4AF.3030505@genesi-usa.com>
	<fa686aa40803211151w688a8d61sba9d0d0e6cdc7833@mail.gmail.com>
	<20080322152528.GA6272@powerlinux.fr>
	<1206262841.9540.119.camel@pmac.infradead.org>
	<20080323101215.GA26361@powerlinux.fr>
Content-Type: text/plain
Date: Sun, 23 Mar 2008 10:13:12 +0000
Message-Id: <1206267193.9540.137.camel@pmac.infradead.org>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org, Olaf Hering <olaf@aepfle.de>,
	Paul Mackerras <paulus@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Sun, 2008-03-23 at 11:12 +0100, Sven Luther wrote:
> On Sun, Mar 23, 2008 at 09:00:41AM +0000, David Woodhouse wrote:
> > On Sat, 2008-03-22 at 16:25 +0100, Sven Luther wrote:
> > > BTW, it was reported to me that the ethernet drivers don't get
> > > autoloaded by udev. Is this a failure of udev missing the of_plateform
> > > support, or a deficiency of the ethernet drivers ? 
> > 
> > As far as I know, they _are_ being loaded properly. Otherwise, the
> > Fedora installer wouldn't work.
> 
> Yes, but you probably have the of_plateform udev patch, no ? 

Not any more. That was merged a while ago, wasn't it?

-- 
dwmw2
