Message-ID: <39DDDEB9.561F90BB@wtal.de>
Date: Fri, 06 Oct 2000 16:16:25 +0200
From: Christof Petig <christof.petig@wtal.de>
MIME-Version: 1.0
To: linuxppc-dev@lists.linuxppc.org
Subject: stock 2.4-test9 on an iBook: looks promising
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Hello,

after several weeks of frustration about the 'unreliable' rsync service
at ppc.samba.org (former linuxcare.com.au), I tried a stock 2.4-test9.
Sometimes the connection went down before one file was received (after 5
minutes timeout).

DMA works! though there's a mismatch between the config option
CONFIG_IDEDMA_PMAC_AUTO and the ifdefs in the file
(CONFIG_PMAC_IDEDMA_AUTO).
Backlight finally works!
Powering off on halt finally works again.
Gmac still works fine.
Sound hardware is not recognized (no message at all)

So this kernel looks promising (not only) as far as iBook compatibility
is concerned
   Christof

Though I experienced a crash after I loaded the usb modules (but without
any device attached).


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
