Return-Path: <olaf@aepfle.de>
Received: from mail-out.m-online.net (mail-out.m-online.net [212.18.0.10])
	by ozlabs.org (Postfix) with ESMTP id 98674DDED0
	for <linuxppc-dev@ozlabs.org>; Tue, 14 Aug 2007 21:49:30 +1000 (EST)
Date: Tue, 14 Aug 2007 13:49:31 +0200
From: Olaf Hering <olaf@aepfle.de>
To: Paul Mackerras <paulus@samba.org>
Subject: Re: [PATCH] Stop pmac_zilog from abusing 8250's device numbers.
Message-ID: <20070814114931.GA13319@aepfle.de>
References: <1175610345.2665.15.camel@shinybook.infradead.org>
	<17938.57292.870224.132415@cargo.ozlabs.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
In-Reply-To: <17938.57292.870224.132415@cargo.ozlabs.ibm.com>
Cc: linuxppc-dev@ozlabs.org, David Woodhouse <dwmw2@infradead.org>,
	linux-kernel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Wed, Apr 04, Paul Mackerras wrote:

> David Woodhouse writes:
> 
> > There are proper device numbers registered for pmac_zilog now. Use them.

Which numbers?

> Sigh.  I guess this is inevitable, but IMNSHO this exposes a weakness
> in our serial subsystem.

So, when will the name of pmac_zilog get changed?
What major/minor pair will the two ports get?
