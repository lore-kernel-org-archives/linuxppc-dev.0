Subject: [PATCH] export m8xx_cpm_hostalloc
From: Andreas Oberritter <obi@saftware.de>
To: Tom Rini <trini@kernel.crashing.org>
Cc: linuxppc-embedded@lists.linuxppc.org
Content-Type: text/plain
Message-Id: <1090590567.3939.20.camel@localhost.localdomain>
Mime-Version: 1.0
Date: Fri, 23 Jul 2004 15:49:27 +0200
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Hi Tom,

to build an i2c driver as a module, m8xx_cpm_hostalloc must be exported.
We are using a driver which is not in the kernel tree[1]. I tried to
merge the in-kernel i2c driver with it, but I failed and don't have the
time to investigate why our driver works with the dbox2 board and the
in-kernel driver doesn't.

This function has been exported in 2.4. Is it ok to do that for 2.6,
too?

Regards,
Andreas

[1]:
http://cvs.tuxbox.org/cgi-bin/viewcvs.cgi/tuxbox/driver/i2c/dbox2_i2c.c?rev=1.28&content-type=text/vnd.viewcvs-markup


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
