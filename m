Return-Path: <alan@lxorguk.ukuu.org.uk>
Received: from lxorguk.ukuu.org.uk (unknown [81.2.110.250])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id BAA3BDDF4B
	for <linuxppc-dev@ozlabs.org>; Fri, 12 Jan 2007 21:12:59 +1100 (EST)
Date: Fri, 12 Jan 2007 10:24:06 +0000
From: Alan <alan@lxorguk.ukuu.org.uk>
To: Akira Iguchi <akira2.iguchi@toshiba.co.jp>
Subject: Re: [PATCH 0/4] drivers/ata: add low-level I/O calls
Message-ID: <20070112102406.6eb9374f@localhost.localdomain>
In-Reply-To: <200701120958.l0C9wICB019343@toshiba.co.jp>
References: <200701120958.l0C9wICB019343@toshiba.co.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: arnd@arndb.de, linuxppc-dev@ozlabs.org, linux-ide@vger.kernel.org,
	paulus@samba.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Fri, 12 Jan 2007 19:00:45 +0900
Akira Iguchi <akira2.iguchi@toshiba.co.jp> wrote:

> Dear everyone,
> 
> This is the patchset (based on 2.6.20-rc4) to add low-level I/O calls
> which access the taskfile registers. The idea comes from drivers/ide
> IN*/OUT* calls.

I think this is the wrong approach. The existing code provides methods
for things like "read the status", "write a taskfile" and this is the
style that should be kept.

Alan
