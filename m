Return-Path: <Geoffrey.Levand@am.sony.com>
Received: from outbound1-dub-R.bigfish.com (outbound-dub.frontbridge.com
	[213.199.154.16])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "*.bigfish.com", Issuer "*.bigfish.com" (not verified))
	by ozlabs.org (Postfix) with ESMTP id AE5F6DDEF5
	for <linuxppc-dev@ozlabs.org>; Wed, 15 Aug 2007 02:40:14 +1000 (EST)
Message-ID: <46C1DACF.6040101@am.sony.com>
Date: Tue, 14 Aug 2007 09:39:43 -0700
From: Geoff Levand <geoffrey.levand@am.sony.com>
MIME-Version: 1.0
To: Geert Uytterhoeven <Geert.Uytterhoeven@sonycom.com>
Subject: Re: [PATCH] ps3: Fix no storage devices found
References: <46C0FDC0.6000503@am.sony.com> <20070814123227.GA18886@suse.de>
	<20070814143537.GA21308@suse.de>
	<20070814152651.GA22182@suse.de> <46C1D0D6.7030403@am.sony.com>
	<Pine.LNX.4.62.0708141828170.3886@pademelon.sonytel.be>
In-Reply-To: <Pine.LNX.4.62.0708141828170.3886@pademelon.sonytel.be>
Content-Type: text/plain; charset=UTF-8
Cc: Linux/PPC Development <linuxppc-dev@ozlabs.org>,
	Hiroyuki Machida <Hiroyuki.Machida@jp.sony.com>,
	Andrew Morton <akpm@linux-foundation.org>, Olaf Hering <olh@suse.de>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Geert Uytterhoeven wrote:
> Fix probing of PS3 storage devices: in the success case, we should set `error'
> to zero, not `result'.
> 
> Without this patch no storage devices are found.
> 
> Signed-off-by: Geert Uytterhoeven <Geert.Uytterhoeven@sonycom.com>
> ---
> This brown paper bag bug slipped in due to bad patch splitting.
> Please apply as soon as possible. Thanks!

Looks good.

Acked-by: Geoff Levand <geoffrey.levand@am.sony.com>
