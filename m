Date: Wed, 25 Feb 2004 11:01:57 -0700
From: Tom Rini <trini@kernel.crashing.org>
To: Kanchana Sethu <kanasethu2002@yahoo.com>
Cc: linuxppc-dev@lists.linuxppc.org
Subject: Re: rtc access with i2c
Message-ID: <20040225180156.GV1052@smtp.west.cox.net>
References: <20040225013324.24285.qmail@web40514.mail.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20040225013324.24285.qmail@web40514.mail.yahoo.com>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Tue, Feb 24, 2004 at 05:33:24PM -0800, Kanchana Sethu wrote:

> I am developing a driver for an rtc chip on an
> embedded ppc platform that sits on the i2c bus.  Can I
> use the generic i2c primitives to access it or is it
> not available on that point in the boot process?

Yes, you can.  Take a look at
http://www.gihyo.co.jp/book/2004/640402/download/linux-2.6.0-test10-obs266.diff
and the x1226-rtc.c code in there.

--
Tom Rini
http://gate.crashing.org/~trini/

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
