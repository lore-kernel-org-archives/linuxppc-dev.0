Return-Path: <glppd-linuxppc64-dev@m.gmane.org>
Received: from ciao.gmane.org (main.gmane.org [80.91.229.2])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id C957EDDD0A
	for <linuxppc-dev@ozlabs.org>; Sun, 23 Sep 2007 09:00:54 +1000 (EST)
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1IZDxr-0007Mg-T1
	for linuxppc-dev@ozlabs.org; Sat, 22 Sep 2007 23:00:43 +0000
Received: from user-0vvdaf6.cable.mindspring.com ([63.246.169.230])
	by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
	id 1AlnuQ-0007hv-00
	for <linuxppc-dev@ozlabs.org>; Sat, 22 Sep 2007 23:00:43 +0000
Received: from hollisb by user-0vvdaf6.cable.mindspring.com with local (Gmexim
	0.1 (Debian)) id 1AlnuQ-0007hv-00
	for <linuxppc-dev@ozlabs.org>; Sat, 22 Sep 2007 23:00:43 +0000
To: linuxppc-dev@ozlabs.org
From: Hollis Blanchard <hollisb@us.ibm.com>
Subject: Re: [PATCH 0/3] usb: ehci ppc device-tree-aware driver
Date: Sat, 22 Sep 2007 23:00:35 +0000 (UTC)
Message-ID: <fd46qj$s6r$1@sea.gmane.org>
References: <20070917125039.GA29525@ru.mvista.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: news <news@sea.gmane.org>
Cc: linux-usb-devel@lists.sourceforge.net
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Mon, 17 Sep 2007 16:50:39 +0400, Valentine Barshak wrote:

> Some PowerPC systems have a built-in EHCI controller.
> This is a device tree aware version of the EHCI controller driver.
> Currently it's been tested on the PowerPC 440EPx Sequoia board.
> Other platforms can be added later.
> The code is based on the ehci-ppc-soc driver by Stefan Roese <sr@denx.de>.

We're having a strange issue on our Sequoia where the network stops
functioning when USB is active. Jerone can supply more detail...

Have you seen anything like that?

-- 
Hollis Blanchard
IBM Linux Technology Center
