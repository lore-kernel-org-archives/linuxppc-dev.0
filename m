Message-ID: <3B338FC9.558D2753@acm.org>
Date: Fri, 22 Jun 2001 11:34:49 -0700
From: Ira Weiny <iweiny@acm.org>
MIME-Version: 1.0
To: Linux1394dev <linux1394-devel@lists.sourceforge.net>,
	linuxppc-dev <linuxppc-dev@lists.linuxppc.org>
Subject: 1394(sbp2) working on TiBook
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Sorry I have been away for a bit...

Thanks to Ben Collins, your sbp2 patch worked great in getting my
Firewire drive up on the TiBook.

Therefore, I have a patch which _I_ _think_ makes the TiBook work with
sbp2.  I have mounted the drive copied files to it and rebooted to MacOS
and the files are fine.

However, my company has an anylizer on loan and I still think there are
endianess issues...  I see a lot of byte swapping in the sbp2 driver,
and I have not tried this on my x86 machine yet.  Sorry really busy
right now.

If anyone out there would like to do some testing I can give you a patch
against the current 1394 cvs tree.  This would include the sbp2 patches
from Ben as I did not separate them out...  Sorry for those on 2.2
kernels, I think this breaks you?

Still working,
Ira Weiny
iweiny@acm.org

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
