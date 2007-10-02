Return-Path: <kou.ishizaki@toshiba.co.jp>
Received: from inet-tsb5.toshiba.co.jp (inet-tsb5.toshiba.co.jp [202.33.96.24])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id F3352DDEA2
	for <linuxppc-dev@ozlabs.org>; Tue,  2 Oct 2007 18:04:51 +1000 (EST)
Date: Tue, 02 Oct 2007 17:04:39 +0900 (JST)
Message-Id: <20071002.170439.-1300534196.kouish@swc.toshiba.co.jp>
To: arnd@arndb.de
Subject: Re: [PATCH 7/7] Celleb: update for PCI
In-Reply-To: <200709261409.32231.arnd@arndb.de>
From: Ishizaki Kou <kou.ishizaki@toshiba.co.jp>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Cc: linuxppc-dev@ozlabs.org, paulus@samba.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Arnd Bergmann <arnd@arndb.de> wrote:
> On Wednesday 26 September 2007, Ishizaki Kou wrote:
> > This is a patch kit to support PCI bus on Celleb with new "I/O routines
> > for PowerPC." External PCI on Celleb must do explicit synchronization
> > with devices (Bus has no automatic synchronization feature).
> 
> It seems you are duplicating a lot of
> arch/powerpc/platforms/cell/io-workarounds.c, in order to work around
> the same problem:

 (snip)

> Is there a way that we can make that code common? I guess there could be a
> file in arch/powerpc/sysdev that can handle this correctly for all hardware
> that requires this particular workaround (currently celleb and QS20, but
> potentially more).

Though I agree it's better to make code common, I hope to keep them
separate for now. Because I'm now developing PCI Express support and
it also uses io-workaround mechanism. I'll try to make them common in
this work.

Best regards,
Kou Ishizaki
