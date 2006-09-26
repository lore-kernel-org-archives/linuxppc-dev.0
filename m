Return-Path: <olaf@ibook.aepfle.de>
Received: from natlemon.rzone.de (natlemon.rzone.de [81.169.145.170])
	by ozlabs.org (Postfix) with ESMTP id 7F56567B9B
	for <linuxppc-dev@ozlabs.org>; Tue, 26 Sep 2006 15:33:54 +1000 (EST)
Date: Tue, 26 Sep 2006 07:32:34 +0200
From: Olaf Hering <olaf@aepfle.de>
To: Olof Johansson <olof@lixom.net>
Subject: Re: [POWERPC] iSeries has no legacy I/O
Message-ID: <20060926053234.GA27474@aepfle.de>
References: <20060926135721.50f7f1b0.sfr@canb.auug.org.au>
	<20060926000616.5ece9149@pb15>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
In-Reply-To: <20060926000616.5ece9149@pb15>
Cc: Stephen Rothwell <sfr@canb.auug.org.au>, paulus@samba.org, arnd@arndb.de,
	ppc-dev <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Tue, Sep 26, Olof Johansson wrote:

> This will break floppy and 8042 on platforms that previously did not
> define it and relied on the default being that it was allowed. I'm not
> sure which ones that would be?  Getting it in early would give us
> plenty of time to deal with fallout, if any.

chrp32 and prep at least.
