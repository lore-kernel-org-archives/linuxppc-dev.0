Message-ID: <20020429004945.83544.qmail@web14804.mail.yahoo.com>
Date: Sun, 28 Apr 2002 17:49:45 -0700 (PDT)
From: Aurel Wisse <aurel_wisse@yahoo.com>
Subject: Sungem with iMac Rev-B
To: linuxppc-dev@lists.linuxppc.org,
	yddev <yellowdog-devel@lists.terrasoftsolutions.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Crossposted yellowdog-devel/linuxppc-devel, sorry but
this is last ditch...

I have read several comments about the sungem driver
being preferred to the bmac(+) driver.

Going through the sourcecode of the sungem, I am not
sure however that it will work with older hardware
like the iMac Rev-B's Uni-North and the LXT970.

I am trying to modify the bmac to force the PHY to
abandon autonegotiation and to use 10Mb/s and half
duplex. "Reverse engineering" the bmac code leads
nowhere. The bmac_init_phy doesn't give a lot of info,
except a couple of undocumented constants written via
bmac_mif_write, and the mif_write writes to the MIFCSR
register which is undocumented in the bmac.h file.

This is terribly frustrating as Apple is obviously
able to do it with their Duplex tool hack. Hence, it
*can* be done. Why can't they just send us their
sourcecode for the Duplex tool? Does anybody have a
direct line to Apple?

Aurel

Yahoo! Health - your guide to health and wellness
http://health.yahoo.com

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
