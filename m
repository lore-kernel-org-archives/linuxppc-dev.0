Message-ID: <3CD23B61.869488A2@ardistech.com>
Date: Fri, 03 May 2002 09:25:21 +0200
From: "bart@ardistech.com" <bart@ardistech.com>
Reply-To: bart@ardistech.com
MIME-Version: 1.0
To: Wolfgang Denk <wd@denx.de>
Cc: Embedded Linux PPC List <linuxppc-embedded@lists.linuxppc.org>,
	dmalek@jlc.net
Subject: Re: MP8xx: not initialized CPM RAM crash
References: <20020503064038.64A6111952@denx.denx.de>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Wolfgang Denk wrote:
>
> In message <3CD2255B.330FA4E4@ardistech.com> you wrote:
> >
> > I found in ./drivers/i2c/i2c-rpx.c in rpx_iic_init the structure member
> > ii->iic_rpbase != 0. Very likely because ppcboot uses this area as initial
> > stack. This causes the kernel to get a machine check during i2c init. Should
> > the CPM RAM not be zero'd somewhere during kernel boot?
>
> Which kernel version are you talking about?
>
2.4.2 MontaVista HH linux

> I think we fixed this in our version of the 8xx I2C driver long ago.
>
Thanks, I'll check out a newer kernel.

	Bart

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
