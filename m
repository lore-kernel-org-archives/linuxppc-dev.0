Date: Tue, 7 May 2002 11:33:04 -0700
From: andrew may <acmay@acmay.homeip.net>
To: Armin <akuster@pacbell.net>
Cc: linuxppc-embedded@lists.linuxppc.org
Subject: [PATCH]IBM OCP I2C
Message-ID: <20020507113304.A22181@ecam.san.rr.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Here is a patch that provides a new iic_xfer function. It is
inside of a #if 1 and all the code it should replace is in the
#else clause.

I have not been gotten to test the stuff from user space and I have
not checked the return values of the function yet. I don't know
how I can test failure conditions on the bus itself either.

I have been sucked into doing some other stuff recently but seeing
how others are starting to play with this now I though I should get
this out there again.

There is also a fix in iic_ibmocp_init for some unused/unitilized
vars.

I also removed some unneeded #if MODULE's.

I did not pull out my clk div stuff so that part of the patch
can be dropped.

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
