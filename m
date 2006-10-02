Return-Path: <olaf@ibook.aepfle.de>
Received: from natklopstock.rzone.de (natklopstock.rzone.de [81.169.145.174])
	by ozlabs.org (Postfix) with ESMTP id E86F467BB4
	for <linuxppc-dev@ozlabs.org>; Mon,  2 Oct 2006 20:00:54 +1000 (EST)
Date: Mon, 2 Oct 2006 12:00:50 +0200
From: Olaf Hering <olaf@aepfle.de>
To: David Woodhouse <dwmw2@infradead.org>
Subject: Re: [PATCH] Use check_legacy_ioport() for ISAPnP
Message-ID: <20061002100050.GA14083@aepfle.de>
References: <1159341535.3309.108.camel@pmac.infradead.org>
	<20060927081838.GA5984@aepfle.de>
	<1159361385.3309.118.camel@pmac.infradead.org>
	<20060927130525.GA7550@aepfle.de>
	<20061002093853.GA13880@aepfle.de>
	<1159782124.4801.10.camel@pmac.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
In-Reply-To: <1159782124.4801.10.camel@pmac.infradead.org>
Cc: paulus@samba.org, linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Mon, Oct 02, David Woodhouse wrote:

> On Mon, 2006-10-02 at 11:38 +0200, Olaf Hering wrote:
> > 
> > The new check in parport_pc_init() will prevent the probing of PCI
> > devices. I guess the correct fix would be a sophisticated
> > pmac_check_legacy_ioport() that checks if baseport is available on
> > some PCI device:
> 
> That or only call check_legacy_ioport() when we're poking _gratuitously_
> at legacy space, not when there's a properly-detected port.

It is CONFIG_PARPORT_PC_SUPERIO=y that is causing trouble. Lets see what
lkml has to say about this config option.
