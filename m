Mime-Version: 1.0 (Apple Message framework v613)
Message-Id: <3AB702B8-84D1-11D8-9FF0-000A95A07384@sands-edge.com>
Content-Type: text/plain; charset=US-ASCII; format=flowed
To: Linux/PPC Development <linuxppc-dev@lists.linuxppc.org>
From: John Whitney <jwhitney-linuxppc@sands-edge.com>
Subject: How did the 2.6 kernel headers get so screwed up?
Date: Fri, 2 Apr 2004 13:11:57 -0500
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


The title says it all.

I have a program I wrote to interface with the i2c bus.  It includes
<linux/i2c.h> in order to get the I2C_SLAVE ioctl value, necessary to
set the slave address.

In 2.4 this works beautifully.  Now, in 2.6, I get boatloads of errors:
redefinitions, admonishments not to use kernel headers from user
programs, missing constants, you name it.

And this has happened to me in more than one standard unix application
(strace, syslogd, etc.).

Is there a paradigm shift going on?  What happened to conditional
__KERNEL__ code hiding all the non-userspace-related stuff in the
header files?  The linux-kernel list seems to just say "kernel header
files shouldn't be used by user-space programs!".  It would be nice if
they came up with "here's a top-level include directory just for
userspace/kernel interfaces!", but I don't see that either.

Am I supposed to submit kernel interface files (device driver ioctl()
values, for example) to glibc somehow now?

John


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
