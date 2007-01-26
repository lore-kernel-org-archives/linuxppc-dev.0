Return-Path: <hch@lst.de>
Received: from mail.lst.de (verein.lst.de [213.95.11.210])
	(using TLSv1 with cipher EDH-RSA-DES-CBC3-SHA (168/168 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 8C0BEDE023
	for <linuxppc-dev@ozlabs.org>; Fri, 26 Jan 2007 14:00:02 +1100 (EST)
Date: Fri, 26 Jan 2007 03:59:55 +0100
From: Christoph Hellwig <hch@lst.de>
To: Geoff Levand <geoffrey.levand@am.sony.com>
Subject: Re: [PATCH 10/14] ps3: get firmware version
Message-ID: <20070126025955.GE18537@lst.de>
References: <45B81891.1010309@am.sony.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <45B81891.1010309@am.sony.com>
Cc: linuxppc-dev@ozlabs.org, paulus@samba.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Wed, Jan 24, 2007 at 06:40:17PM -0800, Geoff Levand wrote:
> Output the PS3 firmware version to dmesg and /proc/cpuinfo.

Do we really need to bloat /proc/cpuinfo with more information that's
totally platform-specific?  The file is enough of a mess already..
