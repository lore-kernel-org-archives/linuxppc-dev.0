Return-Path: <dan@embeddedalley.com>
Received: from smtp107.biz.mail.re2.yahoo.com (smtp107.biz.mail.re2.yahoo.com
	[206.190.52.176]) by ozlabs.org (Postfix) with SMTP id 16C1267CDE
	for <linuxppc-embedded@ozlabs.org>;
	Thu, 16 Nov 2006 02:18:15 +1100 (EST)
In-Reply-To: <528646bc0611150625u18b78d1akdaea088de27c0f9@mail.gmail.com>
References: <OFEE9EA5F5.4E12B948-ONC1257227.00338F27-C1257227.00343921@moog.com>
	<528646bc0611150625u18b78d1akdaea088de27c0f9@mail.gmail.com>
Mime-Version: 1.0 (Apple Message framework v752.2)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <492F0B19-8263-4177-ABF2-A6CD929F7B21@embeddedalley.com>
From: Dan Malek <dan@embeddedalley.com>
Subject: Re: BDI2000 with MPC5200 and userspace programs
Date: Wed, 15 Nov 2006 10:18:10 -0500
To: Grant Likely <grant.likely@secretlab.ca>
Cc: Erwin Haese <ehaese@moog.com>, linuxppc-embedded@ozlabs.org
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>


On Nov 15, 2006, at 9:25 AM, Grant Likely wrote:

> I don't think so, but why would you need to?

That's true.  It's so much easier to use gdbserver
or even native gdb on the system.  Unlike some
other embedded environments that require you
are tethered to the hardware debugger for all
development, Linux has the flexibility to provide
more powerful and easier to use tools.

The reason I added the BDI_SWITCH was to
track the user application page table of the
active thread.  This way, if you are debugging
some driver, you can trace back into the application
and glean some knowledge about what the
application did to get there.

> Ultimate solutions has a product that does this.

Which is really nice because you can get
all of the BDI support for kernel debugging,
then use the same IDE to support gdbserver
for application debugging.  Although the back
ends are different, the debugging environment
is consistent.

Thanks.

	-- Dan
