Date: Tue, 15 Jul 2003 07:12:29 -0700
From: Matt Porter <mporter@kernel.crashing.org>
To: Steve Boorman <steveb@baydel.com>
Cc: linuxppc-embedded@lists.linuxppc.org
Subject: Re: Hangup booting Linux on PPC440GP
Message-ID: <20030715071229.A6208@home.com>
References: <3F13FA14.16183.5C9485B@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <3F13FA14.16183.5C9485B@localhost>; from steveb@baydel.com on Tue, Jul 15, 2003 at 12:56:52PM +0100
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Please fix your mailer to set a lower linewrap value, it is
difficult to compose a reply.

On Tue, Jul 15, 2003 at 12:56:52PM +0100, Steve Boorman wrote:
> 1) Using ebony_defconfig as the kernel config file should, I would have thought, set
> CONFIG_MATH_EMULATION=y but it does not.

It assumes that one is using an optimized userland for 4xx.  This
means that the expectation is that you have soft-float binaries.
Most people are using ELDK or MVL.

> 3) I expected the kernel to panic with some form of illegal
> instruction trap if floating point instructions were being
> attempted with no emulator code present.

Good point.  Maybe we should add in an illegal instruction warning
on the no mathemu path in the 4xx program check exception.

Regards,
--
Matt Porter
mporter@kernel.crashing.org

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
