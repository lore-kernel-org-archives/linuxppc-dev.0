Date: Tue, 7 May 2002 09:16:25 -0700
From: andrew may <acmay@acmay.homeip.net>
To: Kenneth Johansson <kenneth.johansson@etx.ericsson.se>
Cc: linuxppc-embedded@lists.linuxppc.org, kuster@pacbell.net,
	acmay@acmay.homeip.ne
Subject: Re: IBM ocp I2C circular dependency
Message-ID: <20020507091625.B9190@ecam.san.rr.com>
References: <3CD7D04C.1E9122A0@etx.ericsson.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <3CD7D04C.1E9122A0@etx.ericsson.se>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


On Tue, May 07, 2002 at 03:02:04PM +0200, Kenneth Johansson wrote:
> Also I found a problem with the code when I access a i2c memory from
> userspace and no chip is present at that address. After that it's not
> possible to access anything else on the I2C bus. Works OK as long as I use
> addresses that have a device that answers (I think).

There is a suprising lack of copy to/from user functions in the i2c
code. This may be part of the problem but I think it needs to be fixed
more in the core code rather than each driver.

The driver should not support "Quick" 0 len transfers, I am not sure how
it handles them now. This may be another problem.

ps you forgot a "t" in .net.

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
