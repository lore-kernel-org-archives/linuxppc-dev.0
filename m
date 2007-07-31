Return-Path: <alan@lxorguk.ukuu.org.uk>
Received: from the-village.bc.nu (unknown [81.2.110.250])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id EE315DDE29
	for <linuxppc-dev@ozlabs.org>; Wed,  1 Aug 2007 09:49:32 +1000 (EST)
Date: Wed, 1 Aug 2007 00:56:40 +0100
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Segher Boessenkool <segher@kernel.crashing.org>
Subject: Re: [PATCH 2/2] [POWERPC] MPC8349E-mITX: use platform IDE driver
	for CF	interface
Message-ID: <20070801005640.327226db@the-village.bc.nu>
In-Reply-To: <a414f3b506b7802a717e6e2c08befd1e@kernel.crashing.org>
References: <20070725165318.5331.23795.stgit@localhost.localdomain>
	<20070725165326.5331.19920.stgit@localhost.localdomain>
	<46A78322.3080607@ru.mvista.com> <46A78E3F.1030904@ru.mvista.com>
	<a414f3b506b7802a717e6e2c08befd1e@kernel.crashing.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: linuxppc-dev@ozlabs.org, linux-ide@vger.kernel.org,
	linux-kernel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

> The hardware is called (E)IDE, the protocol is called ATA.
> Or that's what I was told -- I think there's some historic
> revisionism involved, too.

ATA is the interface and standards for the ANSI standards based disk
attachment. IDE "Integrated Drive Electronics" is a marketing name used
to cover all sorts of ST412 compatible-ish early interfaces that moved
the brains onto the disk. IDE doesn't really mean much but "brains on
disk", ATA is a real standard.
