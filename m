Date: Tue, 23 Apr 2002 20:01:27 -0700
From: andrew may <acmay@acmay.homeip.net>
To: linuxppc-embedded <linuxppc-embedded@lists.linuxppc.org>
Subject: [PATCH] IBM ocp I2C
Message-ID: <20020423200127.G20394@ecam.san.rr.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Would anyone be heartbroken if "struct i2c_algo_iic_data" went
away completely?

In this patch I dump getown and getclock because they aren't
used and I am sure there is a better way to do things.

Also calculate the I2C div value from the clock rate. I am
not sure if that will work on all 4xx types but it does the
right thing for my 405's.

I also fixed a few C++ style comments.

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
