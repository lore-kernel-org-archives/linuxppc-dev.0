Return-Path: <SRS0+65f9f841fcd8f70ddce6+1673+infradead.org+dwmw2@pentafluge.srs.infradead.org>
Received: from pentafluge.infradead.org (pentafluge.infradead.org
	[213.146.154.40])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 3AC2ADDE21
	for <linuxppc-dev@ozlabs.org>; Sun, 23 Mar 2008 20:00:50 +1100 (EST)
Subject: Re: crash in init_ipic_sysfs on efika
From: David Woodhouse <dwmw2@infradead.org>
To: Sven Luther <sven@genesi-usa.com>
In-Reply-To: <20080322152528.GA6272@powerlinux.fr>
References: <20080317195305.GA13298@aepfle.de>
	<fa686aa40803202214k7d8596a5y922a34f33d33dca2@mail.gmail.com>
	<18403.31214.826941.838442@cargo.ozlabs.ibm.com>
	<47E3B4AF.3030505@genesi-usa.com>
	<fa686aa40803211151w688a8d61sba9d0d0e6cdc7833@mail.gmail.com>
	<20080322152528.GA6272@powerlinux.fr>
Content-Type: text/plain
Date: Sun, 23 Mar 2008 09:00:41 +0000
Message-Id: <1206262841.9540.119.camel@pmac.infradead.org>
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

On Sat, 2008-03-22 at 16:25 +0100, Sven Luther wrote:
> BTW, it was reported to me that the ethernet drivers don't get
> autoloaded by udev. Is this a failure of udev missing the of_plateform
> support, or a deficiency of the ethernet drivers ? 

As far as I know, they _are_ being loaded properly. Otherwise, the
Fedora installer wouldn't work.

-- 
dwmw2
