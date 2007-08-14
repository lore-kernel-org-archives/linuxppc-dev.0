Return-Path: <olaf@aepfle.de>
Received: from mail-out.m-online.net (mail-out.m-online.net [212.18.0.10])
	by ozlabs.org (Postfix) with ESMTP id DC78CDDEE6
	for <linuxppc-dev@ozlabs.org>; Wed, 15 Aug 2007 02:24:50 +1000 (EST)
Date: Tue, 14 Aug 2007 18:24:53 +0200
From: Olaf Hering <olaf@aepfle.de>
To: David Woodhouse <dwmw2@infradead.org>
Subject: Re: [PATCH] Stop pmac_zilog from abusing 8250's device numbers.
Message-ID: <20070814162453.GA14532@aepfle.de>
References: <1175610345.2665.15.camel@shinybook.infradead.org>
	<17938.57292.870224.132415@cargo.ozlabs.ibm.com>
	<20070814114931.GA13319@aepfle.de>
	<1187092392.3707.74.camel@shinybook.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
In-Reply-To: <1187092392.3707.74.camel@shinybook.infradead.org>
Cc: linuxppc-dev@ozlabs.org, Paul Mackerras <paulus@samba.org>,
	linux-kernel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Tue, Aug 14, David Woodhouse wrote:

> On Tue, 2007-08-14 at 13:49 +0200, Olaf Hering wrote:
> > On Wed, Apr 04, Paul Mackerras wrote:
> > 
> > > David Woodhouse writes:
> > > 
> > > > There are proper device numbers registered for pmac_zilog now. Use them.
> > 
> > Which numbers?
> 
> shinybook /shiny/git/mtd-utils $ ls -l /dev/ttyPZ*
> crw-rw---- 1 root uucp 204, 192 2007-08-13 11:48 /dev/ttyPZ0
> crw-rw---- 1 root uucp 204, 193 2007-08-13 11:48 /dev/ttyPZ1

I dont see 204:192 in devices.txt
