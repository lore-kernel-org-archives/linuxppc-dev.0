Return-Path: <glppe-linuxppc-embedded-2@m.gmane.org>
Received: from ciao.gmane.org (main.gmane.org [80.91.229.2])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 6DB77679EA
	for <linuxppc-embedded@ozlabs.org>;
	Thu, 27 Apr 2006 07:46:56 +1000 (EST)
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1FYrqJ-00042K-Un
	for linuxppc-embedded@ozlabs.org; Wed, 26 Apr 2006 23:46:40 +0200
Received: from icarus.icarus.com ([64.105.89.2])
	by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
	id 1AlnuQ-0007hv-00
	for <linuxppc-embedded@ozlabs.org>; Wed, 26 Apr 2006 23:46:39 +0200
Received: from steve by icarus.icarus.com with local (Gmexim 0.1 (Debian))
	id 1AlnuQ-0007hv-00
	for <linuxppc-embedded@ozlabs.org>; Wed, 26 Apr 2006 23:46:39 +0200
To: linuxppc-embedded@ozlabs.org
From: Stephen Williams <steve@icarus.com>
Subject: Xilinx SysACE drivers for Linux 2.4
Date: Wed, 26 Apr 2006 14:46:27 -0700
Message-ID: <e2opnj$gju$1@sea.gmane.org>
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


So I'm now looking at moving from my bk based linuxppc-2.4 devel
tree to the kernel.org sources, but the latter doesn't have the
Xilinx SystemACE drivers. Is there a repository for the latest
port (to kernel 2.4) of this driver, or should I just lift it
from the kernel tree I have?

Also, I'd be going from linuxppc-2.4.30-pre1 (or thereabouts) to
kernel.org 2.4.32. This is likely to be fine for my PPC405GPr, yes?

-- 
Steve Williams                "The woods are lovely, dark and deep.
steve at icarus.com           But I have promises to keep,
http://www.icarus.com         and lines to code before I sleep,
http://www.picturel.com       And lines to code before I sleep."
