Return-Path: <david-b@pacbell.net>
Received: from smtp122.sbc.mail.sp1.yahoo.com (smtp122.sbc.mail.sp1.yahoo.com
	[69.147.64.95]) by ozlabs.org (Postfix) with SMTP id 8114EDDFAA
	for <linuxppc-dev@ozlabs.org>; Wed, 10 Oct 2007 16:34:08 +1000 (EST)
From: David Brownell <david-b@pacbell.net>
To: linux-usb-devel@lists.sourceforge.net
Subject: Re: [linux-usb-devel] [PATCH 0/3] usb: ehci ppc device-tree-aware
	driver
Date: Tue, 9 Oct 2007 23:27:25 -0700
References: <20070924192519.GA4192@ru.mvista.com>
In-Reply-To: <20070924192519.GA4192@ru.mvista.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Message-Id: <200710092327.26109.david-b@pacbell.net>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Monday 24 September 2007, Valentine Barshak wrote:
> Some PowerPC systems have a built-in EHCI controller.
> This is a device tree aware version of the EHCI controller driver.
> Currently it's been tested on the PowerPC 440EPx Sequoia board.
> Other platforms can be added later.
> The code is based on the ehci-ppc-soc driver by Stefan Roese <sr@denx.de>.

Do PPC folk sign off on how this is done?

I don't follow all the ins/outs of the OF devtree stuff...
