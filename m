From: "Todd_Tomaino"@vnci.net
To: linuxppc-embedded@lists.linuxppc.org
Message-ID: <85256A0A.0072CACC.00@ushq1.vnci.net>
Date: Fri, 9 Mar 2001 16:00:51 -0500
Subject: i2c w/ 2.2.14 on the RPXLite
Mime-Version: 1.0
Content-type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Hello,

I have recently converted from Montavista HHL 1.0 to 1.2.  When using the
new version I am having difficulties getting the i2c driver to load.  I
have selected it during "make config" and seen it link and compile during
"make dep" and "make zImage", but when I boot the RPXLite there is no sign
of the driver.  I have added printk messages to to iic.c to make the
loading more obvious, but it's not there.  Other drivers that appeared to
load before (spi for example) are also not present.   My problems are
compounded by the fact that I am a newbie.  If anyone has any information
it would be greatly appreciated.

best regards,

Todd


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
