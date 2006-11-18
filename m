Return-Path: <glppe-linuxppc-embedded-2@m.gmane.org>
Received: from ciao.gmane.org (main.gmane.org [80.91.229.2])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id BDA9F67BE1
	for <linuxppc-embedded@ozlabs.org>;
	Sat, 18 Nov 2006 14:08:15 +1100 (EST)
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1GlFkU-0008M1-Cm
	for linuxppc-embedded@ozlabs.org; Sat, 18 Nov 2006 03:16:06 +0100
Received: from icarus.icarus.com ([64.105.89.2])
	by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
	id 1AlnuQ-0007hv-00
	for <linuxppc-embedded@ozlabs.org>; Sat, 18 Nov 2006 03:16:06 +0100
Received: from steve by icarus.icarus.com with local (Gmexim 0.1 (Debian))
	id 1AlnuQ-0007hv-00
	for <linuxppc-embedded@ozlabs.org>; Sat, 18 Nov 2006 03:16:06 +0100
To: linuxppc-embedded@ozlabs.org
From: Stephen Williams <steve@icarus.com>
Subject: Linux compatible embedded MMC/SD interfaces
Date: Fri, 17 Nov 2006 18:15:56 -0800
Message-ID: <ejlqct$pi2$1@sea.gmane.org>
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


I'm looking for a Linux (PPC) compatible solution for connecting
MMC or SD cards to an embedded system we are working on. We are
currently using a Xilinx SystemACE in our board, but we are putting
together a reduced size version of the board (We do not need the
"ACE" functionality) and still want to keep a Linux system on
removable media for quick field upgrades.

Any suggestions out there?

-- 
Steve Williams                "The woods are lovely, dark and deep.
steve at icarus.com           But I have promises to keep,
http://www.icarus.com         and lines to code before I sleep,
http://www.picturel.com       And lines to code before I sleep."
