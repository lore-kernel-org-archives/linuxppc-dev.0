Return-Path: <nd@bplan-gmbh.de>
Received: from mo-p07-ob.rzone.de (mo-p07-ob.rzone.de [81.169.146.189])
	by ozlabs.org (Postfix) with ESMTP id 77A4A67BDC
	for <linuxppc-dev@ozlabs.org>; Fri, 24 Nov 2006 03:13:08 +1100 (EST)
Date: Thu, 23 Nov 2006 17:11:59 +0100 (MET)
From: nd@bplan-gmbh.de
To: nd@bplan-gmbh.de
Subject: [RFC] USB OHCI glue for PowerPC/Openfirmware
Message-Id: <11642982453599-git-send-email-nd@bplan-gmbh.de>
Cc: linux-usb-devel@lists.sourceforge.net, greg@kroah.com, sl@bplan-gmbh.de,
	linuxppc-dev@ozlabs.org, stern@rowland.harvard.edu
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Theses patches add USB/OHCI HC glue for OpenFirmware. This allows to support any kind of USB/OHCI controller which is present in an OpenFirmware device tree.

By the way, I noticed that ohci-hcd.c module compilation is broken when multiple HC glues are selected. The glues sources files are directly include into ohci-hcd.c. Then, multiple module_init/exit in the same kmod cause compile issue. This news HC glue triggers this issue but is not the issue itself.
At least, this is how I understood the issue. I may be wrong but I just wanted to spot this issue.

Could you please review/comment this patch for submission in 2.6.20?

Regards 
