Return-Path: <Geoffrey.Levand@am.sony.com>
Received: from outbound1-cpk-R.bigfish.com (outbound-cpk.frontbridge.com
	[207.46.163.16])
	(using TLSv1 with cipher EDH-RSA-DES-CBC3-SHA (168/168 bits))
	(Client CN "*.bigfish.com", Issuer "*.bigfish.com" (not verified))
	by ozlabs.org (Postfix) with ESMTP id 61D85DDED9
	for <linuxppc-dev@ozlabs.org>; Sat, 10 Feb 2007 03:14:46 +1100 (EST)
Message-ID: <45CC9DDC.2060305@am.sony.com>
Date: Fri, 09 Feb 2007 08:14:20 -0800
From: Geoff Levand <geoffrey.levand@am.sony.com>
MIME-Version: 1.0
To: Al Viro <viro@ftp.linux.org.uk>
Subject: Re: [PATCH] ps3 usb missed the addition of new argument
	to	ps3_alloc_io_irq()
References: <E1HFYFg-0004rz-19@ZenIV.linux.org.uk>
In-Reply-To: <E1HFYFg-0004rz-19@ZenIV.linux.org.uk>
Content-Type: text/plain; charset=UTF-8
Cc: linuxppc-dev@ozlabs.org, torvalds@linux-foundation.org,
	linux-kernel@vger.kernel.org, greg@kroah.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Al Viro wrote:
> Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>

Greg had this same change queued for his usb tree.

Acked-by: Geoff Levand <geoffrey.levand@am.sony.com>
