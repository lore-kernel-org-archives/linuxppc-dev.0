Return-Path: <SRS0+c1240705dcc9916876b1+1451+infradead.org+dwmw2@canuck.srs.infradead.org>
Received: from canuck.infradead.org (canuck.infradead.org [209.217.80.40])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id E941BDDEF2
	for <linuxppc-dev@ozlabs.org>; Tue, 14 Aug 2007 21:53:28 +1000 (EST)
Subject: Re: [PATCH] Stop pmac_zilog from abusing 8250's device numbers.
From: David Woodhouse <dwmw2@infradead.org>
To: Olaf Hering <olaf@aepfle.de>
In-Reply-To: <20070814114931.GA13319@aepfle.de>
References: <1175610345.2665.15.camel@shinybook.infradead.org>
	<17938.57292.870224.132415@cargo.ozlabs.ibm.com>
	<20070814114931.GA13319@aepfle.de>
Content-Type: text/plain
Date: Tue, 14 Aug 2007 19:53:12 +0800
Message-Id: <1187092392.3707.74.camel@shinybook.infradead.org>
Mime-Version: 1.0
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

On Tue, 2007-08-14 at 13:49 +0200, Olaf Hering wrote:
> On Wed, Apr 04, Paul Mackerras wrote:
> 
> > David Woodhouse writes:
> > 
> > > There are proper device numbers registered for pmac_zilog now. Use them.
> 
> Which numbers?

shinybook /shiny/git/mtd-utils $ ls -l /dev/ttyPZ*
crw-rw---- 1 root uucp 204, 192 2007-08-13 11:48 /dev/ttyPZ0
crw-rw---- 1 root uucp 204, 193 2007-08-13 11:48 /dev/ttyPZ1

-- 
dwmw2
