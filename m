Return-Path: <sven@powerlinux.fr>
Received: from archon.plz.fr (archon.plz.fr [194.50.78.210])
	by ozlabs.org (Postfix) with ESMTP id 5EBE1DDE1E
	for <linuxppc-dev@ozlabs.org>; Sun, 23 Mar 2008 21:12:17 +1100 (EST)
Date: Sun, 23 Mar 2008 11:12:15 +0100
From: Sven Luther <sven@genesi-usa.com>
To: David Woodhouse <dwmw2@infradead.org>
Subject: Re: crash in init_ipic_sysfs on efika
Message-ID: <20080323101215.GA26361@powerlinux.fr>
References: <20080317195305.GA13298@aepfle.de>
	<fa686aa40803202214k7d8596a5y922a34f33d33dca2@mail.gmail.com>
	<18403.31214.826941.838442@cargo.ozlabs.ibm.com>
	<47E3B4AF.3030505@genesi-usa.com>
	<fa686aa40803211151w688a8d61sba9d0d0e6cdc7833@mail.gmail.com>
	<20080322152528.GA6272@powerlinux.fr>
	<1206262841.9540.119.camel@pmac.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1206262841.9540.119.camel@pmac.infradead.org>
Cc: Sven Luther <sven@genesi-usa.com>, Olaf Hering <olaf@aepfle.de>,
	Paul Mackerras <paulus@samba.org>, linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Sun, Mar 23, 2008 at 09:00:41AM +0000, David Woodhouse wrote:
> On Sat, 2008-03-22 at 16:25 +0100, Sven Luther wrote:
> > BTW, it was reported to me that the ethernet drivers don't get
> > autoloaded by udev. Is this a failure of udev missing the of_plateform
> > support, or a deficiency of the ethernet drivers ? 
> 
> As far as I know, they _are_ being loaded properly. Otherwise, the
> Fedora installer wouldn't work.

Yes, but you probably have the of_plateform udev patch, no ? 

Friendly,

Sven Luther
