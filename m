From: Eric.Oosterhof@radisys.com
Subject: Re: I2C module problem on 8260
To: linuxppc-dev@lists.linuxppc.org
Message-ID: <OF56E55080.7594F958-ON88256B66.006A2E6C@radisys.com>
Date: Wed, 20 Feb 2002 11:26:40 -0800
MIME-Version: 1.0
Content-type: text/plain; charset=us-ascii
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Wed, 13 Feb 2002 17:43:57 +1100, Murray Jensen <
Murray.Jensen@cmst.csiro.au> writes:
>Well, I have an i2c driver for the CPM which supports both 8xx and 8260
>(and potentially anything else that has a CPM) in the same source
(although
>I still haven't got around to testing the 8xx code). I avoid the issue
raised
>here by using kmalloc(). The code works fine as a loadable module, and it
>only allocates the dual port ram once, the first time the module is
loaded.
>Of course, it is called drivers/i2c/i2c{-algo,}cpm.c.

Yes, thanks for the responses.  That was my solution too, and it is now
working.  Next up, how to get it to respond as a slave.  My hardware has 4
8260's, and they communicate via I2C.  I want one CPU to be the I2C master
and the other 3 to be slaves.  Potentially, I could make them all masters,
but that might require SW mods to support the multi-master environment.  Is
anyone aware of either solution?

Eric.Oosterhof@RadiSys.com 503-615-1283
5445 NE Dawson Creek Drive
Hillsboro, Oregon, 97124
USA


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
