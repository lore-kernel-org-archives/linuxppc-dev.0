Return-Path: <sfalco@harris.com>
Received: from mlbe2k1.cs.myharris.net (mlbe2k1.cs.myharris.net
	[137.237.90.88]) by ozlabs.org (Postfix) with ESMTP id 3D6E7DDE10
	for <linuxppc-dev@ozlabs.org>; Sat, 10 Nov 2007 05:30:10 +1100 (EST)
Message-ID: <4734A72B.2070104@harris.com>
Date: Fri, 09 Nov 2007 13:30:03 -0500
From: "Steven A. Falco" <sfalco@harris.com>
MIME-Version: 1.0
To: linuxppc-dev@ozlabs.org
Subject: PPC440EPx on Sequoia: /proc/iomem acts weird
Content-Type: text/plain; charset=UTF-8; format=flowed
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

If I cat /proc/iomem on a Sequoia board, it never stops printing.  Here 
are the first 10 lines:

bash-3.00# head -10 /proc/iomem
e0000100-e000017f : usb
  e0000100-e000017f : musbhsfc_udc
e0000300-e000038f : ehci_hcd
180000000-18fffffff : /plb/pci@1eec00000
          1d0000000-1d0001fff : ndfc
          1d0000000-1d0001fff : ndfc
          1d0000000-1d0001fff : ndfc
          1d0000000-1d0001fff : ndfc
          1d0000000-1d0001fff : ndfc
          1d0000000-1d0001fff : ndfc

Basically, the last line (regarding the nand flash) keeps repeating 
"forever".

Is anyone else seeing this behavior?  My kernel is 2.6.23 with Xenomai 
patched in.

    Steve
