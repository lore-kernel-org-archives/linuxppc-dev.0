Return-Path: <glppe-linuxppc-embedded-2@m.gmane.org>
Received: from ciao.gmane.org (main.gmane.org [80.91.229.2])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 090EE679EA
	for <linuxppc-embedded@ozlabs.org>;
	Thu, 23 Mar 2006 08:00:27 +1100 (EST)
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1FMAR9-0000LK-IO
	for linuxppc-embedded@ozlabs.org; Wed, 22 Mar 2006 22:00:11 +0100
Received: from mail.toimi.com ([208.45.127.50])
	by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
	id 1AlnuQ-0007hv-00
	for <linuxppc-embedded@ozlabs.org>; Wed, 22 Mar 2006 22:00:11 +0100
Received: from dave by mail.toimi.com with local (Gmexim 0.1 (Debian))
	id 1AlnuQ-0007hv-00
	for <linuxppc-embedded@ozlabs.org>; Wed, 22 Mar 2006 22:00:11 +0100
To: linuxppc-embedded@ozlabs.org
From: David Updegraff <dave@cray.com>
Subject: swizzling pci irqs
Date: Wed, 22 Mar 2006 14:59:50 -0600
Message-ID: <dvsds7$ta0$1@sea.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Sender: news <news@sea.gmane.org>
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Hi.

If there were a noswizzle option to the kernel command line that
resulted in pci scan simply trusting that the bootrom/u-boot had already
correctly assigned the PCI irqs....  every tom,dick,harry, and
yours-truly wouldn't have to make a new platform to define the
swizzle-o-the-day.  Or have I already missed this argument?

-dbu
