Message-ID: <20040227003331.9210.qmail@web40502.mail.yahoo.com>
Date: Thu, 26 Feb 2004 16:33:31 -0800 (PST)
From: Kanchana Sethu <kanasethu2002@yahoo.com>
Subject: I2c-id
To: linuxppc-embedded@lists.linuxppc.org
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Hi, I am writing an i2c driver for the STM41T11 on an
embedded PPC platform.  How does one request a unique
I2C_DRIVER_ID?

Reading through kernel/Documents/i2c/writing-clients
"struct i2c_driver foo_driver
  {
    /* name   */  "Foo version 2.3 and later driver",
    /* id     */  I2C_DRIVERID_FOO,

    <snip> <snip>
  }

The id should be a unique ID. The range 0xf000 to
0xffff is reserved for local use, and you can use
one of those until you start distributing the
driver. Before you do that, contact the i2c authors
to get your own ID(s)."

Who are the i2c authors?  How can I contact them for
this unique ID?

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
