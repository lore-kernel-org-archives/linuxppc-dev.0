Return-Path: <SRS0+b64a804dd1b76801bb4b+1135+infradead.org+dwmw2@pentafluge.srs.infradead.org>
Received: from pentafluge.infradead.org (pentafluge.infradead.org
	[213.146.154.40])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 2DCE267BC7
	for <linuxppc-dev@ozlabs.org>; Mon,  2 Oct 2006 19:42:36 +1000 (EST)
Subject: Re: [PATCH] Use check_legacy_ioport() for ISAPnP
From: David Woodhouse <dwmw2@infradead.org>
To: Olaf Hering <olaf@aepfle.de>
In-Reply-To: <20061002093853.GA13880@aepfle.de>
References: <1159341535.3309.108.camel@pmac.infradead.org>
	<20060927081838.GA5984@aepfle.de>
	<1159361385.3309.118.camel@pmac.infradead.org>
	<20060927130525.GA7550@aepfle.de>  <20061002093853.GA13880@aepfle.de>
Content-Type: text/plain
Date: Mon, 02 Oct 2006 10:42:04 +0100
Message-Id: <1159782124.4801.10.camel@pmac.infradead.org>
Mime-Version: 1.0
Cc: paulus@samba.org, linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Mon, 2006-10-02 at 11:38 +0200, Olaf Hering wrote:
> 
> The new check in parport_pc_init() will prevent the probing of PCI
> devices. I guess the correct fix would be a sophisticated
> pmac_check_legacy_ioport() that checks if baseport is available on
> some PCI device:

That or only call check_legacy_ioport() when we're poking _gratuitously_
at legacy space, not when there's a properly-detected port.

-- 
dwmw2
